Routing.Request
===============

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	signal = require 'signal'

	module.exports = (Routing, Impl) -> class Request

*Array* Request.METHODS
-----------------------

Available request methods which can be used in created and got requests.

This constant values are used in the `Request::method` property.

### Request.GET
### Request.POST
### Request.PUT
### Request.DELETE
### Request.OPTIONS

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

### Request.OBJECT_TYPE
### Request.VIEW_TYPE

		@TYPES = [
			(@OBJECT_TYPE = 'object'),
			(@VIEW_TYPE = 'view')
		]

*Request* Request(*Object* options)
-----------------------------------

Use `Routing::createRequest()` to create new local or server request.

*options* specifies `Request::method`, `Request::url`, `Request::data`, `Request::type`.

		constructor: (opts) ->
			expect(opts).toBe.simpleObject()

			expect().defined(opts.uid).toBe.truthy().string()
			expect().some(Request.METHODS).toBe opts.method if opts.method?
			expect(opts.url).toBe.string()

			if opts.data?
				expect().defined(opts.data).toBe.object()
				{@data} = opts

			if opts.type?
				expect().some(Request.TYPES).toBe opts.type
				{@type} = opts
			utils.defineProperty @, 'type', utils.ENUMERABLE, @type

			{@url} = opts
			{@method} = opts if opts.method?

			uid = opts.uid or utils.uid()
			utils.defineProperty @, 'uid', null, uid

			@pending = true
			@params = null

Request::destroyed()
--------------------

**Signal** called by the `Routing.Response` when some data is ready to be send.

This signal is called before the `Routing::loaded()` signal.

You can listen on this signal using the `onDestroyed` handler.

		signal.createLazy @::, 'destroyed'

Request::loaded(*Routing.Response* res)
---------------------------------------

**Signal** called by the `Routing.Response` when the final data is ready.

When this signal is called, `Request` is already destroyed.

Notice, that the failed `Routing.Response` can be also sent.

You can listen on this signal using the `onLoaded` handler.

```
req.onLoaded (res) ->
  if res.isSucceed()
    console.log "Response has been sent with data #{res.data}!"
```

		signal.createLazy @::, 'loaded'

*String* Request::uid
---------------------

Pseudo unique hash.

It's **read-only**.

		uid: ''

*Boolean* Request::pending
--------------------------

It's `true` if the request is active, `false` if the request has been destroyed.

This property is changed by the `Routing.Response`.

It's **read-only**.

		pending: false

*String* Request::method
------------------------

Request method. Available values are described in the `Request.METHODS`.

		method: Request.GET

*String* Reuqest::url
---------------------

This property referts to the URL path.

For local requests, this property doesn't contains protocol, hostname and port.

```
# for requests send to the server ...
http://server.domain/auth/user

# for local requests ...
/user/user_id
```

		url: ''

*String* Request::type
----------------------

This property describes expected response type.

Check `Request.TYPES` for available types.

		type: @OBJECT_TYPE

*Object* Request::data
----------------------

Data submitted in the request body. It can be for example, a form data.

		data: null

*Routing.Handler* Request::handler
----------------------------------

The currently matched `Routing.Handler`.

		handler: null

*Object* Request::params
------------------------

This property is an object containing matched parameters from the handler.

For example, considering `users/{name}` uri,
the "name" property is available as `req.params.name`.

It's `{}` by default.

It's **read-only**.

		params: null

*Object* Request::headers
-------------------------

The request headers object.

Modifying this object has no effect.

For client requests, this object is empty.

It's **read-only**.

		Object.defineProperty @::, 'headers',
			get: -> Impl.getHeaders(@) or {}

*String* Request::userAgent
---------------------------

This property describes client user agent.

It can be used on the client side and on the server side.

It's **read-only**.

		Object.defineProperty @::, 'userAgent',
			get: -> Impl.getUserAgent(@) or ''

Request::destroy()
------------------

Marks request as resolved. This action is terminal.

It's not necessary to call this method manually,
because `response` gives a signal to destroy the request.

This method calls `Request::destroyed()` signal.

		destroy: ->
			expect(@pending).toBe.truthy()

			utils.defineProperty @, 'pending', utils.ENUMERABLE, false
			@destroyed()

			null

*String* Request::toString()
----------------------------

Returns string describing the request.

```
console.log req.toString
# get /users/id as object
```

		toString: ->
			"#{@method} #{@url} as #{@type}"