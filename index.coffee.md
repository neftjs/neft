Utils
=====

**Author:** *kildyt@gmail.com*

**License:** *MIT*

	'use strict'

	{assert} = console
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

	[expect] = ['expect'].map require

Include sub-modules
-------------------

	exports.async = require './async.coffee.md'

Environment information
-----------------------

	exports.isNode = exports.isClient = exports.isBrowser = exports.isQML = false

	switch true

		when global? and global+'' is '[object global]'
			exports.isNode = true

		when window?.document?
			exports.isClient = exports.isBrowser = true

		when Qt?.include
			exports.isClient = exports.isQML = true

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

			return cloneFunction(arg) if typeof arg is 'function'
			return cloneArray(arg) if isArray arg
			return cloneObject(arg) if arg and typeof arg is 'object'
			arg

### cloneDeep()

Clone passed `arg` deeply.
Optional `opts` parameter can specify which types shouldn't be cloned.
Functions are not clone by default (pass `{function: true}` to reverse this proccess).

	exports.cloneDeep = do (optsDef={function: false}) -> (arg, opts=optsDef) ->

		opts.function ?= false

		result = exports.clone arg

		if result and typeof result is 'object'
			for key, value of result when hasOwnProp.call result, key
				if opts?[typeof value] isnt false
					result[key] = exports.cloneDeep value

		result

### merge()

Merge second object into the first one.
Existed properties will be overriden.

	merge = exports.merge = (source, obj) ->

		expect(source).not().toBe.primitive()
		expect(obj).not().toBe.primitive()
		expect(source).not().toBe obj

		for key, value of obj when obj.hasOwnProperty(key)
			source[key] = value

		source

### mergeDeep()

Merge second object into the first one deeply.

	mergeDeep = exports.mergeDeep = (source, obj) ->

		expect(source).not().toBe.primitive()
		expect(obj).not().toBe.primitive()
		expect(source).not().toBe obj

		for key, value of obj when hasOwnProp.call obj, key
			sourceValue = source[key]

			if value and typeof value is 'object' and sourceValue and typeof sourceValue is 'object'
				mergeDeep sourceValue, value
				continue

			source[key] = value

		source

### fill()

Works like `merge()` but only on defined properties in the `source`.
Existed properties won't be overriden.

	exports.fill = (source, obj) ->

		expect(source).not().toBe.primitive()
		expect(obj).not().toBe.primitive()
		expect(source).not().toBe obj

		for key, value of obj
			if key of source and not hasOwnProp.call(source, key)
				source[key] = value

		source

### remove()

Remove passed key/element from the object/array.

	exports.remove = (obj, elem) ->

		expect(obj).not().toBe.primitive()

		if isArray obj
			index = obj.indexOf elem
			obj.splice index, 1 if ~index
			return

		delete obj[elem]

### defProp()

Short version of `Object.defineProperty`.

Parameters:
  1. object where property will be defined,
  2. property name
  3. string describing property config:
     "w" - writable, "e" - enumarable and "c" - configurable in any order
  4. value or getter
  5. setter

To avoid `setter`, when `getter` is specified, pass `null`.

Example:
```
obj = {}
utils.defProp obj, 'const', 'e', 'constant value'
utils.defProp obj, 'name', 'ec', (-> 2), null
```

	exports.defProp = do ->

		descCfg =
			enumerable: true
			configurable: true

		valueCfg = exports.merge writable: true, value: null, descCfg

		accessorsCfg = exports.merge get: undefined, set: undefined, descCfg

		(obj, prop, desc, getter, setter) ->

			expect(obj).not().toBe.primitive()
			expect(prop).toBe.string()
			expect(desc).toBe.string()

			# configure value
			if setter is undefined
				cfg = valueCfg
				cfg.value = getter
				cfg.writable = exports.has desc, 'w'

			# configure accessors
			else
				cfg = accessorsCfg
				cfg.get = getter or undefined
				cfg.set = setter or undefined

			# set common config
			cfg.enumerable = exports.has desc, 'e'
			cfg.configurable = exports.has desc, 'c'

			# set property
			defObjProp obj, prop, cfg

			obj

### getPropDesc()

Works like `Object.getOwnPropertyDescriptor` but lookup all prototypes, not only own properties.

	exports.getPropDesc = (obj, prop) ->

		expect(obj).not().toBe.primitive()
		expect(prop).toBe.string()

		while obj and not desc
			desc = getObjOwnPropDesc obj, prop
			return desc if desc

			obj = getPrototypeOf.call obj

### lookupGetter()

