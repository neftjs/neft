Request
=======

	'use strict'

	[utils, Emitter] = ['utils', 'emitter'].map require

	{assert} = console

*class* Request
---------------

	pool = []

	module.exports = (Routing, impl) -> class Request extends Emitter

### Events

		@DESTROY = 'destroy'

### Static

#### *Request* factory(*Object*)

		@factory = (opts) ->

			# from pool
			if req = pool.pop()
				Request.call req, opts
				return req

			# create new
			new Request opts

### Constructor(*Object*)

		constructor: (opts) ->

			assert utils.isObject opts
			assert opts.uid and typeof opts.uid is 'string'
			assert ~Routing.METHODS.indexOf(opts.method)
			assert typeof opts.uri is 'string'
			assert typeof opts.body is 'object'

			super

			{@uid, @method, @uri, @body} = opts
			@pending = true
			@params = null

### Properties

		uid: ''
		pending: false
		method: 0
		uri: ''
		params: null
		body: null

### Methods

		destroy: ->

			@trigger Request.DESTROY
			@off()

			@pending = false
			pool.push @

			null

		valueOf: -> @uid

		Object.defineProperty @::, 'userAgent', get: ->
			impl.getUserAgent.call(@) or ''