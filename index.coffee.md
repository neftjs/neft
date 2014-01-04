Utils
=====

**Author:** *kildyt@gmail.com*

**License:** *MIT*

	'use strict'

	toString = Object::toString
	funcToString = Function::toString
	isArray = Array.isArray
	createObject = Object.create
	getPrototypeOf = Object.getPrototypeOf
	objKeys = Object.keys
	hasOwnProp = Object.hasOwnProperty
	{random} = Math

Include sub-modules
-------------------

	exports.async = require './async.coffee.md'

Environment information
-----------------------

	exports.isNode = exports.isBrowser = exports.isQML = false

	switch true

		when global?+'' is '[object global]'
			exports.isNode = true

		when window?.document?
			exports.isBrowser = true

		when Qt?.include
			exports.isQML = true

Utils for object, arrays and functions
--------------------------------------

### clone()

Clone array, object or function.
Prototype is copied (if exists).

	exports.clone = do ->

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

		(arg) ->

			unless arguments.length
				throw new RangeError

			typeofArg = typeof arg

			return cloneFunction(arg) if typeofArg is 'function'
			return cloneArray(arg) if isArray arg
			return cloneObject(arg) if arg and typeofArg is 'object'
			arg

### cloneDeep()

	exports.cloneDeep = (arg) ->

		result = exports.clone arg

		if result
			for key, value of result when hasOwnProp.call result, key
				result[key] = exports.cloneDeep value

		result

### merge()

Merge second object into the first one.
Existed properties will be overriden.

	exports.merge = (source, obj) ->

		if not source or not obj
			throw new TypeError

		for key, value of obj

			source[key] = value

		source

Utils for objects and arrays
----------------------------

### isArguments()

Check if specified object is an arguments array.

	exports.isArguments = (obj) ->

		unless arguments.length
			throw new RangeError

		toString.call(obj) is '[object Arguments]'

### isObject()

Check if arg is clear object (without any other prototypes).

	exports.isObject = (obj) ->

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

	get = exports.get = (obj, path='', target) ->

		switch typeof path

			when 'object'

				path = exports.clone path

			when 'string'

				# split path by dot's
				path = path.split '.'

			else

				throw new TypeError

		# check chunks
		for key, i in path

			# empty props are not supported
			if not key.length and i
				throw new ReferenceError "utils.get(): empty properties are not supported"

			# support array elements by `[]` chars
			if isStringArray key

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
					get elem, path.join('.'), target

				# return `undefined` if nothing has been found
				unless target.length
					return undefined

				# return found elements
				return target

			# move to the next object value
			if key.length then obj = obj[key]

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

	exports.get.OptionsArray = class OptionsArray extends Array

		constructor: -> super

### isEmpty()

Check if specified object or array is empty.
Proto is not checking.

	exports.isEmpty = (arg) ->

		if typeof arg isnt 'object'
			throw new TypeError

		if isArray arg
			return !arg.length

		return false for key of arg
		true

### last()

Get last element from the Object or Array

	exports.last = (arg) ->

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

	exports.arrayToObject = (arr, keyGen, valueGen, target={}) ->

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

	exports.capitalize = (arg) ->

		arg += ''

		return '' unless arg.length
		arg[0].toUpperCase() + arg.substring(1)

### isStringArray()

Check if string references into array (according to notation in `get` method).

	isStringArray = exports.isStringArray = (arg) ->

		arg += ''
		arg.slice(-2) is '[]'

### addSlashes()

New string with added backslashes before `'` and `"` is returned.

	exports.addSlashes = do ->

		SLASHES_RE = ///'|"///g
		NEW_SUB_STR = '\\$&'

		(str) ->

			if typeof str isnt 'string'
				throw new TypeError

			unless str then return str

			str.replace SLASHES_RE, NEW_SUB_STR

### uid()

Generate unique hash. Length of returned string can be specified (default 8).

	exports.uid = (n=8) ->

		if typeof n isnt 'number' or not isFinite(n)
			throw new TypeError

		str = ''

		loop
			str += random().toString(16).slice 2
			if str.length >= n then break

		str.slice 0, n

Utils for errors
----------------

### errorToObject()

Parse native `Error` instance into *pure* object.

	exports.errorToObject = (error) ->

		unless error instanceof Error
			throw new TypeError

		name: error.name
		message: error.message