Utils
=====

	'use strict'

	{assert} = console
	{toString} = Object::
	funcToString = Function::toString
	{isArray} = Array
	{shift, pop} = Array::
	createObject = Object.create
	{getPrototypeOf, getOwnPropertyNames} = Object
	objKeys = Object.keys
	hasOwnProp = Object.hasOwnProperty
	getObjOwnPropDesc = Object.getOwnPropertyDescriptor
	defObjProp = Object.defineProperty
	{random} = Math

	[expect] = ['expect'].map require

	###
	Link subfiles
	###
	require('./namespace') exports
	require('./stringifying') exports
	require('./async') exports

*Boolean* utils.isNode
----------------------

Determine whether application is run in *node.js*.

*Boolean* utils.isClient
------------------------

`utils.isNode` inverse.

*Boolean* utils.isBrowser
-------------------------

Determine whether application is run in the browser environment.

*Boolean* utils.isQml
---------------------

Determine whether application is a part of the QML program.

	exports.isNode = exports.isClient = exports.isBrowser = exports.isQml = false

	switch true

		when global? and Object::toString.call(global) is '[object global]'
			exports.isNode = true

		when window?.document?
			exports.isClient = exports.isBrowser = true

		when Qt?.include?
			exports.isClient = exports.isQml = true

*Boolean* utils.isPlainObject(*Any* param)
-------------------------------------

Checks whether given *param* is an object.

### Example
```
console.log utils.isPlainObject({})
# true

console.log utils.isPlainObject([])
# true

console.log utils.isPlainObject('')
# false

console.log utils.isPlainObject(->)
# false
```

	isObject = exports.isObject = (param) ->
		param isnt null and typeof param is 'object'

*Boolean* utils.isPlainObject(*Any* param)
------------------------------------------

Checks whether given *param* is a plain object, that is:
 - object with no prototype,
 - object with standard `Object` prototype.

### Example
```
console.log utils.isPlainObject({})
# true

console.log utils.isPlainObject(Object.create(null))
# true

console.log utils.isPlainObject([])
# false

console.log utils.isPlainObject(->)
# false

class User
console.log utils.isPlainObject(new User)
# false

console.log utils.isPlainObject(Object.create({propertyInProto: 1}))
# false
```

	exports.isPlainObject = (param) ->
		unless isObject param
			return false

		proto = getPrototypeOf param

		# comes from Object.create
		unless proto
			return true

		# one-proto object
		if (proto is Object::) and not getPrototypeOf(proto)
			return true

		false

*Boolean* utils.isArguments(*Any* param)
----------------------------------------

Returns true if given *param* is an arguments object.

### Example
```
console.log utils.isArguments(do -> arguments)
# true

console.log utils.isArguments {}
# false
```

	exports.isArguments = (param) ->
		toString.call(param) is '[object Arguments]'

*NotPrimitive* utils.merge(*NotPrimitive* source, *NotPrimitive* object)
------------------------------------------------------------------------

Override given *source* object by the given *object* own properties.

Given *source* is returned.

### Example
```
config = a: 1, b: 2
utils.merge config, {b: 99, d: 100}
console.log config
# {a: 1, b: 99, d: 100}
```

	merge = exports.merge = (source, obj) ->
		expect(source).not().toBe.primitive()
		expect(obj).not().toBe.primitive()
		expect(source).not().toBe obj

		for key, value of obj when obj.hasOwnProperty(key)
			source[key] = value

		source

*NotPrimitive* utils.mergeDeep(*NotPrimitive* source, *NotPrimitive* object)
----------------------------------------------------------------------------

Override given *source* object and all it's objects by the given *object* own properties.

Only objects are merge deeply (no arrays and functions).

Given *source* is returned.

### Example
```
user =
	name: 'test'
	carsByName:
		tiny: 'Ferrharhi'
		monkey: 'BMM'

utils.mergeDeep user,
	name: 'Johny'
	carsByName:
		nextCar: 'Fita'

console.log user
# {name: 'Johny', carsByName: {tiny: 'Ferrharhi', monkey: 'BMM', nextCar: 'Fita'}}
```

	mergeDeep = exports.mergeDeep = (source, obj) ->

		expect(source).not().toBe.primitive()
		expect(obj).not().toBe.primitive()
		expect(source).not().toBe obj

		for key, value of obj when hasOwnProp.call obj, key
			sourceValue = source[key]

			if value and typeof value is 'object' and not isArray(value) and sourceValue and typeof sourceValue is 'object' and not isArray(sourceValue)
				mergeDeep sourceValue, value
				continue

			source[key] = value

		source

