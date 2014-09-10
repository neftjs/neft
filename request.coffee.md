Request
=======

	'use strict'

	[utils, expect] = ['utils', 'expect'].map require
	signal = require 'signal'

	{assert} = console

*class* Request
---------------

	module.exports = (Routing, Impl) -> class Request

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

			@pending = true
			@params = null

			# signals
			signal.create @, 'destroyed'
			signal.create @, 'loaded'

### Properties

		uid: ''
		pending: false
		method: Request.GET
		uri: ''
		params: null
		data: null
		type: @OBJECT_TYPE

### Methods

		destroy: ->

			assert @pending

			@pending = false
			@destroyed()

		Object.defineProperty @::, 'headers',
			get: -> Impl.getHeaders(@) or {}

		Object.defineProperty @::, 'userAgent',
			get: -> Impl.getUserAgent(@) or ''