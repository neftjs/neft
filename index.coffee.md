Utilities @library
=========

**JavaScript standard library so exists**

This module helps to write applications faster and better.

It collects most commonly used helpers.

Access it with:
```
var utils = require('utils');
```

	'use strict'

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

	###
	Link subfiles
	###
	require('./namespace') exports
	require('./stringifying') exports
	require('./async') exports

*Boolean* utils.isNode
----------------------

Determines whether application is run in the **node.js** environment.

*Boolean* utils.isServer
------------------------

`utils.isNode` link.

*Boolean* utils.isClient
------------------------

`utils.isNode` inverse.

*Boolean* utils.isBrowser
-------------------------

Determines whether application is run in the browser environment.

*Boolean* utils.isQml
---------------------

Determines whether application is a part of the *QML* program.

	exports.isNode = exports.isServer = exports.isClient = exports.isBrowser = exports.isQml = false

	switch true

		when window?.document?
			exports.isClient = exports.isBrowser = true

		when Qt?.include?
			exports.isClient = exports.isQml = true

		when process? and Object.prototype.toString.call(process) is '[object process]'
			exports.isNode = exports.isServer = true

*Boolean* utils.is(*Any* value1, *Any* value2)
----------------------------------------------

This function determines whether two values are exactly equal.

It's the *Object.is()* function polyfill (introduced in ECMAScript 6).

In opposite to the *===* operator, this function treats two *NaN*s as equal, and
*-0* and *+0* as not equal.

```
console.log(utils.is('a', 'a'));
// true

console.log(utils.is(NaN, NaN));
// true, but ...
console.log(NaN === NaN);
// false

console.log(utils.is(-0, 0));
// false, but ...
console.log(-0 === 0);
// true
```

	exports.is = (val1, val2) ->
		if val1 is 0 and val2 is 0
			return 1 / val1 is 1 / val2
		else if val1 isnt val1
			return val2 isnt val2
		else
			return val1 is val2

*Boolean* utils.isFloat(*Any* value)
------------------------------------

This function checks whether the given value is a finite number.

```
console.log(utils.isFloat(10));
// true

console.log(utils.isFloat(0.99));
// true

console.log(utils.isFloat(NaN));
// false

console.log(utils.isFloat(Infinity));
// false

console.log(utils.isFloat('10'));
// false
```

	exports.isFloat = (val) ->
		typeof val is 'number' and isFinite(val)

*Boolean* utils.isInteger(*Any* value)
--------------------------------------

This function checks whether the given value is an integer.

```
console.log(utils.isInteger(10));
// true

console.log(utils.isInteger(-2));
// true

console.log(utils.isInteger(1.22));
// false

console.log(utils.isInteger('2'));
// false
```

	exports.isInteger = (val) ->
		typeof val is 'number' and
		isFinite(val) and
		val > -9007199254740992 and
		val < 9007199254740992 and
		Math.floor(val) is val

*Boolean* utils.isPrimitive(*Any* value)
----------------------------------------

This function checks whether the given value is a primitive value.

In ECMAScript 5.1 we have five primitive types:
 - null,
 - string,
 - number,
 - boolean,
 - undefined.

