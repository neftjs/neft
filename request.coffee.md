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
			assert ~Routing.METHODS.indexOf(opts.method)
			assert typeof opts.url is 'string'
			assert typeof opts.body is 'object'

			super

			{@method, @url, @body} = opts
			@uid = utils.uid()
			@pending = true
			@params = null

### Properties

		uid: ''
		pending: false
		method: 0
		url: ''
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
