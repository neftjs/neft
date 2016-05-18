> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Utils @library**

Utils @library
==============

Access it with:
```javascript
var utils = require('utils');
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#utils-library)

## Table of contents
  * [utils.isNode](#readonly-boolean-utilsisnode)
  * [utils.isServer](#readonly-boolean-utilsisserver)
  * [utils.isClient](#readonly-boolean-utilsisclient)
  * [utils.isBrowser](#readonly-boolean-utilsisbrowser)
  * [utils.NOP](#function-utilsnop)
  * [utils.is(value1, value2)](#boolean-utilsisany-value1-any-value2)
  * [utils.isFloat(value)](#boolean-utilsisfloatany-value)
  * [utils.isInteger(value)](#boolean-utilsisintegerany-value)
  * [utils.isPrimitive(value)](#boolean-utilsisprimitiveany-value)
  * [utils.isObject(value)](#boolean-utilsisobjectany-value)
  * [utils.isPlainObject(value)](#boolean-utilsisplainobjectany-value)
  * [utils.isArguments(value)](#boolean-utilsisargumentsany-value)
  * [utils.merge(source, object)](#notprimitive-utilsmergenotprimitive-source-notprimitive-object)
  * [utils.mergeAll(source, objects...)](#notprimitive-utilsmergeallnotprimitive-source-notprimitive-objects)
  * [utils.mergeDeep(source, object)](#notprimitive-utilsmergedeepnotprimitive-source-notprimitive-object)
  * [utils.fill(source, object)](#notprimitive-utilsfillnotprimitive-source-notprimitive-object)
  * [utils.remove(object, element)](#utilsremovenotprimitive-object-any-element)
  * [utils.removeFromUnorderedArray(array, element)](#utilsremovefromunorderedarrayarray-array-any-element)
  * [utils.getPropertyDescriptor(object, property)](#object-utilsgetpropertydescriptornotprimitive-object-string-property)
  * [utils.lookupGetter(object, property)](#function-utilslookupgetternotprimitive-object-string-property)
  * [utils.lookupSetter(object, property)](#function-utilslookupsetternotprimitive-object-string-property)
  * [utils.defineProperty(object, property, descriptors, [value, setter])](#notprimitive-utilsdefinepropertynotprimitive-object-string-property-integer-descriptors-any-value-function-setter)
  * [utils.overrideProperty(object, property, [value, setter])](#notprimitive-utilsoverridepropertynotprimitive-object-string-property-any-value-function-setter)
  * [utils.clone(param)](#any-utilscloneany-param)
  * [utils.cloneDeep(param)](#any-utilsclonedeepany-param)
  * [utils.isEmpty(*String|NotPrimitive* object)](#boolean-utilsisemptystringnotprimitive-object)
  * [utils.last(array)](#any-utilslastnotprimitive-array)
  * [utils.clear(object)](#notprimitive-utilsclearnotprimitive-object)
  * [utils.setPrototypeOf(object, *NotPrimitive|Null* prototype)](#object-utilssetprototypeofnotprimitive-object-notprimitivenull-prototype)
  * [utils.has(object, value)](#boolean-utilshasany-object-any-value)
  * [utils.objectToArray(object, [valueGen, target = `[]`])](#array-utilsobjecttoarrayobject-object-function-valuegen-array-target--)
  * [utils.arrayToObject(array, [keyGen, valueGen, target = `{}`])](#object-utilsarraytoobjectarray-array-function-keygen-function-valuegen-object-target--)
  * [utils.capitalize(string)](#string-utilscapitalizestring-string)
  * [utils.addSlashes(string)](#string-utilsaddslashesstring-string)
  * [utils.uid([length=`8`])](#string-utilsuidinteger-length8)
  * [utils.tryFunction(function, [context, arguments, onFail])](#any-utilstryfunctionfunction-function-any-context-array-arguments-any-onfail)
  * [utils.catchError(function, [context, arguments])](#any-utilscatcherrorfunction-function-any-context-array-arguments)
  * [utils.bindFunctionContext(function, context)](#function-utilsbindfunctioncontextfunction-function-any-context)
  * [utils.errorToObject(error)](#object-utilserrortoobjecterror-error)
  * [utils.getOwnProperties(object)](#object-utilsgetownpropertiesobject-object)
  * [utils.isEqual(object1, object2, [compareFunction, maxDeep=`Infinity`])](#boolean-utilsisequalobject-object1-object-object2-function-comparefunction-integer-maxdeepinfinity)

ReadOnly *Boolean* utils.isNode
-------------------------------

`true` if the application is running in the node.js environment.

ReadOnly *Boolean* utils.isServer
---------------------------------

`utils.isNode` link.

ReadOnly *Boolean* utils.isClient
---------------------------------

`utils.isNode` inverse.

ReadOnly *Boolean* utils.isBrowser
----------------------------------
ReadOnly *Boolean* utils.isQt
-----------------------------
ReadOnly *Boolean* utils.isAndroid
----------------------------------
ReadOnly *Boolean* utils.isIOS
------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#readonly-boolean-utilsisbrowserreadonly-boolean-utilsisqtreadonly-boolean-utilsisandroidreadonly-boolean-utilsisios)

*Function* utils.NOP
--------------------

No operation (an empty function).

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#function-utilsnop)

*Boolean* utils.is(*Any* value1, *Any* value2)
----------------------------------------------

Returns `true` if the given values are exactly the same.
It's the *Object.is()* function polyfill (introduced in ECMAScript 6).
In opposite to the `===` operator, this function treats two *NaN*s as equal, and
`-0` and `+0` as not equal.
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-utilsisany-value1-any-value2)

*Boolean* utils.isFloat(*Any* value)
------------------------------------

Returns `true` if the given value is a finite number.
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-utilsisfloatany-value)

*Boolean* utils.isInteger(*Any* value)
--------------------------------------

Returns `true` if the given value is an integer.
```javascript
console.log(utils.isInteger(10));
// true
console.log(utils.isInteger(-2));
// true
console.log(utils.isInteger(1.22));
// false
console.log(utils.isInteger('2'));
// false
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-utilsisintegerany-value)

