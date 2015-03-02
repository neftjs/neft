Request
=======

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	signal = require 'signal'

	assert = assert.scope 'Networking.Request'

	module.exports = (Networking, Impl) -> class Request

*Array* Request.METHODS
-----------------------

This array contains available *HTTP* methods.

Check *Request::method* for more.

Contains:
 - Request.GET,
 - Request.POST,
 - Request.PUT,
 - Request.DELETE,
 - Request.OPTIONS.

		@METHODS = [
			(@GET = 'get'),
			(@POST = 'post'),
			(@PUT = 'put'),
			(@DELETE = 'delete'),
			(@OPTIONS = 'options')
		]

*Array* Request.TYPES
---------------------

This array contains available expected types.

Check *Request::type* for more.

Contains:
 - Request.TEXT_TYPE,
 - Request.JSON_TYPE,
 - Request.HTML_TYPE.

		@TYPES = [
			(@TEXT_TYPE = 'text'),
			(@JSON_TYPE = 'json'),
			(@HTML_TYPE = 'html')
		]

*Request* Request(*Object* options)
-----------------------------------

This class is used to describe coming networking request.

You should use *Networking::createRequest()* to create a full request.

*options* specifies a *Request::method*, a *Request::uri*, a *Request::data*,
a *Request::type* and signal handlers.

Access it with:
```
var Networking = require('networking');
var Request = Networking.Request;
```

		constructor: (opts) ->
			assert.isPlainObject opts, 'ctor options argument ...'
			assert.isString opts.uid if opts.uid?
			assert.ok utils.has(Request.METHODS, opts.method) if opts.method?
			assert.isString opts.uri, 'ctor options.uri argument ...'

			if opts.type?
				assert.ok utils.has(Request.TYPES, opts.type), 'ctor options.type argument ...'
				{@type} = opts
			utils.defineProperty @, 'type', utils.ENUMERABLE, @type

			{@data, @uri} = opts
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

This signal is called by the [Networking.Response][] when data is ready to be sent.

It's called before the *loaded()* signal.

		signal.createLazy @::, 'destroyed'

*Signal* Request::loaded(*Networking.Response* res)
---------------------------------------------------

This signal is called by the [Networking.Response][] when data is going to be sent.

When this signal is called, the request is already destroyed.

Notice, that failed response also calls this signal, therefore
you should use [Networking.Response::isSucceed()][] to check whether request succeeded.

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

It's a pseudo unique hash. It's created automatically.

		uid: ''

ReadOnly *Boolean* Request::pending
-----------------------------------

This property indicates whether a request is not destroyed.

If it's *false*, the request can't be changed.

Check *destroyed()* for more.

		pending: false

*String* Request::method
------------------------

This property refers to one of the *Request.METHODS* values.

It holds a method with which the request has been called.

		method: Request.GET

*String* Request::uri
---------------------

This property refers to the request URI path.

It can holds local and absolute paths.

```
// for request sent to the server ...
"http://server.domain/auth/user"

// for got request on the server ...
"http://server.domain/auth/user"

// for local requests ...
"/user/user_id"
```

		uri: ''

*String* Request::type
----------------------

This property describes expected response type.

It's used in the server-client communication.
In most cases, a server returns an HTML document for a crawler, but client
(which renders documents on his own) expects a clean JSON response.
That's why, these two requests have the same uri, but different expected types.

It refers to one of the *Request.TYPES* values.

		type: @JSON_TYPE

*Object* Request::data = null
-----------------------------

This property holds a data sent with a request.
It can be, for instance, a form data.

		data: null

*Networking.Handler* Request::handler
-------------------------------------

This property refers to the current considered [Networking.Handler][].

It's set by the [Networking.Handler][] itself.

		handler: null

ReadOnly *Object* Request::params = {}
--------------------------------------

This property keeps matched parameters by a handler in the request uri.

Considering */users/{name}* [Networking.Uri],
the 'name' property is available as *req.params.name*.

		params: null

ReadOnly *Object* Request::headers
----------------------------------

This object contains request headers.

For a client request, this object is empty.

		Object.defineProperty @::, 'headers',
			get: -> Impl.getHeaders(@) or {}

ReadOnly *String* Request::userAgent
------------------------------------

This property describes a client user agent.

It can be used on the client side and on the server side.

		Object.defineProperty @::, 'userAgent',
			get: -> Impl.getUserAgent(@) or ''

Request::destroy()
------------------

Use this method to mark a request as resolved. This action is terminal.

It's called automatically by the [Networking.Response][].

		destroy: ->
			assert.ok @pending

			@pending = false
			@destroyed()

			return

*String* Request::toString()
----------------------------

This method returns a string describing the request.

It contains a *Request::method*, a *Request::uri* and a *Request::type*.

```
console.log(req.toString);
// get /users/id as json
```

		toString: ->
			"#{@method} #{@uri} as #{@type}"
