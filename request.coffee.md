Networking.Request
==================

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	signal = require 'signal'

	assert = assert.scope 'Networking.Request'

	module.exports = (Networking, Impl) -> class Request

*Array* Request.METHODS
-----------------------

Available request methods which can be used in created and got requests.

This constant values are used in the `Request::method` property.

Contains:
 - Request.GET,
 - Request.POST,
 - Request.PUT,
 - Request.DELETE,
 - Request.OPTIONS

		@METHODS = [
			(@GET = 'get'),
			(@POST = 'post'),
			(@PUT = 'put'),
			(@DELETE = 'delete'),
			(@OPTIONS = 'options')
		]

*Array* Request.TYPES
---------------------

Values descrbes expected response data type.

This constant values are used in the `Request::type` property.

Contains:
 - Request.OBJECT_TYPE,
 - Request.VIEW_TYPE

		@TYPES = [
			(@OBJECT_TYPE = 'object'),
			(@VIEW_TYPE = 'view')
		]

*Request* Request(*Object* options)
-----------------------------------

Abstract class used to describe routing request.

You should use `Networking::createRequest()` to create a full request.

*options* specifies `Request::method`, `Request::uri`, `Request::data`, `Request::type`
and signal handlers.

		constructor: (opts) ->
			assert.isPlainObject opts, 'ctor options argument ...'
			assert.isString opts.uid if opts.uid?
			assert.ok utils.has(Request.METHODS, opts.method) if opts.method?
			assert.isString opts.uri, 'ctor options.uri argument ...'

			if opts.data?
				assert.isObject opts.data, 'ctor options.data argument ...' if opts.data?
				{@data} = opts

			if opts.type?
				assert.ok utils.has(Request.TYPES, opts.type), 'ctor options.type argument ...'
				{@type} = opts
			utils.defineProperty @, 'type', utils.ENUMERABLE, @type

			{@uri} = opts
			{@method} = opts if opts.method?

			@uri = unescape @uri

			uid = opts.uid or utils.uid()
			utils.defineProperty @, 'uid', null, uid

			@pending = true
			@params = null

			# signal handlers
			if opts.onDestroyed
				@onDestroyed opts.onDestroyed
			if opts.onLoaded
				@onLoaded opts.onLoaded

*Signal* Request::destroyed()
-----------------------------

**Signal** called by the `Networking.Response` when some data is ready to be send.

This signal is called before the `Networking::loaded()` signal.

You can listen on this signal using the `onDestroyed` handler.

		signal.createLazy @::, 'destroyed'

*Signal* Request::loaded(*Networking.Response* res)
------------------------------------------------

**Signal** called by the `Networking.Response` when the final data is ready.

When this signal is called, `Request` is already destroyed.

Notice, that the failed `Networking.Response` also use this signal.
You should always use `Request::isSucceed()` to check whether request succeeded.

```
req.onLoaded(function(res){
  if (res.isSucceed()){
    console.log("Response has been sent with data " + res.data);
  }
});
```

		signal.createLazy @::, 'loaded'

ReadOnly *String* Request::uid
------------------------------

Pseudo unique hash.

		uid: ''

ReadOnly *Boolean* Request::pending
-----------------------------------

It's `true` if the request is active, `false` if the request has been destroyed.

This property is changed by the `Networking.Response`.

		pending: false

*String* Request::method
------------------------

Request method. Available values are described in the `Request.METHODS`.

		method: Request.GET

*String* Reuqest::uri
---------------------

This property referts to the URI path.

For local requests, this property doesn't contains protocol, hostname and port.

```
// for requests send to the server ...
"http://server.domain/auth/user"

// for local requests ...
"/user/user_id"
```

		uri: ''

*String* Request::type
----------------------

This property describes expected response type.

Check `Request.TYPES` for available types.

		type: @OBJECT_TYPE

*Object* Request::data
----------------------

Data submitted in the request body. It can be for example, a form data.

		data: null

*Networking.Handler* Request::handler
----------------------------------

The currently matched `Networking.Handler`.

		handler: null

ReadOnly *Object* Request::params
---------------------------------

This property is an object containing matched parameters from the handler.

For example, considering `users/{name}` uri,
the "name" property is available as `req.params.name`.

It's `{}` by default.

		params: null

ReadOnly *Object* Request::headers
----------------------------------

The request headers object.

Modifying this object has no effect.

For client requests, this object is empty.

		Object.defineProperty @::, 'headers',
			get: -> Impl.getHeaders(@) or {}

ReadOnly *String* Request::userAgent
------------------------------------

This property describes client user agent.

It can be used on the client side and on the server side.

		Object.defineProperty @::, 'userAgent',
			get: -> Impl.getUserAgent(@) or ''

Request::destroy()
------------------

Marks request as resolved. This action is terminal.

It's not necessary to call this method manually,
because `response` gives a signal to destroy the request.

This method calls `Request::destroyed()` signal.

		destroy: ->
			assert.ok @pending

			utils.defineProperty @, 'pending', utils.ENUMERABLE, false
			@destroyed()

			null

*String* Request::toString()
----------------------------

Returns string describing the request.

```
console.log(req.toString);
// get /users/id as object
```

		toString: ->
			"#{@method} #{@uri} as #{@type}"