*Boolean* utils.isPrimitive(*Any* value)
----------------------------------------

Returns `true` if the given value is a `null`, string, number, boolean or an `undefined`.
```javascript
console.log(utils.isPrimitive(null));
// true
console.log(utils.isPrimitive('abc'));
// true
console.log(utils.isPrimitive([]));
// false
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-utilsisprimitiveany-value)

*Boolean* utils.isObject(*Any* value)
-------------------------------------

Returns `true` if the given value is an object (object, array, but not a `null`).
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-utilsisobjectany-value)

*Boolean* utils.isPlainObject(*Any* value)
------------------------------------------

Returns `true` if the given value is an object with no prototype,
or with a prototype equal the `Object.prototype`.
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-utilsisplainobjectany-value)

*Boolean* utils.isArguments(*Any* value)
----------------------------------------

Returns `true` if the given value is an arguments object.
```javascript
(function(){
  console.log(utils.isArguments(arguments))
  // true
})();
console.log(utils.isArguments({}))
// false
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-utilsisargumentsany-value)

*NotPrimitive* utils.merge(*NotPrimitive* source, *NotPrimitive* object)
------------------------------------------------------------------------

Overrides the given source object properties by the given object own properties.
The source object is returned.
```javascript
var config = {a: 1, b: 2};
utils.merge(config, {b: 99, d: 100});
console.log(config);
// {a: 1, b: 99, d: 100}
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-utilsmergenotprimitive-source-notprimitive-object)

*NotPrimitive* utils.mergeAll(*NotPrimitive* source, *NotPrimitive* objects...)
-------------------------------------------------------------------------------

Like the utils.merge(), but the amount of objects to merge is unknown.
```javascript
var config = {a: 1};
utils.merge(config, {b: 2}, {c: 3});
console.log(config);
// {a: 1, b: 2, c: 3}
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-utilsmergeallnotprimitive-source-notprimitive-objects)

*NotPrimitive* utils.mergeDeep(*NotPrimitive* source, *NotPrimitive* object)
----------------------------------------------------------------------------

Overrides the given source object properties and all its objects
by the given object own properties.
The source object is returned.
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-utilsmergedeepnotprimitive-source-notprimitive-object)

*NotPrimitive* utils.fill(*NotPrimitive* source, *NotPrimitive* object)
-----------------------------------------------------------------------

Sets the given object properties into the given source object if the property
exists in the given source, but it's not defined as an own property.
The source object is returned.
```javascript
function User(){
}
User.prototype.name = '';
var user = new User;
utils.fill(user, {name: 'Johny', age: 40});
console.log(user);
// {name: 'Johny'}
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-utilsfillnotprimitive-source-notprimitive-object)

utils.remove(*NotPrimitive* object, *Any* element)
--------------------------------------------------

Removes an array element or an object property from the given object.
```javascript
var array = ['a', 'b', 'c'];
utils.remove(array, 'b');
console.log(array);
// ['a', 'c']
var object = {a: 1, b: 2};
utils.remove(object, 'a');
console.log(object);
// {b: 2}
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#utilsremovenotprimitive-object-any-element)

