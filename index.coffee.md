Unit @library
=============

	'use strict'

	utils = require 'neft-utils'
	log = require 'neft-log'
	stack = require './stack'
	logger = require './logger'

	{isArray} = Array
	{push} = Array::
	{Scope, Test, Listener} = require './structure'

	scopes = [new Scope]
	currentScope = scopes[0]

Unit.describe(*String* message, *Function* tests)
-------------------------------------------------

	exports.describe = (msg, func) ->
		beforeEach = utils.NOP

		# new scope
		scope = new Scope
		scope.message = msg
		scopes.push scope

		# before/after functions
		push.apply scope.beforeFunctions, currentScope.beforeFunctions
		push.apply scope.afterFunctions, currentScope.afterFunctions

		# save scope to parent
		currentScope.children.push scope
		scope.parent = currentScope

		# save as last
		currentScope = scope

		# filter children tests
		try
			func()
		catch err
			console.error err

		# set parent as last
		scopes.pop()
		currentScope = utils.last scopes
		return

Unit.it(*String* message, *Function* test)
------------------------------------------

The given test function can contains optional *callback* argument.

	exports.it = (msg, func) ->
		testScope = currentScope

		# new test
		test = new Test
		test.message = msg
		test.testFunction = func

		# add test into scope
		scope = utils.last scopes
		scope.children.push test
		test.parent = scope

		return

Unit.beforeEach(*Function* code)
--------------------------------

	exports.beforeEach = (func) ->
		currentScope.beforeFunctions.push func
		return

Unit.afterEach(*Function* code)
-------------------------------

	exports.afterEach = (func) ->
		currentScope.afterFunctions.push func
		return

Unit.whenChange(*Object* watchObject, *Function* callback, [*Integer* maxDelay = `1000`])
-----------------------------------------------------------------------------------------

	exports.whenChange = do ->
		listeners = []

		checkListeners = ->
			i = 0
			while i < listeners.length
				listener = listeners[i]

				if listener.test()
					listeners.splice i, 1
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

Unit.runTests()
---------------

	exports.runTests = ->
		[mainScope] = scopes
		mainScope.run ->
			logger.onTestsEnd()
			exports.onTestsEnd stack.errors

*Function* Unit.onTestsEnd
--------------------------

	exports.onTestsEnd = (errors) ->
		code = if errors.length > 0 then 1 else 0
		process.exit code

*Boolean* Unit.runAutomatically = true
--------------------------------------

	exports.runAutomatically = true

	setImmediate ->
		unless exports.runAutomatically
			return
		exports.runTests()
