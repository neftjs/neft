Utils for async
===============

	'use strict'

	exports = module.exports

	shift = Array::shift
	isArray = Array.isArray

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

`obj` is a namespace where specified `func` exists and context passed into function;
`func` is a name of function stored in `obj` or function to call;
`args...` are an arguments passed into function.

		add: (obj, func, args...) ->

			if typeof func is 'string' and (not obj or typeof obj isnt 'object')
				throw new TypeError "ASync Stack::add(): passed obj is not an object"

			@_arr.push obj, func, args

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
			obj = @_arr.shift()
			func = @_arr.shift()
			args = @_arr.shift()

			if typeof func is 'string'
				func = obj[func]

			if typeof func isnt 'function'
				throw new TypeError "ASync Stack::callNext(): function to call is not a function"

			# add callback
			args[func.length - 1] = callback

			# call; support sync errors
			try
				func.apply obj, args
			catch e
				callback e

#### runAll()

Run all stored functions in order.

`callback` has arguments from the last fulfilled or first rejected fuction.

		runAll: (callback) ->

			if typeof callback isnt 'function'
				throw new TypeError "ASync runAll(): passed callback is not a function"

			onNextCalled = =>

				# call next
				if @_arr.length
					return callNext()

				callback.apply null, arguments

			callNext = @callNext.bind @, onNextCalled

			callNext()

#### runAllSimultaneously()

Run all stored functions in the same time.

`callback` has arguments from the last fulfilled or first rejected fuction.

		runAllSimultaneously: (callback) ->

			if typeof callback isnt 'function'
				throw new TypeError "ASync runAllSimultaneously(): passed callback is not a function"

			length = n = @_arr.length
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


forEachASYNC()
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

			next = =>

				# return and call onEnd if there is no elements to check
				if i is n then return onEnd()

				# call callback func
				callback.call thisArg, arr[i], i, arr, next

				# increase counter
				i++

			# start
			next()

		forObject = (obj, callback, onEnd, thisArg) ->

			keys = Object.keys obj

			i = 0
			n = keys.length

			next = =>

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