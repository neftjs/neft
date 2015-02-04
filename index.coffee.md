Routing
=======

Use this module to handle requests and responses (e.g. by the HTTP protocol or just
locally to handle different URIs).

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	log = require 'log'

	assert = assert.scope 'Routing'
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
			assert.isPlainObject opts, 'ctor options argument ....'
			assert.isString opts.protocol, 'ctor options.protocol argument ...'
			assert.notLengthOf opts.protocol, 0, 'ctor options.protocol argument ...'
			assert.isInteger opts.port, 'ctor options.port argument ...'
			assert.isString opts.host, 'ctor options.host argument ...'
			assert.notLengthOf opts.host, 0, 'ctor options.host argument ...'
			assert.isString opts.language, 'ctor options.language argument ...'
			assert.notLengthOf opts.language, 0, 'ctor options.language argument ...'

			utils.defineProperty @, '_handlers', utils.CONFIGURABLE, {}
			{@protocol, @port, @host, @language} = opts

			url = "#{@protocol}://#{@host}:#{@port}/"
			utils.defineProperty @, 'url', utils.ENUMERABLE, url

			setImmediate => Impl.init @
			log.info "Start as `#{@host}:#{@port}`"

			Object.freeze @

ReadOnly *String* Routing::protocol
-----------------------------------

		protocol: 'http'

ReadOnly *Integer* Routing::port
--------------------------------

		port: 0

ReadOnly *String* Routing::host
-------------------------------

		host: ''

ReadOnly *String* Routing::language
-----------------------------------

		language: ''

ReadOnly *String* Routing::url
------------------------------

Proper URL path contains protocol, port and host.

		url: ''

*Routing.Handler* Routing::createHandler(*Object* options)
----------------------------------------------------------

Creates new *Routing.Handler* used to handle requests.

```
app.routing.createHandler({
  method: Routing.Request.GET,
  uri: 'users/{name}',
  schema: new Schema({
    name: {
      required: true,
      type: 'string'
    },
  }),
  callback: function(req, res, next){
    res.raise(new Routing.Response.Error(Routing.Response.NOT_IMPLEMENTED));
  }
});
```

		createHandler: (opts) ->
			assert.instanceOf @, Routing
			assert.isPlainObject opts, '::createHandler options argument ...'

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

#### Local request

```
app.routing.createRequest({
  uri: '/achievements/world_2',
  onLoaded: function(res){
    if (res.isSucceed()){
      console.log("Request has been loaded! Data: " + res.data);
    } else {
      console.log("Error: " + res.data);
    }
  }
});
```

#### Request to the server

```
app.routing.createRequest({
  method: Routing.Request.POST,
  uri: 'http://server.domain/comments',
  data: {message: 'Great article! Like it.'},
  onLoaded: function(res){
    if (res.isSucceed()){
      console.log("Comment has been added!");
    }
  }
});
```

		EXTERNAL_URL_RE = ///^[a-zA-Z]+:\/\////
		createRequest: (opts) ->
			assert.instanceOf @, Routing
			assert.isPlainObject opts, '::createRequest options argument ...'

			logtime = log.time 'New request'

			# create a request
			req = new Routing.Request opts

			req.onDestroyed ->
				log.end logtime

			# create a response
			res = new Routing.Response request: req

			# get handlers
			if EXTERNAL_URL_RE.test req.uri
				log "Send `#{req}` request"

				Impl.sendRequest req, (status, data) ->
					res.status = status
					res.data = data
					res.pending = false
					req.destroyed?()
					req.loaded? res
			else
				log "Resolve local `#{req}` request"

				onError = ->
					res.raise Routing.Response.Error.RequestResolve req

				noHandlersError = ->
					log.warn "No handler found"
					onError()

				handlers = @_handlers[req.method]
				if handlers
					# run handlers
					utils.async.forEach handlers, (handler, i, handlers, next) ->
						handler.exec req, res, (err) ->
							next()

					, (err) ->
						if err
							onError err
						else
							noHandlersError()
				else
					noHandlersError()

			req
