Routing.Response
================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	log = require 'log'
	signal = require 'signal'

	log = log.scope 'Routing', 'Response'

	module.exports = (Routing, Impl) -> class Response

*Array* Response.STATUSES
-------------------------

Abstract values used to describe response type.

This values are used in the `Response::status` property and for `Response::send()` method.

Each status corresponds to the HTTP numeral value.

### Response.OK
### Response.CREATED
### Response.ACCEPTED
### Response.NO_CONTENT
### Response.MOVED
### Response.FOUND
### Response.NOT_MODIFIED
### Response.TEMPORARY_REDIRECT
### Response.BAD_REQUEST
### Response.UNAUTHORIZED
### Response.PAYMENT_REQUIRED
### Response.FORBIDDEN
### Response.NOT_FOUND
### Response.CONFLICT
### Response.PRECONDITION_FAILED
### Response.UNSUPPORTED_MEDIA_TYPE
### Response.INTERNAL_SERVER_ERROR
### Response.NOT_IMPLEMENTED
### Response.SERVICE_UNAVAILABLE

		@STATUSES = [

			# Success
			(@OK = 200),
			(@CREATED = 201),
			(@ACCEPTED = 202),
			(@NO_CONTENT = 204),

			# Redirection
			(@MOVED = 301),
			(@FOUND = 302),
			(@NOT_MODIFIED = 304),
			(@TEMPORARY_REDIRECT = 307),

			# Client error
			(@BAD_REQUEST = 400),
			(@UNAUTHORIZED = 401),
			(@PAYMENT_REQUIRED = 402),
			(@FORBIDDEN = 403),
			(@NOT_FOUND = 404),
			(@METHOD_NOT_ALLOWED = 405),
			(@NOT_ACCEPTABLE = 406),
			(@CONFLICT = 409),
			(@PRECONDITION_FAILED = 412),
			(@UNSUPPORTED_MEDIA_TYPE = 415),

			# Server error
			(@INTERNAL_SERVER_ERROR = 500),
			(@NOT_IMPLEMENTED = 501),
			(@SERVICE_UNAVAILABLE = 503)

		]

		@Error = require('./response/error.coffee.md') Routing, Response

*Response* Response(*Object* options)
-------------------------------------

Class represents response for a request.

It's created automatically and used to handle the request.

		constructor: (opts) ->
			expect(opts).toBe.simpleObject()
			expect(opts.request).toBe.any Routing.Request
			expect().some(Response.STATUSES).toBe opts.status if opts.status?

			{@status} = opts if opts.status?
			{@data} = opts if opts.data?

			utils.defineProperty @, 'request', null, opts.request

			@pending = true

			if opts.status?
				@destroy()

			# whether response will be send on the next tick
			utils.defineProperty @, '_waitingToSend', utils.WRITABLE, false

Response::sent()
----------------

**Signal** called when the response has been marked as going to be send.

On this signal, the response can't be modified.

You can listen on this signal using the `onSent` handler.

```
res.onSent ->
  console.log "Response has been sent!"
```

		signal.createLazy @::, 'sent'

*Boolean* Response::pending
---------------------------

It's `true` if the response is active, `false` if the response has been
destroyed or sent and can't be modified.

It's **read-only**.

		pending: false

*Routing.Request* Response::request
-----------------------------------

Reference to the created `request`.

This request is active until the response is pending.

It's **read-only**.

		request: null

*Integer* Response::status
--------------------------

Normalized code determines response type.

Use one of the constant values provided in the `Response.STATUSES`.

It's equal `Response.OK` by default.

```
res.status = Routing.Response.CREATED
res.status = Routing.Response.PAYMENT_REQUIRED
```

		status: @OK

*Any* Response::data
--------------------

Value to send. It can be set using the `Response::send()` method or manually.

```
res.data = {items: ['superhero toy', 'book']}
res.data = new Error "Wrong order"
res.data = View.fromJSON(...)
```

		data: null

*Response* Response::setHeader(*String* name, *String* value)
-------------------------------------------------------------

Sets a single header. If the header aready exists, its value will be replaced.

Currently this method has no effect for local responses.

```
res.setHeader 'Location', '/redirect/to/url'
```

		setHeader: (name, val) ->
			expect(@pending).toBe.truthy()
			expect(name).toBe.truthy().string()
			expect(val).toBe.truthy().string()

			Impl.setHeader @, name, val

			@

Response::send([*Integer* status, *Any* data])
----------------------------------------------

Marks response as ready to send.

This method calls `Response::sent()` signal asynchronously.

You can change response status and data, but only synchronously.

This method automatically parses got data which is determined by the environment.

```
res.send Routing.Response.OK, {user: 'Max', age: 43}

res.onSent ->
  console.log "Response has been sent and is not active"
```

		send: (status, data) ->
			expect(@pending).toBe.truthy()

			if data? and typeof status isnt 'number'
				data = status
				status = @status

			if status?
				expect().some(Response.STATUSES).toBe status
				@status = status

			if data?
				if @data
					log.info "`#{@request.url}` response data has been overwritten"

				@data = data

			unless @_waitingToSend
				@_waitingToSend = true
				@request.destroy()
				setImmediate => sendData @

			null

		sendData = (res) ->
			expect(res).toBe.any Response
			expect(res.pending).toBe.truthy()

			utils.defineProperty res, 'pending', utils.ENUMERABLE, false
			res.request.loaded? @

			Impl.send res, res.data, ->
				res.sent?()

Response::raise(*Response.Error* error)
---------------------------------------

Finishes response as failed.

```
res.raise new Routing.Response.Error "Login first"
res.raise new Routing.Response.Error Routing.Response.UNAUTHORIZED, "Login first"
```

		raise: (error) ->
			expect(error).toBe.any Response.Error

			@send error.status, error

*Boolean* Response::isSucceed()
-------------------------------

Returns `true` if status is in range from 200 to 299.

		isSucceed: ->
			300 > @status >= 200
