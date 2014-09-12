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

#### exec(*Request*, *Response*)

		exec: do (uriNotValidError = new UriNotValidError,
		          handlerCallbackError = new HandlerCallbackError) ->

			(req, res, next) ->

				assert req instanceof Routing.Request
				assert res instanceof Routing.Response

				# compare methods
				if @method isnt req.method
					return next uriNotValidError

				# test uri
				unless @uri.test req.uri
					return next uriNotValidError

				params = req.params = @uri.match req.uri

				# validate by schema
				if @schema

					# parse params into expected types
					for key, schemaOpts of @schema.schema
						if params.hasOwnProperty(key) and schemaOpts.type
							params[key] = utils.tryFunc parse, null, [params[key]], params[key]

					# validate schema
					err = utils.catchError @schema.validate, @schema, [params]
					if err instanceof Error
						log "`#{@uri}` tests, but not passed schema\n#{err}"
						return next err

				# on callback fail
				callbackNext = (err) =>

					req.handler = null

					if err
						log.error "Error raised in `#{@uri}` handler\n#{err.stack or err}"

					next handlerCallbackError

				log "Use `#{@method} #{@uri}` handler"

				req.handler = @
				utils.tryFunc @callback, @, [req, res, callbackNext], callbackNext

				null

#### toString()

		toString: ->

			"#{@method} #{@uri}"