*NotPrimitive* utils.fill(*NotPrimitive* source, *NotPrimitive* object)
-----------------------------------------------------------------------

Translate *object* own properties into the *source* if they are defined in the
*source* prototype and are not defined in the *source* as own properties.

### Example
```
class User
	name: ''

user = new User
utils.fill user, {name: 'Johny', age: 40}
console.log user
# {name: 'Johny'}
```

	exports.fill = (source, obj) ->
		expect(source).not().toBe.primitive()
		expect(obj).not().toBe.primitive()
		expect(source).not().toBe obj

		for key, value of obj when hasOwnProp.call(obj, key)
			if key of source and not hasOwnProp.call(source, key)
				source[key] = value

		source

utils.remove(*NotPrimitive* object, *Any* element)
--------------------------------------------------

Remove array element or object property.

### Example
```
array = ['a', 'b', 'c']
utils.remove array, 'b'
console.log array
# ['a', 'c']

object = {a: 1, b: 2}
utils.remove object, 'a'
console.log object
# {b: 2}
```

	exports.remove = (obj, elem) ->
		expect(obj).not().toBe.primitive()

		if isArray obj
			index = obj.indexOf elem
			if index isnt -1
				if index is 0
					obj.shift()
				else if index is obj.length-1
					obj.pop()
				else
					obj.splice index, 1
		else
			delete obj[elem]

		null

[*Object*] getPropertyDescriptor(*NotPrimitive* object, *String* property)
--------------------------------------------------------------------------

Returns descriptor of the *property* defined in the given *object*.

All *object* prototypes are checked.

### Example
```
class User
	age: 0
	utils.defineProperty User::, 'isAdult', utils.CONFIGURABLE, ->
		@age >= 18
	, null

user = new User
console.log utils.getPropertyDescriptor(user, 'isAdult')
# {enumerable: false, configurable: true, get: ..., set: undefined}
```

	exports.getPropertyDescriptor = (obj, prop) ->
		expect(obj).not().toBe.primitive()
		expect(prop).toBe.string()

		while obj and not desc
			desc = getObjOwnPropDesc obj, prop

			obj = getPrototypeOf obj

		desc

[*Function*] lookupGetter(*NotPrimitive* object, *String* property)
-------------------------------------------------------------------

Returns the function bound as a getter to the given *property*.

### Example
```
object = {loaded: 2, length: 5}
utils.defineProperty object, 'progress', null, ->
	@loaded / @length
, null
console.log utils.lookupGetter(object, 'progress')
# -> @loaded / @length
```

	exports.lookupGetter = do ->

		# use native function if possible
		if Object::__lookupGetter__
			return Function.call.bind Object::__lookupGetter__

		# use polyfill
		(obj, prop) ->

			desc = exports.getPropertyDescriptor obj, prop
			desc?.get

[*Function*] lookupSetter(*NotPrimitive* object, *String* property)
-------------------------------------------------------------------

Returns the function bound as a setter to the given *property*.

	exports.lookupSetter = do ->

		# use native function if possible
		if Object::__lookupSetter__
			return Function.call.bind Object::__lookupSetter__

		# use polyfill
		(obj, prop) ->

			desc = exports.getPropertyDescriptor obj, prop
			desc?.set

*NotPrimitive* utils.defineProperty(*NotPrimitive* object, *String* property, *Integer* descriptors, [*Any* value, *Function* setter])
--------------------------------------------------------------------------------------------------------------------------------------

Defines *property* in the given *object*.

*descriptors* is a bitmask contains `utils.WRITABLE`, `utils.ENUMERABLE` and
`utils.CONFIGURABLE`.

*value* becomes a getter if given *setter* is not `undefined`.

