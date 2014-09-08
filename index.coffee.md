Routing
=======

It's a module to manage requests and responses from the outside (`HTTP` or client request).

	'use strict'

	[utils, expect, log] = ['utils', 'expect', 'log'].map require

	log = log.scope 'Routing'

Implementation
--------------

Internal *Routing* class is automatically implemented by the platform-based implementation.
New instance of implemented *Routing* is returned.

	impl = switch true
		when utils.isNode
			require './impls/node/index.coffee'
		when utils.isBrowser
			require './impls/browser/index.coffee'
		when utils.isQML
			require './impls/qml/index.coffee'

	log.error "No routing implementation found" unless impl

*class* Routing
---------------

	module.exports = class Routing

### Static

#### Submodules

		@Uri = require('./uri.coffee.md') Routing, impl.Uri
		@Handler = require('./handler.coffee.md') Routing, impl.Handler
		@Request = require('./request.coffee.md') Routing, impl.Request
		@Response = require('./response.coffee.md') Routing, impl.Response

#### METHODS

		@METHODS = [
			(@GET = 'get'),
			(@POST = 'post'),
			(@PUT = 'put'),
			(@DELETE = 'delete'),
			(@OPTIONS = 'options')
		]

### Constructor

		constructor: (opts) ->

			expect(opts).toBe.simpleObject()
			expect(opts.protocol).toBe.truthy().string()
			expect(opts.port).toBe.integer()
			expect(opts.host).toBe.truthy().string()
			expect(opts.language).toBe.truthy().string()

			@_handlers = {}
			{@protocol, @port, @host, @language} = opts

			@url = "#{@protocol}://#{@host}:#{@port}/"

			setImmediate => impl.init.call @

			log.info "Start as `#{@host}:#{@port}`"

### Properties

		_handlers: null

		protocol: 'http'
		port: 0
		host: ''
		language: ''
		url: ''

### Methods

#### createHandler(*Number*, *String*, *Function*)

		createHandler: (method, uri, callback) ->

			if utils.isObject method
				{method, uri, schema, callback} = method

			uri = new Routing.Uri uri

			handler = new Routing.Handler
				method: method
				uri: uri
				schema: schema
				callback: callback

			stack = @_handlers[method] ?= []
			stack.push handler

			log.info "New handler `#{handler}` registered"

			handler

#### request(*Object*, *Function*)

		request: (opts, callback) ->

			expect(opts).toBe.simpleObject()
			expect(callback).toBe.function()

			opts.method ?= Routing.GET
			opts.uri ?= ''
			opts.data ?= null

			opts.url = "#{@url}#{opts.uri}"

			opts.uid = utils.uid()
			req = new Routing.Request opts

			impl.sendRequest.call @, opts, (status, data) ->

				req.pending = false

				resp = new Routing.Response
					req: req
					status: status
					data: data

				args = [null]
				args[resp.isSucceed()|0] = resp
				callback args...

			req

#### *Response* handleRequest(*Object*)

		handleRequest: (opts) ->

			expect(opts).toBe.simpleObject()

			logtime = log.time 'new request'
			log "Resolve `#{JSON.stringify(opts)}` request"

			# create request
			req = new Routing.Request opts

			# create response
			res = new Routing.Response req: req

			# get handlers
			onError = ->
					res.raise Routing.Response.Error.RequestResolve req
					log.end logtime

			handlers = @_handlers[req.method]
			if handlers
				# run handlers
				utils.async.forEach handlers, (handler, i, handlers, next) ->

					handler.exec req, res, (err) ->
						if err then return next()
						log.end logtime

				, onError
			else
				onError()

			res