utils.removeFromUnorderedArray(*Array* array, *Any* element)
------------------------------------------------------------

Removes the given element from the given array.
Elements order may be changed.

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#utilsremovefromunorderedarrayarray-array-any-element)

*Object* utils.getPropertyDescriptor(*NotPrimitive* object, *String* property)
------------------------------------------------------------------------------

Returns the descriptor of the given property defined in the given object.
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#object-utilsgetpropertydescriptornotprimitive-object-string-property)

*Function* utils.lookupGetter(*NotPrimitive* object, *String* property)
-----------------------------------------------------------------------

Returns the given property getter function defined in the given object.
```javascript
var object = {loaded: 2, length: 5};
utils.defineProperty(object, 'progress', null, function(){
  return this.loaded / this.length;
}, null);
console.log(utils.lookupGetter(object, 'progress'));
// function(){ return this.loaded / this.length; }
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#function-utilslookupgetternotprimitive-object-string-property)

*Function* utils.lookupSetter(*NotPrimitive* object, *String* property)
-----------------------------------------------------------------------

Returns the given property setter function defined in the given object.

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#function-utilslookupsetternotprimitive-object-string-property)

*NotPrimitive* utils.defineProperty(*NotPrimitive* object, *String* property, *Integer* descriptors, [*Any* value, *Function* setter])
--------------------------------------------------------------------------------------------------------------------------------------

Defines the given property in the given object.
The descriptors argument is a bitmask accepting
`utils.WRITABLE`, `utils.ENUMERABLE` and `utils.CONFIGURABLE`.
The value argument becomes a getter function if the given setter is not an undefined.
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-utilsdefinepropertynotprimitive-object-string-property-integer-descriptors-any-value-function-setter)

*NotPrimitive* utils.overrideProperty(*NotPrimitive* object, *String* property, [*Any* value, *Function* setter])
-----------------------------------------------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-utilsoverridepropertynotprimitive-object-string-property-any-value-function-setter)

*Any* utils.clone(*Any* param)
------------------------------

Returns clone of the given array or object.
```javascript
console.log(utils.clone([1, 2]))
// [1, 2]
console.log(utils.clone({a: 1}))
// {a: 1}
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#any-utilscloneany-param)

*Any* utils.cloneDeep(*Any* param)
----------------------------------

Returns deep clone of the given array or object.
```javascript
var obj2 = {ba: 1};
var obj = {a: 1, b: obj2};
var clonedObj = utils.cloneDeep(obj);
console.log(clonedObj);
// {a: 1, b: {ba: 1}}
console.log(clonedObj.b === obj.b)
// false
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#any-utilsclonedeepany-param)

*Boolean* utils.isEmpty(*String|NotPrimitive* object)
-----------------------------------------------------

Returns `true` if the given array has no elements, of the given object has no own properties.
```javascript
console.log(utils.isEmpty([]));
// true
console.log(utils.isEmpty([1, 2]));
// false
console.log(utils.isEmpty({}));
// true
console.log(utils.isEmpty({a: 1}));
// false
console.log(utils.isEmpty(''));
// true
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-utilsisemptystringnotprimitive-object)

*Any* utils.last(*NotPrimitive* array)
--------------------------------------

Returns the last element of the given array, or an array-like object.
```javascript
console.log(utils.last(['a', 'b']))
// b
console.log(utils.last([]))
// undefined
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#any-utilslastnotprimitive-array)

*NotPrimitive* utils.clear(*NotPrimitive* object)
-------------------------------------------------

Removes all elements from the given array, or all own properties from the given object.
```javascript
var arr = ['a', 'b'];
utils.clear(arr);
console.log(arr);
// []
var obj = {age: 37};
utils.clear(obj);
console.log(obj);
// {}
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-utilsclearnotprimitive-object)

*Object* utils.setPrototypeOf(*NotPrimitive* object, *NotPrimitive|Null* prototype)
-----------------------------------------------------------------------------------

Changes the given object prototype into the given prototype.
**This function on some environments returns a new object.**
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#object-utilssetprototypeofnotprimitive-object-notprimitivenull-prototype)

*Boolean* utils.has(*Any* object, *Any* value)
----------------------------------------------

