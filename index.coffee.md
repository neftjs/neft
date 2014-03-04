Utils
=====

**Author:** *kildyt@gmail.com*

**License:** *MIT*

	'use strict'

	assert = require 'assert'

	{toString} = Object::
	funcToString = Function::toString
	{isArray} = Array
	{shift, pop} = Array::
	createObject = Object.create
	getPrototypeOf = Object.getPrototypeOf
	objKeys = Object.keys
	hasOwnProp = Object.hasOwnProperty
	getObjOwnPropDesc = Object.getOwnPropertyDescriptor
	defObjProp = Object.defineProperty
	{random} = Math

Include sub-modules
-------------------

	exports.async = require './async.coffee.md'

Environment information
-----------------------

	exports.isNode = exports.isBrowser = exports.isQML = false

	switch true

		when global? and global+'' is '[object global]'
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

	merge = exports.merge = (source, obj) ->

		if not source or not obj
			throw new TypeError

		for key, value of obj when obj.hasOwnProperty(key)
			source[key] = value

		source

### mergeDeep()

Merge second object into the first one deeply.

	mergeDeep = exports.mergeDeep = (source, obj) ->

		assert source and typeof source is 'object'
		assert obj and typeof obj is 'object'

		for key, value of obj when hasOwnProp.call obj, key
			sourceValue = source[key]

			if value and typeof value is 'object' and sourceValue and typeof sourceValue is 'object'
				mergeDeep sourceValue, value
				continue

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

		if not obj or typeof obj isnt 'object'
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

### clear()

Remove all elements from the array, or all properties from the object.

	exports.clear = (obj) ->

		assert obj and typeof obj is 'object'

		# Array
		if isArray obj
			obj.pop() for _ in [0...obj.length] by 1
			return obj

		# Object
		delete obj[key] for key of obj when obj.hasOwnProperty key
		obj

### simplify()

Convert passed object into the most simplified format.
Such object can be easily stringified.
Use `assemble()` method to restore into initial structure.

Second optional parameter is an config object.
Possible options to define (all are `false` by default):
  - `properties` - save properties with config,
  - `protos` - save proto
  - `constructors` - include constructors functions

Example
  1. ```
     obj = {}
     obj.self = obj
     JSON.parse utils.simplify obj
     ```

	exports.simplify = (obj, opts={}) ->

		assert obj and typeof obj is 'object'
		opts? and assert exports.isObject opts

		optsProps = opts.properties ?= false
		optsProtos = opts.protos ?= false
		optsCtors = opts.constructors ?= false

		# list of objects
		objs = []

		# list of lists of ids per object
		ids = []

		# lists of keys to references per object
		references = {}

		# objects constructors
		if optsCtors then ctors = {}

		# proto destination to proto object
		if optsProtos then protos = {}

		# get cyclic references in the object
		cyclic = (obj) ->

			len = objs.push obj
			ids.push objIds = []

			for key, value of obj when obj.hasOwnProperty key

				unless value and typeof value is 'object'
					continue

				# check whether obj already exists
				unless ~(i = objs.indexOf value)
					i = cyclic value

				objIds.push i

			# cycle proto
			if optsProtos and proto = obj.__proto__
				unless ~(i = objs.indexOf proto)
					i = cyclic proto
				objIds.push i

			len - 1

		# parse object
		parse = (obj, index) ->

			r = if isArray obj then [] else {}
			objIds = ids[index]

			obji = 0
			for key, value of obj when obj.hasOwnProperty key

				if value and typeof value is 'object'
					unless objReferences
						objReferences = []

					value = objIds[obji++]
					objReferences.push key

				# get property description
				if optsProps
					propValue = value
					value = getObjOwnPropDesc obj, key
					value.value = propValue

				r[key] = value

			# save reference to proto
			if optsProtos and obj.__proto__
				protos[index] = objIds[obji++]

			# save ctor if needed
			if optsCtors and not r.hasOwnProperty('constructor')
				ctor = obj.constructor

				if ctor isnt Array and ctor isnt Object
					ctors[index] = ctor

			# save object references
			if objReferences then references[index] = objReferences

			r

		# find cycles
		cyclic obj

		# parse all found objects
		for value, i in objs
			objs[i] = parse value, i

		# return
		opts: opts
		objects: objs
		references: references
		protos: protos
		constructors: ctors

