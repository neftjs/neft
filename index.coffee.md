Utils
=====

@author kildyt@gmail.com

@license MIT

	'use strict'

Utils for object, arrays and functions
--------------------------------------

### clone()

Clone array, object or function.
Prototype is copied (if exists).

	do (
		funcToString = Function::toString,
		isArray = Array.isArray,
		createObject = Object.create,
		getPrototypeOf = Object.getPrototypeOf
	) ->

		cloneArray = (arr) ->

			arr.slice()

		cloneObject = (obj) ->

			result = createObject getPrototypeOf obj

			for key, value of obj when obj.hasOwnProperty(key)

				result[key] = value

			result

		cloneFunction = (func) ->

			newFunc = null
			eval "newFunc=#{funcToString.call(func)}"

			newFunc[key] = value for key, value of func

			newFunc

		module.exports.clone = (arg) ->

			unless arguments.length
				throw new RangeError

			typeofArg = typeof arg

			return cloneFunction(arg) if typeofArg is 'function'
			return cloneArray(arg) if isArray arg
			return cloneObject(arg) if typeofArg is 'object'
			arg

### merge()

Merge second object into the first one.
Existed properties will be overriden.

	module.exports.merge = (source, obj) ->

		if not source or not obj
			throw new TypeError

		for key, value of obj

			source[key] = value

		source

Utils for objects and arrays
----------------------------

### isArguments()

Check if specified object is an arguments array.

	do (toString = Object::toString) ->

		module.exports.isArguments = (obj) ->

			unless arguments.length
				throw new RangeError

			toString.call(obj) is '[object Arguments]'

### isObject()

Check if arg is clear object (without any other prototypes).

	do (getPrototypeOf = Object.getPrototypeOf) ->

		module.exports.isObject = (obj) ->

			unless arguments.length
				throw new RangeError

			if typeof obj isnt 'object'
				return false

			proto = getPrototypeOf obj

			# comes from Object.create
			unless proto
				return true

			# one-proto object
			if (proto is Object::) and not getPrototypeOf(proto)
				return true

			false

### get()

Get needed value from the object. Arrays are supported.
If path can't be resolved, new get.OptionsArray is returned with
all possible results.
Separate properties in path by dots ('.').
For arrays add to property name two brackets ('[]')
- look at isStringArray method to check it in other way.

	module.exports.get = (obj, path='', target) ->

		switch typeof path

			when 'object'

				path = module.exports.clone path

			when 'string'

				# split path by dot's
				path = path.split '.'

			else

				throw new TypeError

		# check chunks
		for key, i in path

			# support array elements by `[]` chars
			if ~key.indexOf('[]') and key.slice(-2) is '[]'

				# get array key name
				key = key.substring 0, key.indexOf('[]')

				# cut path removing checked elements
				path = path.splice i

				# update current path elem without array brackets
				path[0] = path[0].substring key.length + 2

				# if current path is empty, remove it
				unless path[0].length then path.shift()

				# create target array if no exists
				target ?= new OptionsArray()

				# move to the key value if needed
				if key.length
					obj = obj[key]

				# return `undefined` if no value exists
				if typeof obj is 'undefined'
					return undefined

				# call this func recursive on all array elements
				# found results will be saved in the `target` array
				for elem in obj
					Object.get elem, path.join('.'), target

				# return `undefined` no nothing has been found
				unless target.length
					return undefined

				# return found elements
				return target

			# move to the next object value
			obj = obj[key]

			# break if no way exists
			if typeof obj isnt 'object'

				# if it is no end of path, return undefined
				if i isnt path.length - 1
					obj = undefined

				break

		# save obj into target array
		if target and typeof obj isnt 'undefined' then target.push obj

		obj

#### *class* get.OptionsArray()

Special version of Array, returned if result of the `get` method is a list
of possible values and not a proper value.

	module.exports.get.OptionsArray = class OptionsArray extends Array

		constructor: -> super

### forEachASYNC()

Check object or array as by standard Array::forEach but working asynchronously.
As last `callback` argument you will get `next` function. Call it when your
async code finished and you are ready to check next pair.

As third argument you can optionally specify `onEnd` function which will
be called when all pairs will be checked.

For arrays callback get: element, index, array, next.
For objects callback get: key, value, object, next.

`thisArg` is using to call callbacks and it's returned by this method.

	module.exports.forEachASYNC = do (isArray = Array.isArray, NOP = ->) ->

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

		(arg, callback, onEnd, thisArg) ->

			if typeof arg isnt 'object'
				throw new TypeError

			if typeof callback isnt 'function'
				throw new TypeError

			if typeof onEnd isnt 'function'
				onEnd = NOP

			method = if isArray arg then forArray else forObject
			method arg, callback, onEnd, thisArg

			thisArg

### isEmpty()

Check if specified object or array is empty.
Proto is not checking.

	do (isArray = Array.isArray) ->

		module.exports.isEmpty = (arg) ->

			if typeof arg isnt 'object'
				throw new TypeError

			if isArray arg
				return !!arg.length

			return false for key of arg
			true

### last()

Get last element from the Object or Array

	do (isArray = Array.isArray, objKeys = Object.keys) ->

		module.exports.last = (arg) ->

			if typeof arg isnt 'object'
				throw new TypeError

			# Array
			if isArray arg
				return arg[arg.length - 1]

			# Object
			keys = objKeys arg
			arg[keys[keys.length - 1]]


Utils for arrays
----------------

### arrayToObject()

Save parsed array into `target` (new object by default) and return it.
Use optionally `keyGen` and `valueGen` to specify custom keys and values
(by default key is current index, and value refers to array element).
`keyGen` and `valueGen` get current element, current index and array.

	do (isArray = Array.isArray) ->

		module.exports.arrayToObject = (arr, keyGen, valueGen, target={}) ->

			throw new TypeError unless isArray arr
			keyGen = null if typeof keyGen isnt 'function'
			valueGen = null if typeof valueGen isnt 'function'

			for elem, i in arr

				key = if keyGen then keyGen(elem, i, arr) else i
				value = if valueGen then valueGen(elem, i, arr) else elem

				target[key] = value

			target

Utils for strings
-----------------

### capitalize()

	module.exports.capitalize = (arg) ->

		arg += ''

		return '' unless arg.length
		arg[0].toUpperCase() + arg.substring(1)

### isStringArray()

Check if string references into array (according to notation in `get` method).

	module.exports.isStringArray = (arg) ->

		arg += ''
		arg.slice(-2) is '[]'