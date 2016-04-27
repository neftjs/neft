Networking @engine
==================

This module cares about communication client-server and client internally.

Currently only the HTTP protocol is supported.

Access it with:
```javascript
var Networking = require('networking');
```

	'use strict'

	utils = require 'neft-utils'
	signal = require 'neft-signal'
	assert = require 'neft-assert'
	log = require 'neft-log'
	List = require 'neft-list'

	assert = assert.scope 'Networking'
	log = log.scope 'Networking'

	module.exports = class Networking extends signal.Emitter

		Impl = require('./impl') Networking

		@Uri = require('./uri.coffee.md') Networking
		@Handler = require('./handler.coffee.md') Networking
		@Request = require('./request.coffee.md') Networking, Impl.Request
		@Response = require('./response.coffee.md') Networking, Impl.Response

		@TYPES = [
			(@HTTP = 'http')
		]

*Networking* Networking(*Object* options)
-----------------------------------------

		constructor: (opts) ->
			assert.isPlainObject opts, 'ctor options argument ....'
			assert.isString opts.type, 'ctor options.type argument ...'
			assert.ok utils.has(Networking.TYPES, opts.type)
			assert.isString opts.protocol, 'ctor options.protocol argument ...'
			assert.notLengthOf opts.protocol, 0, 'ctor options.protocol argument ...'
			assert.isInteger opts.port, 'ctor options.port argument ...'
			assert.isString opts.host, 'ctor options.host argument ...'
			assert.isString opts.language, 'ctor options.language argument ...'
			assert.notLengthOf opts.language, 0, 'ctor options.language argument ...'

			utils.defineProperty @, '_handlers', utils.CONFIGURABLE, {}
			{@type, @protocol, @port, @host, @language} = opts
			@pendingRequests = new List

			if opts.url?
				assert.isString opts.url
				assert.notLengthOf opts.url, 0
				url = opts.url
				if url[url.length - 1] is '/'
					url = url.slice 0, -1
			else
				url = "#{@protocol}://#{@host}:#{@port}"
			utils.defineProperty @, 'url', utils.ENUMERABLE, url

			setImmediate => Impl.init @
			log.info "Start as `#{@host}:#{@port}`"

			super()

			Object.freeze @

		type: @HTTP

*Signal* Networking::onRequest(*Networking.Request* request, *Networking.Response* response)
--------------------------------------------------------------------------------------------

		signal.Emitter.createSignal @, 'onRequest'

ReadOnly *String* Networking::protocol
--------------------------------------

		protocol: ''

ReadOnly *Integer* Networking::port
-----------------------------------

		port: 0

ReadOnly *String* Networking::host
----------------------------------

		host: ''

ReadOnly *String* Networking::url
---------------------------------

URL path contains a protocol, port and a host.

It can be set manually if the external address is different.
Otherwise it's created automatically.

		url: ''

ReadOnly *String* Networking::language
--------------------------------------

Indicates the application language regarding to BCP47 (e.g. 'en', 'en-US').

		language: ''

ReadOnly *List* Networking::pendingRequests
-------------------------------------------

*Networking.Handler* Networking::createHandler(*Object* options)
----------------------------------------------------------------

Use this method to create a new [Handler][networking/Handler].

```javscript
app.networking.createHandler({
	method: 'get',
	uri: '/users/{name}',
	schema: new Schema({
		name: {
			type: 'string',
			min: 3
		},
	}),
	callback: function(req, res, next){
		res.raise(new Networking.Response.Error(Networking.Response.NOT_IMPLEMENTED));
	}
});
```

		createHandler: (opts) ->
			assert.instanceOf @, Networking
			assert.isPlainObject opts, '::createHandler options argument ...'

			{uri} = opts

			unless uri instanceof Networking.Uri
				uri = new Networking.Uri uri

			handler = new Networking.Handler
				method: opts.method
				uri: uri
				schema: opts.schema
				callback: opts.callback

			stack = @_handlers[opts.method] ?= []
			stack.push handler

			handler

*Networking.Request* Networking::createRequest(*Object|Networking.Request* options)
-----------------------------------------------------------------------------------

