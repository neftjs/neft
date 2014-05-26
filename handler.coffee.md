Handler
=======

	'use strict'

	[utils, log, Schema] = ['utils', 'log', 'schema'].map require

	{assert} = console
	{parse, stringify} = JSON

	log = log.scope 'Routing', 'Handler'

*class* UriNotValidError
------------------------

	class UriNotValidError extends Error

		constructor: (@message) -> super

		name: 'UriNotValid'
		message: ''

*class* HandlerCallbackError
----------------------------

	class HandlerCallbackError extends Error

		constructor: (@message) -> super

		name: 'HandlerCallbackError'
		message: ''

*class* Handler
---------------

	module.exports = (Routing, impl) -> class Handler

### Constructor

		constructor: (opts) ->

			opts ?= @

			assert ~Routing.METHODS.indexOf(opts.method)
			assert opts.uri instanceof Routing.Uri
			opts.schema and assert opts.schema instanceof Schema
			assert typeof opts.listener is 'function'

			{@method, @uri, @schema, @listener} = opts

### Properties

		method: ''
		uri: null
		schema: null
		listener: null

### Methods

#### exec(*Request*, *Response*, *Function*)

		exec: do (uriNotValidError = new UriNotValidError,
		          handlerCallbackError = new HandlerCallbackError) ->

			(req, res, callback) ->

				assert req instanceof Routing.Request
				assert res instanceof Routing.Response
				assert typeof callback is 'function'

				# compare methods
				if @method isnt req.method
					return callback uriNotValidError

				# test uri
				unless @uri.test req.uri
					return callback uriNotValidError

				params = req.params = @uri.match req.uri

				# with schema
				if @schema

					# parse params into expected types
					for key, schemaOpts of @schema.schema
						if params.hasOwnProperty(key) and schemaOpts.type
							params[key] = utils.tryFunc parse, null, [params[key]], params[key]

					# validate schema
					err = utils.catchError @schema.validate, @schema, [params]
					if err instanceof Error
						log "`#{@uri}` tests, but not passed schema (`#{err}`)"
						return callback err

				# on response destroy
				res.on Routing.Response.DESTROY, callback

				# on callback fail
				next = (err) =>

					if err then log.warn "Error raised in `#{@uri}` handler (`#{err}`)"

					res.off Routing.Response.DESTROY, callback
					callback handlerCallbackError

				log "Use `#{@method} #{@uri}` handler"

				utils.tryFunc @listener, @, [req, res, next], next

				null

#### toString()

		toString: ->

			"#{@method} #{@uri}"