### Example
```
object = {}

desc = utils.ENUMERABLE | utils.WRITABLE | utils.CONFIGURABLE
utils.defineProperty object, 'name', desc, 'Emmy'
console.log object.name
# Emmy

utils.defineProperty object, 'const', utils.ENUMERABLE | utils.CONFIGURABLE, 'constantValue'
console.log object.const
# constantValue

utils.defineProperty object, 'length', utils.ENUMERABLE | utils.CONFIGURABLE, (-> 2), null
console.log object.length
# 2
```

	defObjProp exports, 'WRITABLE', value: 1<<0
	defObjProp exports, 'ENUMERABLE', value: 1<<1
	defObjProp exports, 'CONFIGURABLE', value: 1<<2

	exports.defineProperty = do ->

		{WRITABLE, ENUMERABLE, CONFIGURABLE} = exports

		descCfg = enumerable: true, configurable: true
		valueCfg = exports.merge writable: true, value: null, descCfg
		accessorsCfg = exports.merge get: undefined, set: undefined, descCfg

		# thanks to http://stackoverflow.com/a/23522755/2021829
		isSafari = if navigator?
				///^((?!chrome).)*safari///i.test(navigator.userAgent)
			else
				false

		(obj, prop, desc, getter, setter) ->
			expect(obj).not().toBe.primitive()
			expect(prop).toBe.string()
			expect().defined(desc).toBe.integer().greaterThan(0)

			# configure value
			if setter is undefined
				cfg = valueCfg
				cfg.value = getter
				cfg.writable = desc & WRITABLE

			# configure accessors
			else
				# HACK: safari bug
				if isSafari and getter
					_getter = getter
					getter = ->
						if @hasOwnProperty(prop) and @ isnt obj
							@[prop]
						else
							_getter.call @

				cfg = accessorsCfg
				cfg.get = getter or undefined
				cfg.set = setter or undefined

			# set common config
			cfg.enumerable = desc & ENUMERABLE
			cfg.configurable = desc & CONFIGURABLE

			# set property
			defObjProp obj, prop, cfg

			obj

*Any* utils.clone(*Any* param)
------------------------------

Clones array elements or object own properties.

Functions are not cloned!

### Example
```
console.log utils.clone 'ABC'
# ABC

console.log utils.clone [1, 2]
# [1, 2]

console.log utils.clone {a: 1}
# {a: 1}
```

	clone = exports.clone = (param) ->

		if isArray param
			return param.slice()

		if isObject param
			result = createObject getPrototypeOf param

			for key in objKeys param
				result[key] = param[key]

			return result

		param

*Any* cloneDeep(*Any* param)
----------------------------

Clone array elements and object properties deeply.

### Example
```
obj2 = {ba: 1}
obj = {a: 1, b: obj2}
clonedObj = utils.cloneDeep obj

console.log clonedObj
# {a: 1, b: {ba: 1}}

console.log clonedObj.b is obj.b
# false
```

	cloneDeep = exports.cloneDeep = (param) ->

		result = clone param

		if isObject result
			for key in objKeys result
				result[key] = cloneDeep result[key]

		result

*Boolean* isEmpty(*NotPrimitive* object)
----------------------------------------

Checks whether given *object* is empty, that is:
 - for arrays, if no elements exists (*length* is 0),
 - for objects, if no own properties are defined.

* * *

	exports.isEmpty = (object) ->
		expect(object).not().toBe.primitive()

		if isArray object
			return !object.length
		else
			return !getOwnPropertyNames(object).length

*Any* utils.last(*NotPrimitive* array)
--------------------------------------

Returns given *array* last element.

### Example
```
console.log utils.last(['a', 'b'])
# b

console.log utils.last([])
# undefined
```

	exports.last = (arg) ->
		expect(arg).not().toBe.primitive()

		arg[arg.length - 1]

*NotPrimitive* utils.clear(*NotPrimitive* object)
-------------------------------------------------

Removes all elements from an array, or all properties from an object.

### Example
```
console.log utils.clear(['a', 'b'])
# []

console.log utils.clear({age: 37})
# {}
```

	exports.clear = (obj) ->
		expect(obj).not().toBe.primitive()

		if isArray obj
			obj.pop() for _ in [0...obj.length] by 1
		else
			delete obj[key] for key in objKeys obj

		obj

