Networking
==========

**HTTP, URIs, ...**

Use this module to handle requests and responses (e.g. by the HTTP protocol or just
locally to handle different URIs).

Access it with:
```
var Networking = require('networking');
```

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	log = require 'log'

	assert = assert.scope 'Networking'
	log = log.scope 'Networking'

	module.exports = class Networking

		Impl = require('./impl') Networking

		@Uri = require('./uri.coffee.md') Networking
		@Handler = require('./handler.coffee.md') Networking
		@Request = require('./request.coffee.md') Networking, Impl.Request
		@Response = require('./response.coffee.md') Networking, Impl.Response

*Array* Networking.TYPES
------------------------

Contains:
 - Networking.HTTP

		@TYPES = [
			(@HTTP = 'http')
		]

*Networking* Networking(*Object* options)
-----------------------------------------

Creates new *Networking* instance.

*options* specifies `Networking::type`, `Networking::protocol`,
`Networking::port`, `Networking::host` and `Rotuing::language`.

		constructor: (opts) ->
			assert.isPlainObject opts, 'ctor options argument ....'
			assert.isString opts.type, 'ctor options.type argument ...'
			assert.ok utils.has(Networking.TYPES, opts.type)
			assert.isString opts.protocol, 'ctor options.protocol argument ...'
			assert.notLengthOf opts.protocol, 0, 'ctor options.protocol argument ...'
			assert.isInteger opts.port, 'ctor options.port argument ...'
			assert.isString opts.host, 'ctor options.host argument ...'
			assert.notLengthOf opts.host, 0, 'ctor options.host argument ...'
			assert.isString opts.language, 'ctor options.language argument ...'
			assert.notLengthOf opts.language, 0, 'ctor options.language argument ...'

			utils.defineProperty @, '_handlers', utils.CONFIGURABLE, {}
			{@type, @protocol, @port, @host, @language} = opts

			if opts.url?
				assert.isString opts.url
				assert.notLengthOf opts.url, 0
				url = opts.url
				if url[url.length - 1] isnt '/'
					url += '/'
			else
				url = "#{@protocol}://#{@host}:#{@port}/"
			utils.defineProperty @, 'url', utils.ENUMERABLE, url

			setImmediate => Impl.init @
			log.info "Start as `#{@host}:#{@port}`"

			Object.freeze @

ReadOnly *String* Networking::type
----------------------------------

		type: @HTTP

ReadOnly *String* Networking::protocol
--------------------------------------

		protocol: 'http'

ReadOnly *Integer* Networking::port
-----------------------------------

		port: 0

ReadOnly *String* Networking::host
----------------------------------

		host: ''

ReadOnly *String* Networking::language
--------------------------------------

		language: ''

ReadOnly *String* Networking::url
---------------------------------

Proper URL path contains protocol, port and host.

Can be set manually if passed host and port are private.

		url: ''

*Networking.Handler* Networking::createHandler(*Object* options)
----------------------------------------------------------------

Creates new *Networking.Handler* used to handle requests.

```
app.httpNetworking.createHandler({
  method: Networking.Request.GET,
  uri: 'users/{name}',
  schema: new Schema({
    name: {
      required: true,
      type: 'string'
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

			log.info "New handler `#{handler}` registered"

			handler

*Networking.Request* Networking::createRequest(*Object* options)
----------------------------------------------------------------

Creates new local or server request.

Given *options* object is used to create [Networking.Request][].

#### Local requests

```
app.httpNetworking.createRequest({
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

#### Requests to the server

```
app.httpNetworking.createRequest({
  method: Networking.Request.POST,
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
			assert.instanceOf @, Networking
			assert.isPlainObject opts, '::createRequest options argument ...'

			logtime = log.time 'New request'

			# create a request
			req = new Networking.Request opts

			req.onDestroyed ->
				log.end logtime

			# create a response
			res = new Networking.Response request: req

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

				onError = (err) ->
					if err and (typeof err is 'object' or typeof err is 'string' or typeof err is 'number')
						res.raise err
					else
						res.raise Networking.Response.Error.RequestResolve req

				noHandlersError = ->
					log.warn "No handler found"
					onError()

				handlers = @_handlers[req.method]
				if handlers
					# run handlers
					err = null
					utils.async.forEach handlers, (handler, i, handlers, next) ->
						handler.exec req, res, (_err) ->
							if _err
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
