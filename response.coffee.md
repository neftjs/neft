Response
========

	'use strict'

	[utils, expect, Emitter] = ['utils', 'expect', 'emitter'].map require

	{assert} = console

*class* Response
----------------

	module.exports = (Routing, impl) -> class Response extends Emitter

### Events

		@DESTROY = 'destroy'

### Static

#### Statuses

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

### Submodules

		@Error = require('./response/error.coffee.md') Routing, Response

### Constructor

		constructor: (opts) ->

			assert utils.isObject opts

			opts.status ?= Response.OK
			opts.data ?= null

			assert opts.req instanceof Routing.Request
			assert ~Response.STATUSES.indexOf opts.status
			assert typeof opts.data is 'object'

			super

			{@req, @status, @data} = opts
			@pending = true

### Properties

		pending: false
		req: null
		status: Response.OK
		data: null

### Methods

		setHeader: (name, val) ->
			expect(@pending).toBe.truthy()
			expect(name).toBe.truthy().string()
			expect(val).toBe.truthy().string()

			impl.setHeader.call @, name, val

			@

		send: (@status, @data) ->
			assert @pending
			assert ~Response.STATUSES.indexOf status

			@req.destroy()

			if data instanceof Error
				data = utils.errorToObject data

			impl.send.call @

			@

		raise: (error) ->
			assert @pending
			assert error instanceof Response.Error

			@send error.status, error

		isSucceed: ->

			300 > @status >= 200

		destroy: ->

			assert @pending
			assert not @req.pending

			@pending = false
			@trigger Response.DESTROY
