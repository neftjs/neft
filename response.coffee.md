Response
========

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	log = require 'log'
	signal = require 'signal'

	assert = assert.scope 'Networking.Response'
	log = log.scope 'Networking', 'Response'

	module.exports = (Networking, Impl) -> class Response

*Array* Response.STATUSES
-------------------------

This array contains abstract codes used to describe a response type.

Each status corresponds to the HTTP numeral value.
Check [http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html]() for more.

Contains:
 - Response.OK,
 - Response.CREATED,
 - Response.ACCEPTED,
 - Response.NO_CONTENT,
 - Response.MOVED,
 - Response.FOUND,
 - Response.NOT_MODIFIED,
 - Response.TEMPORARY_REDIRECT,
 - Response.BAD_REQUEST,
 - Response.UNAUTHORIZED,
 - Response.PAYMENT_REQUIRED,
 - Response.FORBIDDEN,
 - Response.NOT_FOUND,
 - Response.CONFLICT,
 - Response.PRECONDITION_FAILED,
 - Response.UNSUPPORTED_MEDIA_TYPE,
 - Response.INTERNAL_SERVER_ERROR,
 - Response.NOT_IMPLEMENTED,
 - Response.SERVICE_UNAVAILABLE.

```
console.log(Networking.Response.OK);
console.log(Networking.Response.BAD_REQUEST);
```

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

		@Error = require('./response/error.coffee.md') Networking, Response

*Response* Response(*Object* options)
-------------------------------------

This class represents a response for a request.

It's created automatically in the [Networking::createRequest()][] method.

Access it with:
```
var Networking = require('networking');
var Response = Networking.Response;
```

		constructor: (opts) ->
			assert.isPlainObject opts, 'ctor options argument ...'
			assert.instanceOf opts.request, Networking.Request, 'ctor options.request argument ...'

			if opts.status?
				assert.ok utils.has(Response.STATUSES, opts.status), 'ctor options.status argument ...'
				{@status} = opts

			if opts.data?
				{@data} = opts

			utils.defineProperty @, 'request', null, opts.request

			@pending = true

			if opts.status?
				@send()

			# whether response will be send on the next tick
			utils.defineProperty @, '_waitingToSend', utils.WRITABLE, false

*Signal* Response::sent()
-------------------------

This signal is called when a response has been sent.

```
res.onSent(function(){
  console.log("Response has been sent!");
});
```

		signal.createLazy @::, 'sent'

*Signal* Response::destroyed()
------------------------------

This signal is called when a response data is no longer in use.

Check *Response::destroy()* for more.

		signal.createLazy @::, 'destroyed'

ReadOnly *Boolean* Response::pending
------------------------------------

This property indicates whether a response is not destroyed.

		pending: false

ReadOnly *Networking.Request* Response::request
-----------------------------------------------

This proeprty refers to the [Networking.Request][].

		request: null

*Integer* Response::status = Response.OK
----------------------------------------

This property keeps a normalized code determines response type.

It refers to one of the *Response.STATUSES* values.

```
res.status = Networking.Response.CREATED;
res.status = Networking.Response.PAYMENT_REQUIRED;
```

		status: @OK

*Any* Response::data
--------------------

This property value will be sent to a client as a response data.

It can be set manually or by the *Response::send()* method.

```
res.data = {items: ['superhero toy', 'book']};
res.data = new Error("Wrong order");
res.data = Document.fromJSON(...);
```

		data: null

*Response* Response::setHeader(*String* name, *String* value)
-------------------------------------------------------------

Use this method to set a header.

Currently this method has no effect for a local requests.

```
res.setHeader('Location', '/redirect/to/url');
```

		setHeader: (name, val) ->
			assert.ok @request.pending
			assert.isString name, '::setHeader name argument ...'
			assert.notLengthOf name, 0, '::setHeader name argument ...'
			assert.isString val, '::setHeader value argument ...'
			assert.notLengthOf val, 0, '::setHeader value argument ...'

			Impl.setHeader @, name, val

			@

Response::send([*Integer* status, *Any* data])
----------------------------------------------

Use this method to send a response.

This method calls *sent()* signal asynchronously.

You can still change a response status and data, but only synchronously.

```
res.send(Networking.Response.OK, {user: 'Max', age: 43});

res.onSent(function(){
  console.log("Response has been sent");
});
```

		send: (status, data) ->
			assert.ok @request.pending

			if not data? and typeof status isnt 'number'
				data = status
				status = @status

			if status?
				assert.ok utils.has(Response.STATUSES, status)
				@status = status

			if data isnt undefined
				if @data
					log.info "`#{@request.uri}` response data has been overwritten"

				@data = data

			unless @_waitingToSend
				@_waitingToSend = true
				@request.destroy()
				setImmediate => sendData @

			null

		sendData = (res) ->
			assert.instanceOf res, Response

			res.request.loaded? res

			{data} = res

			unless res.isSucceed()
				log.warn "Response #{res.request.uri} completed with error;\n#{data?.stack or data}"

			if data instanceof Error
				data = utils.errorToObject data

			Impl.send res, data, ->
				res.sent?()

Response::redirect(*Integer* status = `Response.FOUND`, *String* uri)
---------------------------------------------------------------------

Use this method to redirect a client to the other uri.

*Response.FOUND* status is typically used for a temporary redirect and *Response.MOVED* for
a permanent redirect.

		redirect: (status, uri) ->
			if uri is undefined
				uri = status
				status = Response.FOUND

			assert.ok @request.pending
			assert.ok utils.has(Response.STATUSES, status)
			assert.isString uri

			log "#{status} redirect to '#{uri}'"

			@status = status
			@setHeader 'Location', uri

			@request.destroy()
			@request.loaded? @

			Impl.redirect @, status, uri, =>
				@sent?()

Response::raise(*Any* error)
----------------------------

This method finishes a response with an error.

```
res.raise(new Networking.Response.Error("Login first"));
res.raise(new Networking.Response.Error(Networking.Response.UNAUTHORIZED, "Login first"));
```

		raise: (error) ->
			if error instanceof Response.Error
				@send error.status, error
			else
				@send Response.INTERNAL_SERVER_ERROR, error

*Boolean* Response::isSucceed()
-------------------------------

This method returns *true* if a response status is in the range from 200 to 299.

		isSucceed: ->
			300 > @status >= 200

Response::destroy()
-------------------

Call this method if the response data is no longer in use.

This functionality is typically used on the client side, when a rendered document
is still visible until the next request.

This method calls the *destroyed()* signal.

		destroy: ->
			assert.ok @pending

			@pending = false
			@destroyed?()

			return
