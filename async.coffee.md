Asynchronous
============

	'use strict'

	[expect] = ['expect'].map require
	utils = null

	{exports} = module
	{assert} = console

	{shift} = Array::
	{isArray} = Array

	NOP = ->

utils.async.forEach(*NotPrimitive* array, *Function* callback, [*Function* onEnd, *Any* context])
-------------------------------------------------------------------------------------------------

Asynchronous version of standard `Array.prototype.forEach()` method works with arrays and
objects as well.

*callback* function is called with parameters:
 - for array given: element value, index, array, next callback
 - for object given: key, value, object, next callback

Each *callback* must call got *next callback* if it finished processing.

*onEnd* function is called when the last *callback* finished processing.

*context* argument is passing into the each *callback*.

### Example
```
toLoadInOrder = ['users.json', 'families.js', 'relationships.js']

utils.async.forEach toLoadInOrder, (elem, i, array, next) ->
  console.log "Load #{elem} file"
  # on load end ...
  next()
, ->
  console.log "All files are loaded!"

# Load users.json
# Load families.json
# load relationships.json
# All files are loaded!
```

	forEach = do ->

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
				if i is n
					return onEnd()

				# call callback func
				key = keys[i]
				callback.call thisArg, key, obj[key], obj, next

				# increase counter
				i++

			# start
			next()

		(list, callback, onEnd, thisArg) ->
			expect(list).not().toBe.primitive()
			expect(callback).toBe.function()
			expect().defined(onEnd).toBe.function()

			method = if isArray list then forArray else forObject
			method list, callback, onEnd, thisArg

			null

*Stack* utils.async.Stack()
---------------------------

Class used to store asynchronous functions in a proper order.

### Example
```
stack = new utils.async.Stack

load = (src, callback) ->
  console.log "Load #{src} file"
  # load file async ...
  # first callback parameter is an error ...
  callback null, "fiel data"

stack.add load, null, ['items.json']
stack.add load, null, ['users.json']

stack.runAllSimultaneously ->
  console.log "All files have been loaded!"

# Load items.json file
# Load users.json file
# All files have been loaded!

# or ... (simultaneous call has no order)

# Load users.json file
# Load items.json file
# All files have been loaded!
```

	class Stack

		constructor: ->

			###
			One-deep array of added functions in schema [function, context, args, ...]
			###
			@_arr = []

utils.async.Stack::add(*Function* function, [*Any* context, *NotPrimitive* arguments])
--------------------------------------------------------------------------------------

Adds new *function* to the stack.

*function* must provide *callback* argument as the last one.
First argument passing to the *callback* by the *function* is always an error.

### Example
```
stack = new utils.async.Stack

add = (a, b, callback) ->
  if isFinite(a) and isFinite(b)
    callback null, a+b
  else
    callback "Finite numbers are required!"

stack.add add, null, [1, 2]
```

		add: (func, context, args) ->
			expect().defined(args).toBe.object()

			@_arr.push func, context, args

utils.async.Stack::callNext(*Function* callback)
------------------------------------------------

Calls first function from the stack and remove it.

*callback* function gots all passed arguments by the called *function*.

		callNext: (callback) ->
			expect(callback).toBe.function()

			# on empty
			unless @_arr.length
				return callback()

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
			args = Object.create(args or null)
			args[func.length - 1] = callbackWrapper
			if args.length is undefined or args.length < func.length
				args.length = func.length

			# call; support sync errors
			syncError = utils.catchError func, context, args
			if syncError
				callbackWrapper syncError

			null

utils.async.Stack::runAll(*Function* callback)
----------------------------------------------

Calls all functions from the stack one by one.

*callback* function gots all passed arguments by the last called *function*.

Processing stops on error occurs, then *callback* function is called with got error.

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

			null

utils.async.Stack::runAllSimultaneously(*Function* callback)
------------------------------------------------------------

Calls all functions from the stack simultaneously (all at the same time).

Processing stops on error occurs, then *callback* function is called with got error.

		runAllSimultaneously: (callback) ->
			expect(callback).toBe.function()

			length = n = @_arr.length / 3
			done = 0

			unless length
				return callback()

			onDone = (err) ->
				++done

				if done > length
					return

				if err
					done = length
					return callback err

				if done is length
					callback()

			# run all functions
			while n--
				@callNext onDone

			null

	###
	Exports
	###
	module.exports = ->
		[utils] = arguments
		utils.async =
			forEach: forEach
			Stack: Stack
