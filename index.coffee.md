Unit @library
=============

	'use strict'

	utils = require 'neft-utils'
	log = require 'neft-log'

	{isArray} = Array

	ERROR_STACK_MAX_LENGTH = 500

	class Describe
		constructor: ->
			@message = ''
			@tests = []
			@beforeFunctions = []

	class Test
		constructor: ->
			@message = ''
			@testFunction = utils.NOP
			@onDone = null

	scopes = [new Describe]
	messages = []
	currentScope = scopes[0]
	currentTest = null

	errorToString = (err) ->
		msg = ''
		if err.stack
			specFileLine = /^.+\.spec\.[a-z]+:\d+:\d+$/m.exec err.stack
			if specFileLine?
				msg += specFileLine[0] + "\n"
			if err.stack.length > ERROR_STACK_MAX_LENGTH
				msg += "#{err.stack.slice(0, ERROR_STACK_MAX_LENGTH)}…"
			else
				msg += err.stack
		else
			msg += err
		msg

	printError = (err) ->
		log.error messages.join(' ')
		console.error errorToString(err)
		return

	tryFunction = (func, context, args) ->
		try
			func.apply context, args
			true
		catch err
			printError err
			false

Unit.describe(*String* message, *Function* tests)
-------------------------------------------------

	exports.describe = (msg, func) ->
		beforeEach = utils.NOP

		describe = new Describe
		describe.message = msg
		Array::push.apply describe.beforeFunctions, currentScope.beforeFunctions

		currentScope.tests.push describe
		scopes.push describe
		currentScope = describe
		func()
		scopes.pop()
		currentScope = utils.last scopes
		return

Unit.it(*String* message, *Function* test)
------------------------------------------

The given test function can contains optional *callback* argument.

	exports.it = (msg, func) ->
		testScope = currentScope

		callFunc = (callback) ->
			currentTest = test
			callbackCalled = false
			callCallback = test.onEnd = ->
				unless callbackCalled
					callbackCalled = true
					callback()
				return

			# call before functions
			for beforeFunc in testScope.beforeFunctions
				beforeFunc()

			# call test function
			if func.length is 0
				tryFunction func
				callCallback()
			else
				unless tryFunction(func, null, [callCallback])
					callCallback()

		test = new Test
		test.message = msg
		test.testFunction = callFunc

		utils.last(scopes).tests.push test
		return

Unit.beforeEach(*Function* code)
--------------------------------

	exports.beforeEach = (func) ->
		currentScope.beforeFunctions.push func
		return

Unit.whenChange(*Object* watchObject, *Function* callback, [*Integer* maxDelay = `1000`])
-----------------------------------------------------------------------------------------

	exports.whenChange = do ->
		listeners = []

		class Listener
			constructor: ->
				@object = null
				@objectCopy = null
				@callback = null
				@maxDelay = 1000
				@createTimestamp = Date.now()

		checkListeners = ->
			i = 0
			while i < listeners.length
				listener = listeners[i]

				if not utils.isEqual(listener.object, listener.objectCopy, 1)
					listeners.shift()
					unless tryFunction(listener.callback)
						currentTest.onEnd()
				else if Date.now() - listener.createTimestamp > listener.maxDelay
					listeners.shift()
					printError new Error "unit.whenChange waits too long"
					currentTest.onEnd()
				else
					i++

			if listeners.length > 0
				setImmediate checkListeners
			return

		(obj, callback, maxDelay=1000) ->
			listener = new Listener
			listener.object = obj
			listener.objectCopy = utils.clone(obj)
			listener.callback = callback
			listener.maxDelay = maxDelay

			if listeners.length is 0
				setImmediate checkListeners
			listeners.push listener
			return

	do ->
		runStack = (stack, callback) ->
			if stack.message
				messages.push stack.message
			runStackElements stack, ->
				if stack.message
					messages.pop()
				callback()
			return

		runStackElements = (stack, callback, i=0) ->
			if i < stack.tests.length
				element = stack.tests[i]

				callNextElement = ->
					runStackElements stack, callback, i+1

				if element instanceof Describe
					return runStack element, callNextElement
				if element instanceof Test
					return runStackElement element, callNextElement
			else
				callback()
			return

		runStackElement = (test, callback) ->
			messages.push test.message
			test.testFunction ->
				messages.pop()
				callback()
			return

		setImmediate ->
			runStack scopes[0], ->
