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

	class UriNotValidError extends Error
		constructor: (@message) -> super

		name: 'UriNotValid'
		message: ''

*CallbackError* Handler.CallbackError : *Error*
-----------------------------------------------

	class CallbackError extends Error

		constructor: (@message) -> super

		name: 'CallbackError'
		message: ''

*Handler* Handler(*Object* options)
-----------------------------------

Abstract class used to describe routing handler.

You should use `Networking::createHandler()` to create full handler.

*options* specifies `Handler::method`, `Handler::uri`,
`Handler::schema` and `Handler::callback`.

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

		method: ''

*Networking.Uri* Handler::uri
-----------------------------

		uri: null

*Schema* Handler::schema
------------------------

		schema: null

*Function* Handler::callback
----------------------------

		callback: null

Handler::exec(*Networking.Request* request, *Networking.Response* response, *Function* next)
--------------------------------------------------------------------------------------------

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
					log "`#{@uri}` tests, but not passed schema\n#{err}"
					return next err

			# on callback fail
			callbackNext = (err) =>

				req.handler = null

				if err
					# TODO: move building errors into more generic place
					errMsg = err
					if err.stack?
						if utils.isQml
							errMsg = "#{err.message}\n#{err.stack}"
						else
							errMsg = err.stack

					log.error "Error raised in `#{@uri}` handler\n#{errMsg}"

				next new CallbackError

			log "Use `#{@method} #{@uri}` handler"

			req.handler = @
			utils.tryFunction @callback, @, [req, res, callbackNext], callbackNext

			null

*String* Handler::toString()
----------------------------

Returns string describing the handler.

```
"get /users/{name}"
```

		toString: ->
			"#{@method} #{@uri}"