Each of this type is immutable (because it's primitive).

```
console.log(utils.isPrimitive(null));
// true

console.log(utils.isPrimitive('abc'));
// true

console.log(utils.isPrimitive([]));
// false
```

	isPrimitive = exports.isPrimitive = (val) ->
		val is null or
		typeof val is 'string' or
		typeof val is 'number' or
		typeof val is 'boolean' or
		typeof val is 'undefined'

*Boolean* utils.isObject(*Any* value)
-------------------------------------

This function checks whether the given value is an object.

*null* is not treated as an object.

```
console.log(utils.isObject({}));
// true

console.log(utils.isObject([]));
// true

console.log(utils.isObject(null));
// false

console.log(utils.isObject(''));
// false

console.log(utils.isObject(function(){}));
// false
```

	isObject = exports.isObject = (param) ->
		param isnt null and typeof param is 'object'

*Boolean* utils.isPlainObject(*Any* value)
------------------------------------------

This function checks whether the given value is a plain object, that is:
 - object with no prototype,
 - object with standard *Object* prototype.

Arrays and instances of classes are not a plain objects.

```
console.log(utils.isPlainObject({}))
// true

console.log(utils.isPlainObject(Object.create(null));
// true

console.log(utils.isPlainObject([]))
// false

console.log(utils.isPlainObject(function(){}))
// false

function User(){}
console.log(utils.isPlainObject(new User))
// false

console.log(utils.isPlainObject(Object.create({propertyInProto: 1})))
// false
```

	exports.isPlainObject = (param) ->
		unless isObject(param)
			return false

		proto = getPrototypeOf param

		# comes from Object.create
		unless proto
			return true

		# one-proto object
		if (proto is Object::) and not getPrototypeOf(proto)
			return true

		false

*Boolean* utils.isArguments(*Any* value)
----------------------------------------

This function returns true if the given value is an arguments object.

```
(function(){
  console.log(utils.isArguments(arguments))
  // true
})();

console.log(utils.isArguments({}))
// false
```

	exports.isArguments = (param) ->
		toString.call(param) is '[object Arguments]'

*NotPrimitive* utils.merge(*NotPrimitive* source, *NotPrimitive* object)
------------------------------------------------------------------------

This function overrides the given *source* object by the given *object* own properties.

The *source* object is returned.

```
var config = {a: 1, b: 2};
utils.merge(config, {b: 99, d: 100});
console.log(config);
// {a: 1, b: 99, d: 100}
```

	merge = exports.merge = (source, obj) ->
		null
		`//<development>`
		if isPrimitive(source)
			throw new Error "utils.merge source cannot be primitive"
		if isPrimitive(obj)
			throw new Error "utils.merge object cannot be primitive"
		if source is obj
			throw new Error "utils.merge source and object are the same"
		`//</development>`

		for key, value of obj when obj.hasOwnProperty(key)
			source[key] = value

		source

*NotPrimitive* utils.mergeDeep(*NotPrimitive* source, *NotPrimitive* object)
----------------------------------------------------------------------------

This function overrides the given *source* object and all its objects
by the given *object* own properties.

Only objects are merging deeply (no arrays and functions).

The *source* object is returned.

```
var user = {
  name: 'test',
  carsByName: {
    tiny: 'Ferrharhi',
    monkey: 'BMM'
  }
}

utils.mergeDeep(user, {
  name: 'Johny',
  carsByName: {
    nextCar: 'Fita'
  }
});

console.log(user);
// {name: 'Johny', carsByName: {tiny: 'Ferrharhi', monkey: 'BMM', nextCar: 'Fita'}}
```

	mergeDeep = exports.mergeDeep = (source, obj) ->
		null
		`//<development>`
		if isPrimitive(source)
			throw new Error "utils.mergeDeep source cannot be primitive"
		if isPrimitive(obj)
			throw new Error "utils.mergeDeep object cannot be primitive"
		if source is obj
			throw new Error "utils.mergeDeep source and object are the same"
		`//</development>`

		for key, value of obj when hasOwnProp.call obj, key
			sourceValue = source[key]

			if value and typeof value is 'object' and not isArray(value) and sourceValue and typeof sourceValue is 'object' and not isArray(sourceValue)
				mergeDeep sourceValue, value
				continue

			source[key] = value

		source

*NotPrimitive* utils.fill(*NotPrimitive* source, *NotPrimitive* object)
-----------------------------------------------------------------------

This function translates the given *object* own properties into
the *source* object if they are defined in the
*source* prototype and are not defined in the *source* as own properties.

```
function User(){
}

User.prototype.name = '';

var user = new User;
utils.fill(user, {name: 'Johny', age: 40});
console.log(user);
// {name: 'Johny'}
```

	exports.fill = (source, obj) ->
		null
		`//<development>`
		if isPrimitive(source)
			throw new Error "utils.fill source cannot be primitive"
		if isPrimitive(obj)
			throw new Error "utils.fill object cannot be primitive"
		if source is obj
			throw new Error "utils.fill source and object are the same"
		`//</development>`

		for key, value of obj when hasOwnProp.call(obj, key)
			if key of source and not hasOwnProp.call(source, key)
				source[key] = value

		source

utils.remove(*NotPrimitive* object, *Any* element)
--------------------------------------------------

This function removes an array element or an object property.

```
var array = ['a', 'b', 'c'];
utils.remove(array, 'b');
console.log(array);
// ['a', 'c']

var object = {a: 1, b: 2};
utils.remove(object, 'a');
console.log(object);
// {b: 2}
```

	exports.remove = (obj, elem) ->
		null
		`//<development>`
		if isPrimitive(obj)
			throw new Error "utils.remove object cannot be primitive"
		`//</development>`

		if isArray(obj)
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

		return

*Object* utils.getPropertyDescriptor(*NotPrimitive* object, *String* property)
------------------------------------------------------------------------------

This function returns descriptor of the given *property* defined in the given *object*.

Unlike *Object.getOwnPropertyDescriptor()*, all the *object* prototypes are checked.

```
function User(){
  this.age = 0;
}

utils.defineProperty(User.prototype, 'isAdult', utils.CONFIGURABLE, function(){
  return this.age >= 18;
}, null);

var user = new User;
console.log(utils.getPropertyDescriptor(user, 'isAdult'));
// {enumerable: false, configurable: true, get: ..., set: undefined}
```

	exports.getPropertyDescriptor = (obj, prop) ->
		null
		`//<development>`
		if isPrimitive(obj)
			throw new Error "utils.getPropertyDescriptor object cannot be primitive"
		if typeof prop isnt 'string'
			throw new Error "utils.getPropertyDescriptor property must be a string"
		`//</development>`

		while obj and not desc
			desc = getObjOwnPropDesc obj, prop

			obj = getPrototypeOf obj

		desc

*Function* utils.lookupGetter(*NotPrimitive* object, *String* property)
-----------------------------------------------------------------------

This function returns function bound as a getter to the given *property*.

```
var object = {loaded: 2, length: 5};
utils.defineProperty(object, 'progress', null, function(){
  return this.loaded / this.length;
}, null);
console.log(utils.lookupGetter(object, 'progress'));
// function(){ return this.loaded / this.length; }
```

	exports.lookupGetter = do ->
		# use native function if possible
		if Object::__lookupGetter__
			{lookupGetter} = Object::
			(obj, prop) ->
				getter = lookupGetter.call(obj, prop)
				getter?.trueGetter or getter

		# use polyfill
		(obj, prop) ->
			if desc = exports.getPropertyDescriptor(obj, prop)
				desc.get?.trueGetter or desc.get

*Function* utils.lookupSetter(*NotPrimitive* object, *String* property)
-----------------------------------------------------------------------

This function returns function bound as a setter to the given *property*.

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

This function defines the given *property* in the given *object*.

*descriptors* is a bitmask contains *utils.WRITABLE*, *utils.ENUMERABLE* and
*utils.CONFIGURABLE*.

*value* becomes a getter if the given *setter* is not an *undefined*.

```
var object = {};

var desc = utils.ENUMERABLE | utils.WRITABLE | utils.CONFIGURABLE;
utils.defineProperty(object, 'name', desc, 'Emmy');
console.log(object.name);
// Emmy

utils.defineProperty(object, 'const', utils.ENUMERABLE, 'constantValue');
console.log(object.const);
// constantValue

utils.defineProperty(object, 'length', utils.ENUMERABLE | utils.CONFIGURABLE, function(){
  return 2;
}, null);
console.log(object.length);
// 2
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
			null
			`//<development>`
			if isPrimitive(obj)
				throw new Error "utils.defineProperty object cannot be primitive"
			if typeof prop isnt 'string'
				throw new Error "utils.defineProperty property must be a string"
			if desc? and (not exports.isInteger(desc) or desc < 0)
				throw new Error "utils.defineProperty descriptors bitmask must be a positive integer"
			`//</development>`

			# configure value
			if setter is undefined
				cfg = valueCfg
				valueCfg.value = getter
				valueCfg.writable = desc & WRITABLE

			# configure accessors
			else
				# HACK: safari bug
				# https://bugs.webkit.org/show_bug.cgi?id=132872
				if isSafari and getter
					_getter = getter
					getter = ->
						if @ isnt obj and @hasOwnProperty(prop)
							@[prop]
						else
							_getter.call @
					getter.trueGetter = _getter

				cfg = accessorsCfg
				accessorsCfg.get = if typeof getter is 'function' then getter else undefined
				accessorsCfg.set = if typeof setter is 'function' then setter else undefined

			# set common config
			cfg.enumerable = desc & ENUMERABLE
			cfg.configurable = desc & CONFIGURABLE

			# set property
			defObjProp obj, prop, cfg

			obj

*Any* utils.clone(*Any* param)
------------------------------

This function clones arrays and objects.

Functions are not cloned.

```
console.log(utils.clone([1, 2]))
// [1, 2]

console.log(utils.clone({a: 1}))
// {a: 1}
```

	clone = exports.clone = (param) ->
		if isArray(param)
			return param.slice()

		if isObject(param)
			result = createObject getPrototypeOf param

			for key in objKeys param
				result[key] = param[key]

			return result

		param

*Any* utils.cloneDeep(*Any* param)
----------------------------------

This function clones arrays and objects deeply.

```
var obj2 = {ba: 1};
var obj = {a: 1, b: obj2};

var clonedObj = utils.cloneDeep(obj);
console.log(clonedObj);
// {a: 1, b: {ba: 1}}

console.log(clonedObj.b === obj.b)
// false
```

	cloneDeep = exports.cloneDeep = (param) ->
		result = clone param

		if isObject result
			for key in objKeys result
				result[key] = cloneDeep result[key]

		result

*Boolean* utils.isEmpty(*NotPrimitive* object)
----------------------------------------------

Use this function to check whether the given *object* is empty, that is:
 - for arrays, no elements exists (*length* is 0),
 - for objects, no own properties are defined.

```
console.log(utils.isEmpty([]));
// true

console.log(utils.isEmpty([1, 2]));
// false

console.log(utils.isEmpty({}));
// true

console.log(utils.isEmpty({a: 1}));
// false
```

.

	exports.isEmpty = (object) ->
		null
		`//<development>`
		if isPrimitive(object)
			throw new Error "utils.isEmpty object cannot be primitive"
		`//</development>`

		if isArray object
			return !object.length
		else
			return !getOwnPropertyNames(object).length

*Any* utils.last(*NotPrimitive* array)
--------------------------------------

This function returns the last element of the given *array*.

```
console.log(utils.last(['a', 'b']))
// b

console.log(utils.last([]))
// undefined
```

	exports.last = (arg) ->
		null
		`//<development>`
		if isPrimitive(arg)
			throw new Error "utils.last array cannot be primitive"
		`//</development>`

		arg[arg.length - 1]

*NotPrimitive* utils.clear(*NotPrimitive* object)
-------------------------------------------------

Use this function to remove all elements from an array, or all own properties from an object.

```
var arr = ['a', 'b'];
utils.clear(arr);
console.log(arr);
// []

var obj = {age: 37};
utils.clear(obj);
console.log(obj);
// {}
```

	exports.clear = (obj) ->
		null
		`//<development>`
		if isPrimitive(obj)
			throw new Error "utils.clear object cannot be primitive"
		`//</development>`

		if isArray obj
			obj.pop() for _ in [0...obj.length] by 1
		else
			delete obj[key] for key in objKeys obj

		obj

*Object* utils.setPrototypeOf(*NotPrimitive* object, *NotPrimitive|Null* prototype)
-----------------------------------------------------------------------------------

This function changes the given *object* prototype into the given *prototype*.

This method on some environments returns a new object.

```
var obj = {a: 1};
var prototype = {b: 100};

var newObj = utils.setPrototypeOf(obj, prototype);

console.log(Object.getPrototypeOf(newObj) === prototype)
// true

console.log(newObj.a)
// 1

console.log(newObj.b)
// 100
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
				null
				`//<development>`
				if isPrimitive(obj)
					throw new Error "utils.setPrototypeOf object cannot be primitive"
				if proto? and isPrimitive(proto)
					throw new Error "utils.setPrototypeOf prototype cannot be primitive"
				`//</development>`

				obj.__proto__ = proto
				obj

		# object merging
		return (obj, proto) ->
			null
			`//<development>`
			if isPrimitive(obj)
				throw new Error "utils.setPrototypeOf object cannot be primitive"
			if proto? and isPrimitive(proto)
				throw new Error "utils.setPrototypeOf prototype cannot be primitive"
			`//</development>`

			if typeof obj is 'object'
				newObj = createObject proto
				merge newObj, obj
			else
				merge obj, proto
			newObj

*Boolean* utils.has(*Any* object, *Any* value)
----------------------------------------------

This function returns true if the given array contains the given *value*.

```
console.log(utils.has(['a'], 'a'))
// true

console.log(utils.has(['a'], 'b'))
// false
```

For objects, only own enumerable properties are checked.

```
var object = {
  city: 'New York'
}

console.log(utils.has(object, 'New York'))
// true
```

For strings, checks whether it contains the given *value*.

```
console.log(utils.has('abc', 'b'))
// true

console.log(utils.has('abc', 'e'))
// false
```

	has = exports.has = (obj, val) ->
		if typeof obj is 'string'
			!!~obj.indexOf(val)
		else
			`//<development>`
			if isPrimitive(obj)
				throw new Error "utils.has object must be a string or not primitive"
			`//</development>`

			if isArray(obj)
				!!~Array::indexOf.call obj, val
			else
				for key, value of obj when hasOwnProp.call(obj, key)
					if value is val
						return true

				false

*Array* utils.objectToArray(*Object* object, [*Function* valueGen, *Array* target = `[]`])
------------------------------------------------------------------------------------------

This function translates the given *object* into the array.

Array elements are determined by the *valueGen* function.
*valueGen* function is called with property name, property value and given *object*.

By default, array elements are equal properties values.

Elements are set into the *target* array (new array by default).

```
var object = {
  type: 'dog',
  name: 'Bandit'
};

console.log(utils.objectToArray(object));
// ['dog', 'Bandit']

console.log(utils.objectToArray(object, function(key, val){
  return key + "_" + val;
}));
// ['type_dog', 'name_Bandit']
```

	exports.objectToArray = (obj, valueGen, target) ->
		keys = objKeys obj
		target ?= keys

		`//<development>`
		if not isObject(obj)
			throw new Error "utils.objectToArray object must be an object"
		if valueGen? and typeof valueGen isnt 'function'
			throw new Error "utils.objectToArray valueGen must be a function"
		if not isArray(target)
			throw new Error "utils.objectToArray target must be an array"
		`//</development>`

		for key, i in keys
			value = if valueGen then valueGen(key, obj[key], obj) else obj[key]
			target[i] = value

		target

*Object* utils.arrayToObject(*Array* array, [*Function* keyGen, *Function* valueGen, *Object* target = `{}`])
-------------------------------------------------------------------------------------------------------------

This function translates the given *array* into the object with keys defined by
the *keyGen* function and values defined by the *valueGen* function.

Keys are equal array element indexes by default.
Values are equal array elements by default.

*keyGen* and *valueGen* functions are called with element index,
element value and given *array*.

Properties are set into the *target* object (new object by default).

```
console.log(utils.arrayToObject(['a', 'b']))
// {0: 'a', 1: 'b'}

console.log(utils.arrayToObject(['a'], function(i, elem){
  return "value_" + elem;
}));
// {"value_a": "a"}

console.log(utils.arrayToObject(['a'], function(i, elem){
  return elem;
}, function(i, elem){
  return i;
}));
// {"a": 0}
```

	exports.arrayToObject = (arr, keyGen, valueGen, target={}) ->
		null
		`//<development>`
		if not isArray(arr)
			throw new Error "utils.arrayToObject array must be an array"
		if keyGen? and typeof keyGen isnt 'function'
			throw new Error "utils.arrayToObject keyGen must be a function"
		if valueGen? and typeof valueGen isnt 'function'
			throw new Error "utils.arrayToObject valueGen must be a function"
		if not isObject(target)
			throw new Error "utils.arrayToObject target must be an object"
		`//</development>`

		for elem, i in arr
			key = if keyGen then keyGen(i, elem, arr) else i
			value = if valueGen then valueGen(i, elem, arr) else elem

			target[key] = value

		target

*String* utils.capitalize(*String* string)
------------------------------------------

Use this function to capitalize the given *string*.

```
console.log(utils.capitalize('name'))
// Name
```

	exports.capitalize = (str) ->
		null
		`//<development>`
		if typeof str isnt 'string'
			throw new Error "utils.capitalize string must be a string"
		`//</development>`

		unless str.length
			return ''

		str[0].toUpperCase() + str.slice(1)

*String* utils.addSlashes(*String* string)
------------------------------------------

Use this function to add backslashes before each *'* and *"* character.

```
console.log(utils.addSlashes('a"b'))
// a\"b
```

	exports.addSlashes = do ->
		SLASHES_RE = ///'|"///g
		NEW_SUB_STR = '\\$\&'

		(str) ->
			null
			`//<development>`
			if typeof str isnt 'string'
				throw new Error "utils.addSlashes string must be a string"
			`//</development>`

			unless str.length
				return str

			str.replace SLASHES_RE, NEW_SUB_STR

*String* utils.uid([*Integer* length=`8`])
------------------------------------------

This function generates unique string.

```
console.log(utils.uid())
// "50"
```

	exports.uid = (n=8) ->
		null
		`//<development>`
		if typeof n isnt 'number' or n <= 0 or not isFinite(n)
			throw new Error "utils.uid length must be a positive finite number"
		`//</development>`

		str = ''

		loop
			str += random().toString(16).slice 2
			if str.length >= n then break

		if str.length isnt n
			str = str.slice 0, n
		str

*Any* utils.tryFunction(*Function* function, [*Any* context, *Array* arguments, *Any* onfail])
----------------------------------------------------------------------------------------------

Use this function to call the given *function* with *context* and *arguments*.

If *function* throws an error, *onfail* is returned.

If *onfail* is a function, it will be called with the caught error.

```
function test(size){
  if (size === 0){
    throw "Wrong size!";
  }
}

console.log(utils.tryFunction(test, null, [0]))
// undefined

console.log(utils.tryFunction(test, null, [0], 'ERROR!'))
// ERROR!

console.log(utils.tryFunction(test, null, [100], 'ERROR!'))
// undefined
```

	exports.tryFunction = (func, context, args, onfail) ->
		null
		`//<development>`
		if typeof func isnt 'function'
			throw new Error "utils.tryFunction function must be a function"
		if args? and not isObject(args)
			throw new Error "utils.tryFunction arguments must be an object"
		`//</development>`

		try
			func.apply context, args
		catch err
			if typeof onfail is 'function' then onfail(err) else onfail

*Any* utils.catchError(*Function* function, [*Any* context, *Array* arguments])
-------------------------------------------------------------------------------

Use this function to call the given *function* with *context* and *arguments*.

Only caught error is returned.

```
function test(size){
  if (size === 0){
    throw "Wrong size!";
  }
}

console.log(utils.catchError(test, null, [0]))
// "Wrong size!"

console.log(utils.catchError(test, null, [100]))
// null
```

	exports.catchError = (func, context, args) ->
		null
		`//<development>`
		if typeof func isnt 'function'
			throw new Error "utils.catchError function must be a function"
		if args? and not isObject(args)
			throw new Error "utils.catchError arguments must be an object"
		`//</development>`

		try
			func.apply context, args
			return
		catch err
			err

*Function* utils.bindFunctionContext(*Function* function, *Any* context)
------------------------------------------------------------------------

Fast **Function::bind** version.

This function binds only function context (with no extra arguments).

Using **arguments** object in the given **function** is limited to the **function** length.

```
function func(arg1){
  console.log(this, arg1);
}

var bindFunc = utils.bindFunctionContext(func, {ctx: 1});

console.log(bindFunc('a'));
// {ctx: 1} "a"

console.log(bindFunc('a', 'b'));
// {ctx: 1} "a"
```

	exports.bindFunctionContext = do ->
		bindFuncs = [
			(func, ctx) ->
				-> func.call ctx
			(func, ctx) ->
				(a1) -> func.call ctx, a1
			(func, ctx) ->
				(a1, a2) -> func.call ctx, a1, a2
			(func, ctx) ->
				(a1, a2, a3) -> func.call ctx, a1, a2, a3
			(func, ctx) ->
				(a1, a2, a3, a4) -> func.call ctx, a1, a2, a3, a4
			(func, ctx) ->
				(a1, a2, a3, a4, a5) -> func.call ctx, a1, a2, a3, a4, a5
			(func, ctx) ->
				(a1, a2, a3, a4, a5, a6) -> func.call ctx, a1, a2, a3, a4, a5, a6
			(func, ctx) ->
				(a1, a2, a3, a4, a5, a6, a7) -> func.call ctx, a1, a2, a3, a4, a5, a6, a7
		]

		anyLengthBindFunc = (func, ctx) ->
			-> func.apply ctx, arguments

		(func, ctx) ->
			null
			`//<development>`
			if typeof func isnt 'function'
				throw new Error "utils.bindFunctionContext function must be a function"
			`//</development>`

			bindFuncs[func.length]?(func, ctx) or anyLengthBindFunc(func, ctx)

*Object* utils.errorToObject(*Error* error)
-------------------------------------------

This function takes an *Error* instance and returns a plain object with
the *error* name and message.

Standard error *name* and *message* properties are not enumerable.

```
var error = new ReferenceError('error message!');
console.log(utils.errorToObject(error));
// {name: 'ReferenceError', message: 'error message!'}
```

	exports.errorToObject = (error) ->
		null
		`//<development>`
		unless error instanceof Error
			throw new Error "utils.errorToObject error must be an Error instance"
		`//</development>`

		name: error.name
		message: error.message

*Object* utils.getOwnProperties(*Object* object)
------------------------------------------------

This function returns a new array or an object with own properties.

	exports.getOwnProperties = (obj) ->
		null
		`//<development>`
		if not isObject(obj)
			throw new Error "utils.getOwnProperties object must be an object"
		`//</development>`

		result = if isArray obj then [] else {}
		merge result, obj
		result

*Boolean* utils.isEqual(*Object* object1, *Object* object2, [*Function* compareFunction])
-----------------------------------------------------------------------------------------

Use this function to compare two objects or arrays deeply.

Optional *compareFunction* is used to determine whether two values are equal.

```
console.log(utils.isEqual([0, 1], [1, 0]))
// true

console.log(utils.isEqual({a: 1}, {a: 1}))
// true

console.log(utils.isEqual({a: {aa: 1}}, {a: {aa: 1}}))
// true

console.log(utils.isEqual({a: {aa: 1}}, {a: {aa: 1, ab: 2}}))
// false
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
			for key, value of a when a.hasOwnProperty(key)
				unless b.hasOwnProperty key
					return false

			for key, value of b when b.hasOwnProperty(key)
				unless a.hasOwnProperty key
					return false

			# whether values are equal
			for key, value of a when a.hasOwnProperty(key)
				if value and typeof value is 'object'
					unless isEqual value, b[key], compareFunc
						return false
					continue

				unless compareFunc(value, b[key])
					return false

			true

		(a, b, compareFunc=defaultComparison) ->
			null
			`//<development>`
			if typeof compareFunc isnt 'function'
				throw new Error "utils.isEqual compareFunction must be a function"
			`//</development>`

			if isArray(a) and isArray(b)
				forArrays a, b, compareFunc
			else if isObject(a) and isObject(b)
				forObjects a, b, compareFunc
			else
				return compareFunc a, b
