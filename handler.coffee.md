Handler
=======

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	log = require 'log'
	Schema = require 'schema'

	{parse, stringify} = JSON

	assert = assert.scope 'Networking.Handler'
	log = log.scope 'Networking', 'Handler'

*UriNotValidError* Handler.UriNotValidError : *Error*
-----------------------------------------------------

This error class is raised if a handler *Uri* is not valid with a request.

Access it with:
```
var Networking = require('networking');
var UriNotValidError = Networking.Handler.UriNotValidError;
```

	class UriNotValidError extends Error
		constructor: (@message) -> super

		name: 'UriNotValid'
		message: ''

*CallbackError* Handler.CallbackError : *Error*
-----------------------------------------------

This error class is used if the handler callback function raised an error synchronously or
asynchronously (calling a *callback* argument with an error).

Access it with:
```
var Networking = require('networking');
var CallbackError = Networking.Handler.CallbackError;
```

	class CallbackError extends Error

		constructor: (@message) -> super

		name: 'CallbackError'
		message: ''

*Handler* Handler(*Object* options)
-----------------------------------

This class represents a callback function called on a request.

Each handler must determine an *Uri*, which is compared with the got request.

You should use **Networking::createHandler()** to create a functional handler.

*options* specifies a *Handler::method*, a *Handler::uri*,
a *Handler::schema* and a *Handler::callback*.

Access it with:
```
var Networking = require('networking');
var Handler = Networking.Handler;
```

	module.exports = (Networking) -> class Handler

		@UriNotValidError = UriNotValidError
		@CallbackError = CallbackError

		constructor: (opts) ->
			assert.isPlainObject opts, 'ctor options argument ...'
			assert.ok utils.has(Networking.Request.METHODS, opts.method), 'ctor options.method argument ...'
			assert.instanceOf opts.uri, Networking.Uri, 'ctor options.uri argument ...'
			assert.instanceOf opts.schema, Schema, 'ctor options.schema argument ...' if opts.schema?
			assert.isFunction opts.callback, 'ctor options.callback argument ...'

			{@method, @uri, @schema, @callback} = opts

*String* Handler::method
------------------------

This property describes which type of a request, this handler can handle.

It's one of the **Networking.Request.METHODS** values.

		method: ''

*Networking.Uri* Handler::uri
-----------------------------

This property is compared with a request uri.

If it's not valid with the request uri, a *UriNotValidError* error is raised,
otherwise schema is used to further validate.

		uri: null

*Schema* Handler::schema = null
-------------------------------

This property is used to determine whether a request uri is valid and can be handled by
the handler callback.

If not, a *UriNotValidError* error is raised.

This property is optional in the constructor.

		schema: null

*Function* Handler::callback
----------------------------

This function is used to handle a request.

It's called with three parameters: **Networking.Request**, **Networking.Response** and
a *next* function.

If *next* function is called, next handler is checked.

		callback: null

Handler::exec(*Networking.Request* request, *Networking.Response* response, *Function* next)
--------------------------------------------------------------------------------------------

This method executes a handler, that is:
 - compare a uri with a request,
 - validate the request uri with a schema,
 - call a callback.

It's internally called by the **Networking.createRequest()**.

		exec: (req, res, next) ->
			assert.instanceOf req, Networking.Request, '::exec request argument ...'
			assert.instanceOf res, Networking.Response, '::exec response argument ...'
			assert.isFunction next, '::exec next argument ...'

			# compare methods
			if @method isnt req.method
				return next new UriNotValidError

			# test uri
			unless @uri.test req.uri
				return next new UriNotValidError

			params = req.params = @uri.match req.uri

			# validate by schema
			if @schema
				# parse params into expected types
				for key, schemaOpts of @schema.schema
					if params.hasOwnProperty(key) and schemaOpts.type and schemaOpts.type isnt 'string'
						params[key] = utils.tryFunction parse, null, [params[key]], params[key]

				# validate schema
				err = utils.catchError @schema.validate, @schema, [params]
				if err instanceof Error
					return next err

			# on callback fail
			callbackNext = (err) =>
				req.handler = null
				if err? and err isnt true
					errMsg = err
					if err.stack?
						if utils.isQml
							errMsg = "#{err.message}\n#{err.stack}"
						else
							errMsg = err.stack
				if errMsg
					next new CallbackError errMsg
				else
					next new UriNotValidError

			log "Use `#{@method} #{@uri}` handler"

			req.handler = @
			utils.tryFunction @callback, @, [req, res, callbackNext], callbackNext

			null

*String* Handler::toString()
----------------------------

This method returns a string describing a handler: a uri prefixed by a method.

```
"get /users/{name}"
```

		toString: ->
			"#{@method} #{@uri}"
