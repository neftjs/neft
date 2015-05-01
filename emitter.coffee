'use strict'

utils = require 'utils'
assert = require 'neft-assert'

module.exports = (signal) -> class SignalsEmitter

	{getHandlerName, callSignal} = signal

	NOP = ->

	handlerFunc = signal.createHandlerFunction()

	tmpArr = []
	@createSignal = (ctor, name, onInitialized) ->
		assert.isFunction ctor
		assert.isString name
		assert.notLengthOf name, 0
		assert.isFunction onInitialized if onInitialized?

		ctor::[name] = (arg1, arg2) ->
			assert.operator arguments.length, '<', 3, 'Signal accepts maximally two parameters; use object instead'

			callSignal @, @_signals[name] or tmpArr, arg1, arg2

		handlerGetter = ->
			assert.instanceOf @, SignalsEmitter

			# http://jsperf.com/dynamic-structures
			signals = @_signals
			listeners = signals[name]
			unless listeners
				listeners = signals[name] = []
				onInitialized? @, name
			handlerFunc.listeners = listeners

			handlerFunc

		handlerName = getHandlerName name
		utils.defineProperty ctor::, handlerName, null, handlerGetter, null

		handlerGetter

	constructor: ->
		@_signals = {}
