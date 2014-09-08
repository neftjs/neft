Request
=======

	'use strict'

	[utils, expect, Emitter] = ['utils', 'expect', 'emitter'].map require
	signal = require 'signal'

	{assert} = console

*class* Request
---------------

	module.exports = (Routing, impl) -> class Request extends Emitter

		@METHODS = [
			(@GET = 'get'),
			(@POST = 'post'),
			(@PUT = 'put'),
			(@DELETE = 'delete'),
			(@OPTIONS = 'options')
		]

		@TYPES = [
			(@OBJECT_TYPE = 'object'),
			(@VIEW_TYPE = 'view')
		]

### Events

		@DESTROY = 'destroy'

### Static

### Constructor(*Object*)

		constructor: (opts) ->
			expect(opts).toBe.simpleObject()

			expect().defined(opts.uid).toBe.truthy().string()
			expect().some(Request.METHODS).toBe opts.method if opts.method?
			expect(opts.uri).toBe.string()

			if opts.data?
				expect().defined(opts.data).toBe.object()
				{@data} = opts

			if opts.type?
				expect().some(Request.TYPES).toBe opts.type
				{@type} = opts

			{@uid, @uri} = opts
			{@method} = opts if opts.method?
			@uid ?= utils.uid()

			super

			@pending = true
			@params = null

### Properties

		uid: ''
		pending: false
		method: Request.GET
		uri: ''
		params: null
		data: null
		type: @VIEW_TYPE

		signal.defineGetter @::, 'onLoad'

### Methods

		destroy: ->

			assert @pending

			@pending = false
			@trigger Request.DESTROY

		Object.defineProperty @::, 'headers',
			get: -> impl.getHeaders.call(@) or {}

		Object.defineProperty @::, 'userAgent',
			get: -> impl.getUserAgent.call(@) or ''