### assemble()

Backward `simplify()` operation.

	exports.assemble = do ->

		if Object.__proto__
			setObjProto = (obj, proto) ->
				obj.__proto__ = proto
				obj
		else
			setObjProto = (obj, proto) ->
				proto = createObject proto
				merge proto, obj
				proto

		ctorPropConfig =
			value: null
			enumerable: false

		(obj) ->

			assert exports.isObject obj

			{opts, objects, references, protos, constructors} = obj

			optsProps = opts.properties
			optsProtos = opts.protos
			optsCtors = opts.constructors

			# set references
			for objI, refs of references
				obj = objects[objI]

				for ref in refs
					if optsProps
						obj[ref].value = objects[obj[ref].value]
					else
						obj[ref] = objects[obj[ref]]

			# set properties
			if optsProps
				for obj in objects
					for key, value of obj
						defObjProp obj, key, value

			# set protos
			for objI, refI of protos
				objects[objI] = setObjProto objects[objI], objects[refI]

			# set ctors
			if optsCtors
				for objI, func of constructors
					ctorPropConfig.value = func
					defObjProp objects[objI], 'constructor', ctorPropConfig

			objects[0]

### isEqual()

Compare two objects deeply.

	isEqual = exports.isEqual = do ->

		defaultComparison = (a, b) -> a is b

		forArrays = (a, b, compareFunc) ->

			# prototypes are the same
			if getPrototypeOf(a) isnt getPrototypeOf(b)
				return false

			# length is the same
			if a.length isnt b.length
				return false

			# values are the same
			for aValue in a
				isTrue = false

				for bValue in b
					if bValue and typeof bValue is 'object'
						if isEqual aValue, bValue, compareFunc
							isTrue = true
						continue

					if compareFunc aValue, bValue
						isTrue = true
						break

				unless isTrue
					return false

			for bValue in b
				isTrue = false

				for aValue in a
					if aValue and typeof aValue is 'object'
						if isEqual bValue, aValue, compareFunc
							isTrue = true
						continue

					if compareFunc bValue, aValue
						isTrue = true
						break

				unless isTrue
					return false

			true

		forObjects = (a, b, compareFunc) ->

			# prototypes are the same
			if getPrototypeOf(a) isnt getPrototypeOf(b)
				return false

			# whether keys are the same
			for key, value of a when a.hasOwnProperty key
				unless b.hasOwnProperty key
					return false

			for key, value of b when b.hasOwnProperty key
				unless a.hasOwnProperty key
					return false

			# whether values are equal
			for key, value of a when a.hasOwnProperty key
				if value and typeof value is 'object'
					unless isEqual value, b[key], compareFunc
						return false
					continue

				unless compareFunc value, b[key]
					return false

			true

		(a, b, compareFunc=defaultComparison) ->

			if isArray(a) and isArray(b)
				return forArrays a, b, compareFunc

			if a and typeof a is 'object' and b and typeof b is 'object'
				return forObjects a, b, compareFunc

			return compareFunc a, b

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

Utils for functions
-------------------

### tryFunc()

Call function and omit error raising.
Made as workaroud for V8 deoptimization.

	exports.tryFunc = (func, context, onfail) ->

		assert typeof func is 'function'

		shift.call arguments
		shift.call arguments
		onfail = pop.call arguments

		try
			func.apply context, arguments
		catch err
			if typeof onfail is 'function' then onfail(err) else onfail

### catchError()

Catch raised error and return it.
Made as workaroud for V8 deoptimization.

	exports.catchError = (func, context) ->

		assert typeof func is 'function'

		shift.call arguments
		shift.call arguments

		try
			func.apply context, arguments
			null
		catch err
			err

Utils for errors
----------------

### errorToObject()

Parse native `Error` instance into *pure* object.

	exports.errorToObject = (error) ->

		unless error instanceof Error
			throw new TypeError

		name: error.name
		message: error.message