Utils for async
===============

	'use strict'

	[utils, expect] = ['./index.coffee.md', 'expect'].map require

	{exports} = module
	{assert} = console

	{shift} = Array::
	{isArray} = Array

	NOP = ->

*class* Stack
-------------

Store asynchronous functions in list.
Functions have to provide `callback` as last parameter.

	exports.Stack = class Stack

### Constructor

		constructor: ->

			@_arr = []

### Properties

#### Protected

		_arr: null

### Methods

#### add()

Add new asynchronous function into stack.

`func` is a name of function stored in `obj` or function to call;
`obj` is a namespace where specified `func` exists and context passed into function;
`args` are an array of arguments passed into function.

		add: (func, context, args) ->
			expect().defined(args).toBe.object()

			@_arr.push func, context, args

#### callNext()

Call next function from the stack.

`callback` is provided into function.

Empty `callback` will be called if there is no function to call.

		callNext: (callback) ->

			if typeof callback isnt 'function'
				throw new TypeError "ASync callNext(): passed callback is not a function"

			# on empty
			unless @_arr.length
				return callback null

			# get next
			func = @_arr.shift()
			context = @_arr.shift()
			args = @_arr.shift()

			if typeof func is 'string'
				func = context[func]

			if typeof func isnt 'function'
				throw new TypeError "ASync Stack::callNext(): function to call is not a function"

			syncError = null
			called = false

			callbackWrapper = ->
				assert not called or not syncError
				, "Callback can't be called if function throws an error;\n" +
				  "Function: `#{func}`\nSynchronous error: `#{syncError}`"

				assert not called
				, "Callback can't be called twice;\nFunction: `#{func}`"

				called = true
				callback.apply @, arguments

			# add callback into args
			# To avoid got args array modification and to minimise memory usage,
			# we create new object with `args` as a prototype.
			# `Function::apply` expects an object and iterate by it to the `length`.
			args = Object.create (args or null)
			args[func.length - 1] = callbackWrapper
			if args.length is undefined or args.length < func.length
				args.length = func.length

			# call; support sync errors
			syncError = utils.catchError func, context, args
			if syncError
				callbackWrapper syncError

#### runAll()

Run all stored functions in order.

`callback` has arguments from the last fulfilled or first rejected fuction.

		runAll: (callback) ->

			if typeof callback isnt 'function'
				throw new TypeError "ASync runAll(): passed callback is not a function"

			unless @_arr.length
				return callback null

			onNextCalled = (err) =>

				# on err
				if err
					return callback err

				# call next
				if @_arr.length
					return callNext()

				callback.apply null, arguments

			callNext = => @callNext onNextCalled

			callNext()

#### runAllSimultaneously()

Run all stored functions in the same time.

`callback` has arguments from the last fulfilled or first rejected fuction.

		runAllSimultaneously: (callback) ->

			if typeof callback isnt 'function'
				throw new TypeError "ASync runAllSimultaneously(): passed callback is not a function"

			length = n = @_arr.length / 3
			done = 0

			unless length
				return callback null

			onDone = (err) ->

				++done

				if done > length then return

				if err
					done = length
					return callback err

				if done is length
					callback.apply null, arguments

			# run all functions
			while n--
				@callNext onDone


forEach()
--------------

Check object or array like by standard Array::forEach but working asynchronously.
As last `callback` argument you will get `next` function. Call it when your
async code finished and you are ready to check next element.

As third argument you can optionally specify `onEnd` function which will
be called when all pairs will be checked.

For arrays callback gets: element, index, array, next.
For objects callback gets: key, value, object, next.

`thisArg` is using to call callbacks and it's returned by this method.

	exports.forEach = do ->

		forArray = (arr, callback, onEnd, thisArg) ->

			i = 0
			n = arr.length

			next = ->

				# return and call onEnd if there is no elements to check
				if i is n then return onEnd()

				# increase counter
				i++

				# call callback func
				callback.call thisArg, arr[i-1], i-1, arr, next

			# start
			next()

		forObject = (obj, callback, onEnd, thisArg) ->

			keys = Object.keys obj

			i = 0
			n = keys.length

			next = ->

				# return and call onEnd if there is no pairs to check
				if i is n then return onEnd()

				# call callback func
				key = keys[i]
				callback.call thisArg, key, obj[key], obj, next

				# increase counter
				i++

			# start
			next()

		(list, callback, onEnd, thisArg) ->

			if typeof list isnt 'object'
				throw new TypeError

			if typeof callback isnt 'function'
				throw new TypeError

			if typeof onEnd isnt 'function'
				onEnd = NOP

			method = if isArray list then forArray else forObject
			method list, callback, onEnd, thisArg

			thisArg