Returns `true` if the given array contains the given value.
```javascript
console.log(utils.has(['a'], 'a'))
// true
console.log(utils.has(['a'], 'b'))
// false
```
Returns `true` if the given object has an own property names as the given value.
```javascript
var object = {
  city: 'New York'
}
console.log(utils.has(object, 'New York'))
// true
```
Returns `true` if the given string contains the given value.
```javascript
console.log(utils.has('abc', 'b'))
// true
console.log(utils.has('abc', 'e'))
// false
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-utilshasany-object-any-value)

*Array* utils.objectToArray(*Object* object, [*Function* valueGen, *Array* target = `[]`])
------------------------------------------------------------------------------------------

Translates the given object into an array.
Array elements are determined by the given valueGen function.
The valueGen function is called with the property name, property value and the given object.
By default, the valueGen returns the object property value.
Created elements are set into the given target array (a new array by default).
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#array-utilsobjecttoarrayobject-object-function-valuegen-array-target--)

*Object* utils.arrayToObject(*Array* array, [*Function* keyGen, *Function* valueGen, *Object* target = `{}`])
-------------------------------------------------------------------------------------------------------------

Translates the given array into an object.
Object keys are determined by the given keyGen function.
Object key values are determined by the given valueGen function.
The keyGen and valueGen functions are called with the array element index,
array element value and the array itself.
By default, the keyGen function returns the array element index.
By default, the valueGen function returns the array element value.
Created proeprties are set into the given target object (a new object by default).
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#object-utilsarraytoobjectarray-array-function-keygen-function-valuegen-object-target--)

*String* utils.capitalize(*String* string)
------------------------------------------

Capitalizes the given string.
```javascript
console.log(utils.capitalize('name'))
// Name
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#string-utilscapitalizestring-string)

*String* utils.addSlashes(*String* string)
------------------------------------------

Adds backslashes before each `'` and `"` characters found in the given string.
```javascript
console.log(utils.addSlashes('a"b'))
// a\"b
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#string-utilsaddslashesstring-string)

*String* utils.uid([*Integer* length=`8`])
------------------------------------------

Returns pseudo-unique string with the given length.
This function doesn't quarantee uniqueness of the returned data.
```javascript
console.log(utils.uid())
// "50"
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#string-utilsuidinteger-length8)

*Any* utils.tryFunction(*Function* function, [*Any* context, *Array* arguments, *Any* onFail])
----------------------------------------------------------------------------------------------

Calls the given function with the given context and arguments.
If the function throws an error, the given onFail value is returned.
If the given onFail is a function, it will be called with the caught error.
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#any-utilstryfunctionfunction-function-any-context-array-arguments-any-onfail)

*Any* utils.catchError(*Function* function, [*Any* context, *Array* arguments])
-------------------------------------------------------------------------------

Calls the given function with the given context and arguments.
Returns caught error.
```javascript
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#any-utilscatcherrorfunction-function-any-context-array-arguments)

*Function* utils.bindFunctionContext(*Function* function, *Any* context)
------------------------------------------------------------------------

Returns a new function calling the given function with the given context and
arguments in an amount lower or equal the function length.
```javascript
function func(arg1){
  console.log(this, arg1);
}
var bindFunc = utils.bindFunctionContext(func, {ctx: 1});
console.log(bindFunc('a'));
// {ctx: 1} "a"
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#function-utilsbindfunctioncontextfunction-function-any-context)

*Object* utils.errorToObject(*Error* error)
-------------------------------------------

Returns a plain object with the given error name, message and other custom properties.
Standard error `name` and `message` properties are not enumerable.
```javascript
var error = new ReferenceError('error message!');
console.log(utils.errorToObject(error));
// {name: 'ReferenceError', message: 'error message!'}
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#object-utilserrortoobjecterror-error)

*Object* utils.getOwnProperties(*Object* object)
------------------------------------------------

Returns an array or an object with own properties associated in the given object.

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#object-utilsgetownpropertiesobject-object)

*Boolean* utils.isEqual(*Object* object1, *Object* object2, [*Function* compareFunction, *Integer* maxDeep=`Infinity`])
-----------------------------------------------------------------------------------------------------------------------

Returns `true` if the given objects have equal values.
The given compareFunction is used to compare two values (which at least one them is primitive).
By default the compareFunction uses triple comparison (`===`).
```javascript
console.log(utils.isEqual([0, 1], [1, 0]))
// true
console.log(utils.isEqual({a: 1}, {a: 1}))
// true
console.log(utils.isEqual({a: {aa: 1}}, {a: {aa: 1}}))
// true
console.log(utils.isEqual({a: {aa: 1}}, {a: {aa: 1, ab: 2}}))
// false
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-utilsisequalobject-object1-object-object2-function-comparefunction-integer-maxdeepinfinity)

