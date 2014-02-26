Response
========

	'use strict'

	[assert, utils, Events] = ['assert', 'utils', 'Events'].map require

*class* Response
----------------

	pool = []

	module.exports = (Routing, impl) -> class Response extends Events

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

#### *Response* factory()

		@factory = (req) ->

			# from pool
			if res = pool.pop()
				Response.call res, req
				return res

			# create new
			new Response req

### Constructor

		constructor: (req) ->

			assert req instanceof Routing.Request

			super

			@req = req

### Properties

		req: null
		status: Response.OK
		data: null

### Methods

		send: (@status, @data) ->

			assert ~Response.STATUSES.indexOf status

			if data instanceof Error
				data = utils.errorToObject data

			impl.send.call @
			@destroy()

		raise: (error) ->

			assert error instanceof Response.Error

			@send error.status, error

		destroy: ->

			@trigger Response.DESTROY
			@off()

			@req.destroy()

			pool.push @

			null