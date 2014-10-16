Response
========

	'use strict'

	[utils, expect] = ['utils', 'expect'].map require
	log = require 'log'
	signal = require 'signal'

	log = log.scope 'Routing', 'Response'

	{assert} = console

*class* Response
----------------

	module.exports = (Routing, Impl) -> class Response

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

			if opts instanceof Routing.Request
				opts: req: opts

			expect(opts).toBe.simpleObject()
			expect(opts.req).toBe.any Routing.Request
			expect().some(Response.STATUSES).toBe opts.status if opts.status?

			{@req} = opts
			{@status} = opts if opts.status?
			{@data} = opts if opts.data?

			@pending = true

			if opts.status?
				@destroy()

			# whether response will be send on the next tick
			utils.defProp @, '_waitingToSend', 'w', false

			# signals
			signal.create @, 'sent'

### Properties

		pending: false
		req: null
		status: 0
		data: null

### Methods

		setHeader: (name, val) ->
			expect(@pending).toBe.truthy()
			expect(name).toBe.truthy().string()
			expect(val).toBe.truthy().string()

			Impl.setHeader @, name, val

			@

		send: (@status, data) ->
			assert @pending
			assert ~Response.STATUSES.indexOf status

			if @data
				log.info "`#{@req.uri}` response data has been overwritten, because " +
				         "`send()` method has been called twice"

			@data = data

			unless @_waitingToSend
				@_waitingToSend = true
				@req.destroy()
				setImmediate => sendData @

			@

		sendData = (res) ->
			expect(res).toBe.any Response
			expect(res.pending).toBe.truthy()

			res.pending = false

			# call request signal
			res.req.loaded @

			# send it!
			Impl.send res, res.data, ->
				# signal
				res.sent()

		raise: (error) ->
			assert error instanceof Response.Error

			@send error.status, error

		isSucceed: ->

			300 > @status >= 200