*Object* utils.setPrototypeOf(*NotPrimitive* object, *NotPrimitive|Null* prototype)
-----------------------------------------------------------------------------------

Changes given *object* prototype into *prototype*.

This method on some environments returns new object!

### Example
```
obj = a: 1
prototype = b: 100

newObj = utils.setPrototypeOf(obj, prototype)

console.log Object.getPrototypeOf(newObj) is prototype
# true

console.log newObj.a
# 1

console.log newObj.b
# 100
```

	setPrototypeOf = exports.setPrototypeOf = do ->

		# ES6 `Object.setPrototypeOf()`
		if typeof Object.setPrototypeOf is 'function'
			return Object.setPrototypeOf

		# writable __proto__
		tmp = {}
		tmp.__proto__ = a: 1
		if tmp.a is 1
			return (obj, proto) ->
				expect(obj).not().toBe.primitive()
				if proto isnt null
					expect(proto).not().toBe.primitive()

				obj.__proto__ = proto
				obj

		# object merging
		return (obj, proto) ->
			expect(obj).not().toBe.primitive()
			if proto isnt null
				expect(proto).not().toBe.primitive()

			newObj = createObject proto
			merge newObj, obj
			newObj

*Boolean* utils.has(*Array* array, *Any* value)
-----------------------------------------------

Returns true if given *array* contains *value*.

### Example
```
console.log utils.has(['a']), 'a'
# true

console.log utils.has(['a']), 'b'
# false
```

	has = exports.has = (any, elem) ->
		expect(any?.indexOf).toBe.function()

		!!~any.indexOf elem

*Boolean* utils.hasValue(*Object* object, *Any* value)
------------------------------------------------------

Returns true if given *object* in some own enumerable property stores given *value*.

### Example
```
object =
	city: 'New York'

console.log utils.hasValue(object, 'New York')
# true
```

	exports.hasValue = (obj, val) ->
		expect(obj).toBe.object()

		if isArray obj
			return has obj, val

		for key, value of obj when hasOwnProp.call(obj, key)
			if value is val
				return true

		false

*Array* utils.objectToArray(*Object* object, [*Function* valueGen, *Array* target *= []*])
------------------------------------------------------------------------------------------

Translates given *object* into an array.

Array elements are determined by the *valueGen* function.
*valueGen* function is called with property name, property value and given *object*.

Array elements are properties values by default.

Elements are set into the *target* array (new array by default).

### Example
```
object =
	type: 'dog'
	name: 'Bandit'

console.log utils.objectToArray(object)
# ['dog', 'Bandit']

console.log utils.objectToArray(object, (key, val) ->
	"#{key}_#{val}")
# ['type_dog', 'name_Bandit']
```

	exports.objectToArray = (obj, valueGen, target) ->
		keys = objKeys obj
		target ?= keys

		expect(obj).toBe.object()
		expect().defined(valueGen).toBe.function()
		expect(target).toBe.array()

		for key, i in keys
			value = if valueGen then valueGen(key, obj[key], obj) else obj[key]
			target[i] = value

		target

*Object* utils.arrayToObject(*Array* array, [*Function* keyGen, *Function* valueGen*, *Object* target *= {}*])
--------------------------------------------------------------------------------------------------------------

Translates given *array* into object with keys defined by the *keyGen* and values
defined by the *valueGen*.

Keys are indexes by default.
Values are elements by default.

*keyGen* and *valueGen* functions are called with element index,
element value and given *array*.

Properties are set into the *target* object (new object by default).

### Example
```
console.log utils.arrayToObject(['a', 'b'])
# {0: 'a', 1: 'b'}

console.log utils.arrayToObject(['a'], (i, elem) ->
	"value_#{elem}")
# {"value_a": "a"}

console.log utils.arrayToObject(['a'], ((i, elem) -> elem), ((i, elem) -> i))
# {"a": 0}
```

	exports.arrayToObject = (arr, keyGen, valueGen, target={}) ->
		expect(arr).toBe.array()
		expect().defined(keyGen).toBe.function()
		expect().defined(valueGen).toBe.function()
		expect(target).toBe.object()

		for elem, i in arr
			key = if keyGen then keyGen(i, elem, arr) else i
			value = if valueGen then valueGen(i, elem, arr) else elem

			target[key] = value

		target

