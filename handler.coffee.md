Handler
=======

	'use strict'

	[utils, log, Schema] = ['utils', 'log', 'schema'].map require
	expect = require 'expect'

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

	module.exports = (Routing) -> class Handler

### Constructor

		constructor: (opts) ->

			opts ?= @

			expect(opts).toBe.simpleObject()
			expect().some(Routing.Request.METHODS).toBe opts.method
			expect(opts.uri).toBe.any Routing.Uri
			expect().defined(opts.schema).toBe.any Schema
			expect(opts.callback).toBe.function()

			{@method, @uri, @schema, @callback} = opts

### Properties

		method: ''
		uri: null
		schema: null
		callback: null

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
						log "`#{@uri}` tests, but not passed schema\n#{err}"
						return callback err

				# on response destroy
				res.on Routing.Response.DESTROY, callback

				# on callback fail
				next = (err) =>

					if err
						log.error "Error raised in `#{@uri}` handler\n#{err.stack or err}"

					res.off Routing.Response.DESTROY, callback
					callback handlerCallbackError

				log "Use `#{@method} #{@uri}` handler"

				utils.tryFunc @callback, @, [req, res, next], next

				null

#### toString()

		toString: ->

			"#{@method} #{@uri}"