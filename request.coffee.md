Request
=======

	'use strict'

	[utils, Emitter, Model, _] = ['utils', 'emitter', 'model', 'model-view'].map require

	{assert} = console

	Model = Model.View()

*class* Request
---------------

	module.exports = (Routing, impl) -> class Request extends Emitter

### Events

		@DESTROY = 'destroy'

### Static

### Constructor(*Object*)

		constructor: (opts) ->

			assert utils.isObject opts

			opts.type ?= Request::type

			assert opts.uid and typeof opts.uid is 'string'
			assert ~Routing.METHODS.indexOf(opts.method)
			assert typeof opts.uri is 'string'
			assert typeof opts.data is 'object'
			assert Model.TYPES & opts.type

			super

			{@uid, @method, @uri, @data, @type} = opts
			@pending = true
			@params = null

### Properties

		uid: ''
		pending: false
		method: 0
		uri: ''
		params: null
		data: null
		type: Model.VIEW

### Methods

		destroy: ->

			assert @pending

			@pending = false
			@trigger Request.DESTROY

		Object.defineProperty @::, 'userAgent',
			get: -> impl.getUserAgent.call(@) or ''