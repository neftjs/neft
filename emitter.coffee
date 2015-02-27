'use strict'

utils = require 'utils'
assert = require 'neft-assert'

module.exports = (signal) -> class SignalsEmitter

	{getHandlerName, callSignal} = signal

	NOP = ->

	handlerFunc = signal.createHandlerFunction()

	listeners = currentEmitter = defaultContext = null
	signalFunc = ->
		assert.instanceOf currentEmitter, SignalsEmitter
		assert.isArray listeners
		assert.isDefined defaultContext

		callSignal currentEmitter, listeners, arguments, defaultContext

	@createSignal = (ctor, name, internalName=name, contextProp, onInitialized) ->
		assert.isFunction ctor
		assert.isString name
		assert.notLengthOf name, 0
		assert.isString internalName
		assert.notLengthOf internalName, 0
		assert.isFunction onInitialized if onInitialized?

		signalGetter = ->
			assert.instanceOf @, SignalsEmitter

			if listeners = @_signals?[internalName]
				currentEmitter = @
				defaultContext = if contextProp then @[contextProp] else @
				signalFunc
			else
				NOP

		handlerGetter = ->
			assert.instanceOf @, SignalsEmitter

			# http://jsperf.com/dynamic-structures
			signals = @_signals ?= {}
			listeners = signals[internalName]
			unless listeners
				listeners = signals[internalName] = []
				onInitialized? @, name, internalName
			handlerFunc.listeners = listeners

			handlerFunc

		utils.defineProperty ctor::, name, null, signalGetter, null

		handlerName = getHandlerName name
		utils.defineProperty ctor::, handlerName, null, handlerGetter, null

		handlerGetter

	constructor: ->
		@_signals = null
