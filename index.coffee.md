Routing
=======

Use this module to handle requests and responses (e.g. by the HTTP protocol or just
locally to handle different URIs).

*App* object always has one instance of this class `App.routing`, so manual
loading this module is not required in most cases.

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	log = require 'log'

	log = log.scope 'Routing'

*Routing* Routing(*Object* options)
-----------------------------------

Creates new *Routing* instance.

*options* specifies `Routing::protocol`, `Routing::port`,
`Routing::host` and `Rotuing::language`.

	module.exports = class Routing

		Impl = require('./impl') Routing

		@Uri = require('./uri.coffee.md') Routing
		@Handler = require('./handler.coffee.md') Routing
		@Request = require('./request.coffee.md') Routing, Impl.Request
		@Response = require('./response.coffee.md') Routing, Impl.Response

		constructor: (opts) ->
			expect(opts).toBe.simpleObject()
			expect(opts.protocol).toBe.truthy().string()
			expect(opts.port).toBe.integer()
			expect(opts.host).toBe.truthy().string()
			expect(opts.language).toBe.truthy().string()

			utils.defineProperty @, '_handlers', utils.CONFIGURABLE, {}
			{@protocol, @port, @host, @language} = opts

			url = "#{@protocol}://#{@host}:#{@port}/"
			utils.defineProperty @, 'url', utils.ENUMERABLE, url

			setImmediate => Impl.init @
			log.info "Start as `#{@host}:#{@port}`"

			Object.freeze @

*String* Routing::protocol
--------------------------

It's **read-only**.

		protocol: 'http'

*Integer* Routing::port
-----------------------

It's **read-only**.

		port: 0

*String* Routing::host
----------------------

It's **read-only**.

		host: ''

*String* Routing::language
--------------------------

It's **read-only**.

		language: ''

*String* Routing::url
---------------------

Proper URL path contains protocol, port and host.

It's **read-only**.

		url: ''

*Routing.Handler* Routing::createHandler(*Object* options)
----------------------------------------------------------

Creates new *Routing.Handler* used to handle requests.

Given *options* object is used to create `Routing.Handler`.

```
app.routing.createHandler
  method: Routing.Request.GET
  uri: 'users/{name}'
  schema: new Schema
    name:
      required: true
      type: 'string'
  callback: (req, res, next) ->
    res.raise new Routing.Response.Error Routing.Response.NOT_IMPLEMENTED
```

		createHandler: (opts) ->
			expect(@).toBe.any Routing
			expect(opts).toBe.simpleObject()

			uri = new Routing.Uri opts.uri

			handler = new Routing.Handler
				method: opts.method
				uri: uri
				schema: opts.schema
				callback: opts.callback

			stack = @_handlers[opts.method] ?= []
			stack.push handler

			log.info "New handler `#{handler}` registered"

			handler

*Routing.Request* Routing::createRequest(*Object* options)
----------------------------------------------------------

Creates new local or server request.

Given *options* object is used to create `Routing.Request`.

```
req = app.routing.createRequest
  type: Routing.Request.OBJECT_TYPE
  url: '/achievements/world_2'

req.onLoaded (res) ->
  if res.isSucceed()
    console.log "Request has been loaded! Data #{res.data}"
```

```
req = app.routing.createRequest
  method: Routing.Request.POST
  url: 'http://server.domain/comments'
  data: {title: 'Best app ever!', message: 'Great, but why it\'s not free?'}

req.onLoaded (res) ->
  if res.isSucceed()
    console.log "Comment has been added!"
```

		EXTERNAL_URL_RE = ///^[a-zA-Z]+:\/\////
		createRequest: (opts) ->
			expect(@).toBe.any Routing
			expect(opts).toBe.simpleObject()

			logtime = log.time 'New request'

			# create a request
			req = new Routing.Request opts

			req.onDestroyed ->
				log.end logtime

			# create a response
			res = new Routing.Response request: req

			# get handlers
			onError = ->
				res.raise Routing.Response.Error.RequestResolve req

			if EXTERNAL_URL_RE.test req.url
				log "Send `#{req}` request"

				Impl.sendRequest url, config, (status, data) ->
					res.status = status
					res.data = data
					res.pending = false
					req.destroyed?()
					req.loaded? res
			else
				log "Resolve local `#{req}` request"

				handlers = @_handlers[req.method]
				if handlers
					# run handlers
					utils.async.forEach handlers, (handler, i, handlers, next) ->

						handler.exec req, res, (err) ->
							next()

					, onError
				else
					log.warn "No handler found"

					onError()

			req