The given options object corresponds to the [Request][networking/Request] properties.

		createRequest: (opts) ->
			assert.instanceOf @, Networking
			assert.isObject opts, '::createRequest options argument ...'

			opts.uri = if opts.uri then opts.uri+'' else ''

			unless EXTERNAL_URL_RE.test(opts.uri)
				if opts.uri[0] isnt '/'
					opts.uri = "/#{opts.uri}"
				opts.uri = "#{@url}#{opts.uri}"

			# create a request
			if opts instanceof Networking.Request
				req = opts
			else
				req = new Networking.Request opts
			logtime = log.time utils.capitalize("#{req}")
			req.onLoadEnd =>
				@pendingRequests.remove req
				log.end logtime

			# create a response
			resOpts = if utils.isObject(opts.response) then opts.response else {}
			resOpts.request = req
			res = new Networking.Response resOpts
			req.response = res

			# signal
			@pendingRequests.append req
			@onRequest.emit req, res

			# get handlers
			Impl.sendRequest req, res, (opts) ->
				utils.merge res, opts
				res.pending = false
				req.destroy()

			req

*Networking.Request* Networking::get(*String* uri, *Function* onLoadEnd)
------------------------------------------------------------------------

		get: (uri, onLoadEnd) ->
			@createRequest
				method: 'get'
				uri: uri
				onLoadEnd: onLoadEnd

*Networking.Request* Networking::post(*String* uri, [*Any* data], *Function* onLoadEnd)
---------------------------------------------------------------------------------------

		post: (uri, data, onLoadEnd) ->
			if typeof data is 'function' and not onLoadEnd
				onLoadEnd = data
				data = null

			@createRequest
				method: 'post'
				uri: uri
				data: data
				onLoadEnd: onLoadEnd

*Networking.Request* Networking::put(*String* uri, [*Any* data], *Function* onLoadEnd)
--------------------------------------------------------------------------------------

		put: (uri, data, onLoadEnd) ->
			if typeof data is 'function' and not onLoadEnd
				onLoadEnd = data
				data = null

			@createRequest
				method: 'put'
				uri: uri
				data: data
				onLoadEnd: onLoadEnd

*Networking.Request* Networking::delete(*String* uri, [*Any* data], *Function* onLoadEnd)
-----------------------------------------------------------------------------------------

		delete: (uri, onLoadEnd) ->
			if typeof data is 'function' and not onLoadEnd
				onLoadEnd = data
				data = null

			@createRequest
				method: 'delete'
				uri: uri
				data: data
				onLoadEnd: onLoadEnd

*Networking.Request* Networking::createLocalRequest(*Object|Networking.Request* options)
----------------------------------------------------------------------------------------

Use this method to create a new [Request][networking/Request] and handle it.

The given options object corresponds to the [Request][networking/Request] properties.

Local and server requests are supported.

### Local requests

```javascript
app.networking.createRequest({
	uri: '/achievements/world_2',
	onLoadEnd: function(err, data){
		if (this.response.isSucceed()){
			console.log("Request has been loaded! Data: " + data);
		} else {
			console.log("Error: " + err);
		}
	}
});
```

### Requests to the server

```javascript
app.networking.createRequest({
	method: 'post',
	uri: 'http://server.domain/comments',
	data: {message: 'Great article! Like it.'},
	onLoadEnd: function(err, data){
		if (this.response.isSucceed()){
			console.log("Comment has been added!");
		}
	}
});
```

		EXTERNAL_URL_RE = ///^[a-zA-Z]+:\/\////
		createLocalRequest: (opts) ->
			assert.instanceOf @, Networking
			assert.isObject opts, '::createLocalRequest options argument ...'

			# create a request
			if opts instanceof Networking.Request
				req = opts
			else
				req = new Networking.Request opts
			req.onLoadEnd =>
				@pendingRequests.remove req

			# create a response
			resOpts = if utils.isObject(opts.response) then opts.response else {}
			resOpts.request = req
			res = new Networking.Response resOpts
			req.response = res

			# signal
			@pendingRequests.append req
			@onRequest.emit req, res

			# get handlers
			log "Resolve local `#{req}` request"

			onError = (err) ->
				unless req.pending
					return

				if err and (typeof err is 'object' or typeof err is 'string' or typeof err is 'number')
					res.raise err
				else
					res.raise Networking.Response.Error.RequestResolve req

			noHandlersError = ->
				log.warn "No handler found for request `#{req}`"
				onError()

			handlers = @_handlers[req.method]
			if handlers
				# run handlers
				err = null
				utils.async.forEach handlers, (handler, i, handlers, next) ->
					handler.exec req, res, (_err) ->
						if _err?
							err = _err
						next()

				, ->
					if err
						onError err
					else
						noHandlersError()
			else
				noHandlersError()

			req