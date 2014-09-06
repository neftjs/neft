Request
=======

	'use strict'

	[utils, expect, Emitter] = ['utils', 'expect', 'emitter'].map require

	{assert} = console

*class* Request
---------------

	module.exports = (Routing, impl) -> class Request extends Emitter

		@TYPES = [
			(@VIEW_TYPE = 'view')
		]

### Events

		@DESTROY = 'destroy'

### Static

### Constructor(*Object*)

		constructor: (opts) ->
			expect(opts).toBe.simpleObject()

			expect(opts.uid).toBe.truthy().string()
			expect().some(Routing.METHODS).toBe opts.method
			expect(opts.uri).toBe.string()

			if opts.data?
				expect().defined(opts.data).toBe.object()
				{@data} = opts

			if opts.type?
				expect().some(Request.TYPES).toBe opts.type
				{@type} = opts

			{@uid, @method, @uri} = opts

			super

			@pending = true
			@params = null

### Properties

		uid: ''
		pending: false
		method: Routing.GET
		uri: ''
		params: null
		data: null
		type: @VIEW_TYPE

### Methods

		destroy: ->

			assert @pending

			@pending = false
			@trigger Request.DESTROY

		Object.defineProperty @::, 'userAgent',
			get: -> impl.getUserAgent.call(@) or ''