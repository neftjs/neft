Routing
=======

It's a module to manage requests and responses from the outside (`HTTP` or client request).

	'use strict'

	[assert, utils, log] = ['assert', 'utils', 'log'].map require

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

	assert impl, "No routing implementation found"

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
			(@GET = 1),
			(@POST = 2),
			(@PUT = 3),
			(@DELETE = 4)
		]

### Constructor

		constructor: (opts) ->

			assert utils.isObject opts
			assert opts.protocol and typeof opts.protocol is 'string'
			assert opts.port is (opts.port|0)
			assert opts.host and typeof opts.host is 'string'
			assert opts.language and typeof opts.language is 'string'

			@_handlers = {}
			{@protocol, @port, @host, @language} = opts

			impl.init.call @

			log.info "Start listening on #{@host}:#{@port}"

### Properties

		_handlers: null

		protocol: 'http'
		port: 0
		host: ''
		language: ''

### Methods

#### on(*Number*, *Object*, *Function*)

		on: (method, opts, listener) ->

			if typeof opts isnt 'object'
				opts = uri: opts

			assert ~Routing.METHODS.indexOf(method)
			assert utils.isObject opts
			assert opts.uri and typeof opts.uri is 'string'
			assert typeof listener is 'function'

			opts.uri = new Routing.Uri opts.uri

			stack = @_handlers[method] ?= []

			stack.push handler = new Routing.Handler
				method: method
				uri: opts.uri
				schema: opts.schema
				listener: listener

			log.info "New handler `#{handler}` registered"

#### *Response* request(*Object*)

		request: (opts) ->

			assert utils.isObject opts

			logtime = log.time 'request'
			log "Resolve #{JSON.stringify(opts)} request"

			# create request
			req = Routing.Request.factory opts

			# create response
			res = Routing.Response.factory req

			# resolve request
			loop

				# get handlers
				handlers = @_handlers[req.method]
				unless handlers
					res.raise Routing.Response.Error.RequestResolve req
					log.end logtime
					break

				# run handlers
				utils.async.forEach handlers, (handler, i, handlers, next) ->

					handler.exec req, res, (err) ->
						if err then next()
						else log.end logtime

				, ->
					res.raise Routing.Response.Error.RequestResolve req
					log.end logtime

				break

			res