*String* utils.capitalize(*String* string)
------------------------------------------

Capitalize given *string* first character.

### Example
```
console.log utils.capitalize('name')
# Name
```

	exports.capitalize = (str) ->
		expect(str).toBe.string()

		unless str.length
			return ''

		str[0].toUpperCase() + str.slice(1)

*String* utils.addSlashes(*String* string)
------------------------------------------

Adds backslashes before each `'` and `"` characters.

### Example
```
console.log utils.addSlashes('a"b')
# a\"b
```

	exports.addSlashes = do ->

		SLASHES_RE = ///'|"///g
		NEW_SUB_STR = '\\$&'

		(str) ->
			expect(str).toBe.string()

			unless str.length
				return str

			str.replace SLASHES_RE, NEW_SUB_STR

*String* utils.uid([*Integer* length *= 8*])
--------------------------------------------

Generates pseudo-unique hash with given *length*.

	exports.uid = (n=8) ->
		expect(n).toBe.integer()
		expect(n).toBe.greaterThan 0

		str = ''

		loop
			str += random().toString(16).slice 2
			if str.length >= n then break

		if str.length is n
			str
		else
			str.slice 0, n

*Any* utils.tryFunctiontion(*Function* function, [*Any* context, *Array* arguments, *Any* onfail])
----------------------------------------------------------------------------------------------

Calls given *function* with *context* and *arguments*.

If *function* throws an errpr, *onfail* is returned.

If *onfail* is a function, it will be called with catched error.

### Example
```
func = (size) ->
	if size is 0
		throw "Wrong size!"

console.log utils.tryFunctiontion(func, null, [0])
# undefined

console.log utils.tryFunctiontion(func, null, [0], 'ERROR!')
# ERROR!

console.log utils.tryFunctiontion(func, null, [100], 'ERROR!')
# undefined
```

	exports.tryFunction = (func, context, args, onfail) ->
		expect(func).toBe.function()
		expect().defined(args).toBe.object()

		try
			func.apply context, args
		catch err
			if typeof onfail is 'function' then onfail(err) else onfail

*Any* utils.catchError(*Function* function, [*Any* context, *Array* arguments])
-----------------------------------------------------------------------------

Calls given *function* with *context* and *arguments* and returns catched error.

### Example
```
func = (size) ->
	if size is 0
		throw "Wrong size!"

console.log utils.catchError(func, null, [0])
# "Wrong size!"

console.log utils.catchError(func, null, [100])
# null
```

	exports.catchError = (func, context, args) ->
		expect(func).toBe.function()
		expect().defined(args).toBe.object()

		try
			func.apply context, args
			null
		catch err
			err

*Object* utils.errorToObject(*Error* error)
-------------------------------------------

Takes an *Error* instance and returns plain object with the *error* name and message.

### Example
```
error = new ReferenceError 'error message!'
console.log utils.errorToObject(error)
# {name: 'ReferenceError', message: 'error message!'}
```

	exports.errorToObject = (error) ->
		expect(error).toBe.any Error

		name: error.name
		message: error.message

*Object* utils.getOwnProperties(*Object* object)
------------------------------------------------

Returns new array or object with own properties.

	exports.getOwnProperties = (obj) ->
		expect(obj).toBe.object()

		result = if isArray obj then [] else {}
		merge result, obj
		result

*Boolean* isEqual(*Object* object1, *Object* object2, [*Function* compareFunction])
-----------------------------------------------------------------------------------

Compares two objects or arrays deeply.

Optional *compareFunction* defines whether two values are equal.

### Example
```
console.log utils.isEqual([0, 1], [1, 0])
# true

console.log utils.isEqual({a: 1}, {a: 1})
# true

console.log utils.isEqual({a: {aa: 1}}, {a: {aa: 1}})
# true

console.log utils.isEqual({a: {aa: 1}}, {a: {aa: 1, ab: 2}})
# false
```

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
			expect(compareFunc).toBe.function()

			if isArray(a) and isArray(b)
				forArrays a, b, compareFunc
			else if isObject(a) and isObject(b)
				forObjects a, b, compareFunc
			else
				return compareFunc a, b