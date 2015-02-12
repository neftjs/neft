'use strict'

utils = require 'utils'
assert = require 'neft-assert'

module.exports = (signal) -> class SignalsEmitter

	{getHandlerName, callSignal} = signal

	NOP = ->

	handlerFunc = signal.createHandlerFunction()

	listeners = currentEmitter = null
	signalFunc = ->
		assert.instanceOf currentEmitter, SignalsEmitter
		assert.isArray listeners

		callSignal currentEmitter, listeners, arguments

	@createSignal = (ctor, name) ->
		assert.isFunction ctor
		assert.isString name
		assert.notLengthOf name, 0

		signalGetter = ->
			assert.instanceOf @, SignalsEmitter

			if listeners = @_signals?[name]
				currentEmitter = @
				signalFunc
			else
				NOP

		handlerGetter = ->
			assert.instanceOf @, SignalsEmitter

			# http://jsperf.com/dynamic-structures
			@_signals ?= {}
			handlerFunc.listeners = @_signals[name] ?= []

			handlerFunc

		utils.defineProperty ctor::, name, null, signalGetter, null

		handlerName = getHandlerName name
		utils.defineProperty ctor::, handlerName, null, handlerGetter, null

	constructor: ->
		@_signals = null
