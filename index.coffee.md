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

	argOpts = do ->
		opts = process.argv[2]
		try
			JSON.parse opts
		catch
			{}

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

		# save as last
		currentScope = scope

		# filter children tests
		func()

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
		utils.last(scopes).children.push test

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

	###
	Run
	###
	setImmediate ->
		[mainScope] = scopes

		# file message
		if title = argOpts.title
			mainScope.message = title

		# bootstrap duration
		if startTime = argOpts.startTime
			duration = Date.now() - startTime
			ms = duration.toFixed 2
			mainScope.message += " (#{ms}ms)"

		# run main scope
		mainScope.run ->
			code = if stack.errors.length > 0 then 1 else 0
			logger.printLogs()
			process.exit code