Object::__lookupGetter__ polyfill.

	exports.lookupGetter = do ->

		# use native function if possible
		if Object::__lookupGetter__
			return Function.call.bind Object::__lookupGetter__

		# use polyfill
		(obj, prop) ->

			desc = exports.getPropDesc obj, prop
			desc?.get

### lookupSetter()

Object::__lookupSetter__ polyfill.

	exports.lookupSetter = do ->

		# use native function if possible
		if Object::__lookupSetter__
			return Function.call.bind Object::__lookupSetter__

		# use polyfill
		(obj, prop) ->

			desc = exports.getPropDesc obj, prop
			desc?.set

Utils for objects and arrays
----------------------------

### isArguments()

Check if specified object is an arguments array.

	exports.isArguments = (obj) ->

		expect(obj).toBe.object()

		toString.call(obj) is '[object Arguments]'

### isObject()

Check if arg is clear object (without any other prototypes).

	exports.isObject = (obj) ->

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

		expect(obj).toBe.object()

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
			if typeof obj isnt 'object' and typeof obj isnt 'function'

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

		expect(arg).toBe.object()

		if isArray arg
			return !arg.length

		return false for key of arg
		true

### last()

Get last element from the Object or Array

	exports.last = (arg) ->

		expect(arg).toBe.object()

		# Array
		if isArray arg
			return arg[arg.length - 1]

		# Object
		keys = objKeys arg
		arg[keys[keys.length - 1]]

### clear()

Remove all elements from the array, or all properties from the object.

	exports.clear = (obj) ->

		expect(obj).toBe.object()

		# Array
		if isArray obj
			obj.pop() for _ in [0...obj.length] by 1
			return obj

		# Object
		delete obj[key] for key of obj when obj.hasOwnProperty key
		obj

### setPrototypeOf

Polyfill for ES6 `Object.setPrototypeOf()`.

	exports.setPrototypeOf = setPrototypeOf = do ->

		if Object.setPrototypeOf?
			return Object.setPrototypeOf

		if Object.__proto__
			return (obj, proto) ->

				expect(obj).toBe.object()

				obj.__proto__ = proto
				obj

		return (obj, proto) ->

			expect(obj).toBe.object()

			proto = createObject proto
			merge proto, obj
			proto

### getOwnProperties

Returns new array or object only with own properties.

	exports.getOwnProperties = (obj) ->

		expect(obj).toBe.object()

		result = if isArray obj then [] else {}
		merge result, obj
		result

### simplify()

Convert passed object into the most simplified format.
Such object can be easily stringified.
Use `assemble()` method to restore into initial structure.

Second optional parameter is an config object.
Possible options to define (all are `false` by default):
  - `properties` - save properties descriptions (getters, config etc.),
  - `protos` - save proto as object,
  - `constructors` - include constructors functions.

If `protos` is `false` and `constructors` is `true` objects will be taken as instances (example 2).

