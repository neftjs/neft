'use strict'

utils = require 'utils'
assert = require 'neft-assert'

module.exports = (signal) -> class SignalsEmitter
	{callSignal} = signal

	NOP = ->

	handlerFunc = signal.createSignalFunction()

	@emitSignal = (obj, name, arg1, arg2) ->
		assert.isString name
		assert.notLengthOf name, 0
		assert.isFunction onInitialized if onInitialized?

		if listeners = obj._signals[name]
			callSignal obj, listeners, arg1, arg2
		return

	@createSignalOnObject = (obj, name, onInitialized) ->
		assert.isObject obj
		assert.isString name
		assert.notLengthOf name, 0
		assert.isFunction onInitialized if onInitialized?

		getter = ->
			assert.instanceOf @, SignalsEmitter

			# http://jsperf.com/dynamic-structures
			signals = @_signals
			unless listeners = signals[name]
				listeners = signals[name] = [null, null, null, null]
				onInitialized? @, name
			handlerFunc.obj = @
			handlerFunc.listeners = listeners

			handlerFunc

		utils.defineProperty obj, name, null, getter, null

		getter

	@createSignal = (ctor, name, onInitialized) ->
		assert.isFunction ctor
		SignalsEmitter.createSignalOnObject ctor::, name, onInitialized

	constructor: ->
		@_signals = {}
