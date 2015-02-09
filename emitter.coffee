'use strict'

utils = require 'utils'
assert = require 'assert'

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

			if listeners = @_events?[name]
				currentEmitter = @
				signalFunc
			else
				NOP

		handlerGetter = ->
			assert.instanceOf @, SignalsEmitter

			@_events ?= {}
			handlerFunc.listeners = @_events[name] ?= []

			handlerFunc

		utils.defineProperty ctor::, name, null, signalGetter, null

		handlerName = getHandlerName name
		utils.defineProperty ctor::, handlerName, null, handlerGetter, null

	constructor: ->
		@_events = null
