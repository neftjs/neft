'use strict'

utils = require 'neft-utils'
stack = require './stack'
logger = require './logger'

class Scope
	constructor: ->
		@message = ''
		@children = []
		@beforeFunctions = []
		@afterFunctions = []
		Object.seal @

	run: do ->
		forEachCallback = (child, i, arr, callback) ->
			stack.currentScope = @
			child.run callback

		(callback) ->
			Object.freeze @
			logger.onScopeStart @
			utils.async.forEach @children, forEachCallback, ->
				logger.onScopeEnd @
				callback()
			, @
			return

class Test
	constructor: ->
		@_callbackCalled = false
		@_callback = null
		@fulfilled = true
		@message = ''
		@testFunction = utils.NOP
		@onDone = null
		@onEnd = utils.bindFunctionContext @onEnd, @
		Object.seal @

	onEnd: ->
		if @_callbackCalled
			return

		@_callbackCalled = true
		logger.onTestEnd @

		# call after functions
		for afterFunc in stack.currentScope.afterFunctions
			afterFunc()

		@_callback()

		return

	run: (callback) ->
		stack.currentTest = @
		@_callback = callback

		logger.onTestStart @

		# call before functions
		for beforeFunc in stack.currentScope.beforeFunctions
			beforeFunc()

		# call test function
		if @testFunction.length is 0
			stack.callFunction @testFunction
			@onEnd()
		else
			unless stack.callFunction(@testFunction, null, [@onEnd])
				@onEnd()

		return

class Listener
	constructor: ->
		@object = null
		@objectCopy = null
		@callback = null
		@maxDelay = 1000
		@createTimestamp = Date.now()
		Object.seal @

	test: ->
		if not utils.isEqual(@object, @objectCopy, 1)
			unless stack.callFunction(@callback)
				stack.currentTest.onEnd()
			return true

		if @maxDelay > 0 and Date.now() - @createTimestamp > @maxDelay
			stack.fail new Error "unit.whenChange waits too long"
			stack.currentTest.onEnd()
			return true

		false

exports.Scope = Scope
exports.Test = Test
exports.Listener = Listener