Examples
  1. ```
     obj = {}
     obj.self = obj
     JSON.stringify utils.simplify obj
     ```
  2. ```
     class Sample
     	constructor: -> @fromInst = 1
     	fromProto: 1
     sample = new Sample
     parts = utils.simplify sample, constructors: true
     clone = utils.assemble json
     # it's true because `protos` option is `false` and `constructors` is true
     # won't work for json, because functions are not stringified - do it on your own
     assert(clone instanceof Sample)
     ```

 * * *

	exports.simplify = do ->

		nativeProtos = [Array::, Object::]
		nativeCtors = [Array, Object]

		(obj, opts={}) ->

			expect(obj).toBe.object()
			expect(opts).toBe.simpleObject()

			optsProps = opts.properties ?= false
			optsProtos = opts.protos ?= false
			optsCtors = opts.constructors ?= false
			optsInsts = opts.instances = not optsProtos and optsCtors

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

					# don't check getters values
					if optsProps and exports.lookupGetter obj, key
						objIds.push null
						continue

					# check whether obj already exists
					unless ~(i = objs.indexOf value)
						i = cyclic value

					objIds.push i

				# cycle proto
				if optsProtos and proto = getPrototypeOf obj

					# don't save protos for native ones (Array, Object, etc..)
					if ~(nativeProtos.indexOf proto)
						i = null

					# find recursively if it's for first time
					else unless ~(i = objs.indexOf proto)
						i = cyclic proto

					objIds.push i

				len - 1

			# parse object
			parse = (obj, index) ->

				r = if isArray obj then [] else {}
				objIds = ids[index]

				# Create `references` for each object with keys which are a references to others
				# Value of each property will be changed to referenced object id
				obji = 0
				objReferences = null
				for key, value of obj when obj.hasOwnProperty key

					r[key] = value

					isReference = false

					# save as reference
					if value and typeof value is 'object'
						objReferences ?= []

						objId = value = objIds[obji++]

						# with `optsProps` id can be a null when value is an object
						if value isnt null
							isReference = true
							objReferences.push key

					# save as property description
					if optsProps
						desc = getObjOwnPropDesc obj, key
						desc.value = value if isReference
						value = desc

					# override prop value as referenced object id
					r[key] = value

				# save reference to proto
				if optsProtos and getPrototypeOf obj
					protoObjId = objIds[obji++]
					if protoObjId isnt null
						protos[index] = protoObjId

				# save ctor if needed
				if optsCtors and ctor = obj.constructor

					# save for instance or for prototype depend on the flag
					if optsInsts or obj.hasOwnProperty('constructor')

						# omits native constructors (Array, Object etc.)
						unless ~(nativeCtors.indexOf ctor)
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

		ctorPropConfig = value: null

		(obj) ->

			expect(obj).toBe.simpleObject()

			{opts, objects, references, protos, constructors} = obj

			optsProps = opts.properties
			optsProtos = opts.protos
			optsCtors = opts.constructors
			optsInsts = opts.instances

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
					for key, value of obj when obj.hasOwnProperty key # TODO rethink db bug
						defObjProp obj, key, value

			# set protos
			for objI, refI of protos
				objects[objI] = setPrototypeOf objects[objI], objects[refI]

			# set objects as instances
			if optsInsts
				for objI, func of constructors
					setPrototypeOf objects[objI], func::

			# .. or set ctors as properties
			else if optsCtors
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

			expect().defined(compareFunc).toBe.function()

			if isArray(a) and isArray(b)
				return forArrays a, b, compareFunc

			if a and typeof a is 'object' and b and typeof b is 'object'
				return forObjects a, b, compareFunc

			return compareFunc a, b

Utils for arrays and strings
----------------------------

### has()

Check whether array or string contains passed value.

	exports.has = (any, elem) ->

		expect(any?.indexOf).toBe.function()

		!!~any.indexOf elem

Utils for arrays
----------------

### arrayToObject()

Save parsed array into `target` (new object by default) and return it.
Use optionally `keyGen` and `valueGen` to specify custom keys and values
(by default key is current index, and value refers to array element).
`keyGen` and `valueGen` are called with current element, current index and array.

	exports.arrayToObject = (arr, keyGen, valueGen, target={}) ->

		expect(arr).toBe.array()
		expect().defined(keyGen).toBe.function()
		expect().defined(valueGen).toBe.function()
		expect(target).toBe.object()

		for elem, i in arr

			key = if keyGen then keyGen(elem, i, arr) else i
			value = if valueGen then valueGen(elem, i, arr) else elem

			target[key] = value

		target

Utils for strings
-----------------

### capitalize()

	exports.capitalize = (str) ->

		expect(str).toBe.string()

		return '' unless str.length
		str[0].toUpperCase() + str.substring(1)

### isStringArray()

Check if string references into array (according to notation in `get` method).

	isStringArray = exports.isStringArray = (arg) ->

		expect(arg).toBe.string()

		arg.slice(-2) is '[]'

### addSlashes()

New string with added backslashes before `'` and `"` is returned.

	exports.addSlashes = do ->

		SLASHES_RE = ///'|"///g
		NEW_SUB_STR = '\\$&'

		(str) ->

			expect(str).toBe.string()

			unless str then return str

			str.replace SLASHES_RE, NEW_SUB_STR

### uid()

Generate unique hash. Length of returned string can be specified (default 8).

	exports.uid = (n=8) ->

		expect(n).toBe.integer()

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

	exports.tryFunc = (func, context, args, onfail) ->

		expect(func).toBe.function()
		expect().defined(args).toBe.array()

		try
			func.apply context, args
		catch err
			if typeof onfail is 'function' then onfail(err) else onfail

### catchError()

Catch raised error and return it.
Made as workaroud for V8 deoptimization.

	exports.catchError = (func, context, args) ->

		expect(func).toBe.function()
		expect().defined(args).toBe.array()

		try
			func.apply context, args
			null
		catch err
			err

Utils for errors
----------------

### errorToObject()

Parse native `Error` instance into *pure* object.

	exports.errorToObject = (error) ->

		expect(error).toBe.any Error

		name: error.name
		message: error.message
