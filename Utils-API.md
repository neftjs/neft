> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Utils**

# Utils

Access it with:
```javascript
const { utils } = Neft;
```
See one of submodules:
 - [[Asynchronous|Utils-Asynchronous-API]]
 - [[Properties extraction|Utils-Properties-extraction-API]]
 - [[Stringifying|Utils-Stringifying-API]]

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#utils)

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>read only</dt></dl>
## Table of contents
  * [isNode](#isnode)
  * [isServer](#isserver)
  * [isClient](#isclient)
  * [isBrowser](#isbrowser)
  * [NOP](#nop)
  * [is](#is)
  * [isFloat](#isfloat)
  * [isInteger](#isinteger)
  * [isPrimitive](#isprimitive)
  * [isObject](#isobject)
  * [isPlainObject](#isplainobject)
  * [isArguments](#isarguments)
  * [merge](#merge)
  * [mergeAll](#mergeall)
  * [mergeDeep](#mergedeep)
  * [fill](#fill)
  * [remove](#remove)
  * [removeFromUnorderedArray](#removefromunorderedarray)
  * [getPropertyDescriptor](#getpropertydescriptor)
  * [lookupGetter](#lookupgetter)
  * [lookupSetter](#lookupsetter)
  * [defineProperty](#defineproperty)
  * [overrideProperty](#overrideproperty)
  * [clone](#clone)
  * [cloneDeep](#clonedeep)
  * [isEmpty](#isempty)
  * [last](#last)
  * [clear](#clear)
  * [setPrototypeOf](#setprototypeof)
  * [has](#has)
  * [objectToArray](#objecttoarray)
  * [arrayToObject](#arraytoobject)
  * [*String* capitalize(*String* string)](#string-capitalizestring-string)
  * [*String* addSlashes(*String* string)](#string-addslashesstring-string)
  * [*String* uid([*Integer* length = `8`])](#string-uidinteger-length--8)
  * [*Any* tryFunction(*Function* function, [*Any* context, *Array* arguments, *Any* onFail])](#any-tryfunctionfunction-function-any-context-array-arguments-any-onfail)
  * [*Any* catchError(*Function* function, [*Any* context, *Array* arguments])](#any-catcherrorfunction-function-any-context-array-arguments)
  * [*Function* bindFunctionContext(*Function* function, *Any* context)](#function-bindfunctioncontextfunction-function-any-context)
  * [*Object* errorToObject(*Error* error)](#object-errortoobjecterror-error)
  * [*Object* getOwnProperties(*Object* object)](#object-getownpropertiesobject-object)
  * [*Boolean* isEqual(*Object* object1, *Object* object2, [*Function* compareFunction, *Integer* maxDeep = `Infinity`])](#boolean-isequalobject-object1-object-object2-function-comparefunction-integer-maxdeep--infinity)
  * [Glossary](#glossary)

##isNode
`true` if the application is running in the node.js environment.

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>read only</dt></dl>
##isServer
`utils.isNode` link.

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>read only</dt></dl>
##isClient
`utils.isNode` inverse.

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>read only</dt></dl>
##isBrowser
> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#readonly-boolean-isbrowser-readonly-boolean-isqt-readonly-boolean-isandroid-readonly-boolean-isios)

<dl><dt>Type</dt><dd><i>Function</i></dd></dl>
##NOP
No operation (an empty function).

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#function-nop)

<dl><dt>Parameters</dt><dd><ul><li><b>value1</b> — <i>Any</i></li><li><b>value2</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
##is
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-isany-value1-any-value2)

<dl><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
##isFloat
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-isfloatany-value)

<dl><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
##isInteger
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-isintegerany-value)

<dl><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
##isPrimitive
Returns `true` if the given value is a `null`, string, number, boolean or an `undefined`.
```javascript
console.log(utils.isPrimitive(null));
// true
console.log(utils.isPrimitive('abc'));
// true
console.log(utils.isPrimitive([]));
// false
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-isprimitiveany-value)

<dl><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
##isObject
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-isobjectany-value)

<dl><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
##isPlainObject
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-isplainobjectany-value)

<dl><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
##isArguments
Returns `true` if the given value is an arguments object.
```javascript
(function(){
  console.log(utils.isArguments(arguments))
  // true
})();
console.log(utils.isArguments({}))
// false
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-isargumentsany-value)

<dl><dt>Parameters</dt><dd><ul><li><b>source</b> — <i>NotPrimitive</i></li><li><b>object</b> — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
##merge
Overrides the given source object properties by the given object own properties.
The source object is returned.
```javascript
var config = {a: 1, b: 2};
utils.merge(config, {b: 99, d: 100});
console.log(config);
// {a: 1, b: 99, d: 100}
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-mergenotprimitive-source-notprimitive-object)

<dl><dt>Parameters</dt><dd><ul><li><b>source</b> — <i>NotPrimitive</i></li><li><b>objects...</b> — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
##mergeAll
Like the utils.merge(), but the amount of objects to merge is unknown.
```javascript
var config = {a: 1};
utils.merge(config, {b: 2}, {c: 3});
console.log(config);
// {a: 1, b: 2, c: 3}
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-mergeallnotprimitive-source-notprimitive-objects)

<dl><dt>Parameters</dt><dd><ul><li><b>source</b> — <i>NotPrimitive</i></li><li><b>object</b> — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
##mergeDeep
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-mergedeepnotprimitive-source-notprimitive-object)

<dl><dt>Parameters</dt><dd><ul><li><b>source</b> — <i>NotPrimitive</i></li><li><b>object</b> — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
##fill
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-fillnotprimitive-source-notprimitive-object)

<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>NotPrimitive</i></li><li><b>element</b> — <i>Any</i></li></ul></dd></dl>
##remove
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#removenotprimitive-object-any-element)

<dl><dt>Parameters</dt><dd><ul><li><b>array</b> — <i>Array</i></li><li><b>element</b> — <i>Any</i></li></ul></dd></dl>
##removeFromUnorderedArray
Removes the given element from the given array.
Elements order may be changed.

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#removefromunorderedarrayarray-array-any-element)

<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>NotPrimitive</i></li><li><b>property</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>
##getPropertyDescriptor
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#object-getpropertydescriptornotprimitive-object-string-property)

<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>NotPrimitive</i></li><li><b>property</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
##lookupGetter
Returns the given property getter function defined in the given object.
```javascript
var object = {loaded: 2, length: 5};
utils.defineProperty(object, 'progress', null, function(){
  return this.loaded / this.length;
}, null);
console.log(utils.lookupGetter(object, 'progress'));
// function(){ return this.loaded / this.length; }
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#function-lookupgetternotprimitive-object-string-property)

<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>NotPrimitive</i></li><li><b>property</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
##lookupSetter
Returns the given property setter function defined in the given object.

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#function-lookupsetternotprimitive-object-string-property)

<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>NotPrimitive</i></li><li><b>property</b> — <i>String</i></li><li><b>descriptors</b> — <i>Integer</i></li><li><b>value</b> — <i>Any</i> — <i>optional</i></li><li><b>setter</b> — <i>Function</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
##defineProperty
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-definepropertynotprimitive-object-string-property-integer-descriptors-any-value-function-setter)

<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>NotPrimitive</i></li><li><b>property</b> — <i>String</i></li><li><b>value</b> — <i>Any</i> — <i>optional</i></li><li><b>setter</b> — <i>Function</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
##overrideProperty
> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-overridepropertynotprimitive-object-string-property-any-value-function-setter)

<dl><dt>Parameters</dt><dd><ul><li><b>param</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
##clone
Returns clone of the given array or object.
```javascript
console.log(utils.clone([1, 2]))
// [1, 2]
console.log(utils.clone({a: 1}))
// {a: 1}
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#any-cloneany-param)

<dl><dt>Parameters</dt><dd><ul><li><b>param</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
##cloneDeep
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#any-clonedeepany-param)

<dl><dt>Parameters</dt><dd><ul><li><b>|</b> — <i>String</i></li><li><b>object</b> — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
##isEmpty
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-isemptystringnotprimitive-object)

<dl><dt>Parameters</dt><dd><ul><li><b>array</b> — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
##last
Returns the last element of the given array, or an array-like object.
```javascript
console.log(utils.last(['a', 'b']))
// b
console.log(utils.last([]))
// undefined
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#any-lastnotprimitive-array)

<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
##clear
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#notprimitive-clearnotprimitive-object)

<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>NotPrimitive</i></li><li><b>|</b> — <i>NotPrimitive</i></li><li><b>prototype</b> — <i>Null</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>
##setPrototypeOf
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#object-setprototypeofnotprimitive-object-notprimitivenull-prototype)

<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>Any</i></li><li><b>value</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
##has
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-hasany-object-any-value)

<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>Object</i></li><li><b>valueGen</b> — <i>Function</i> — <i>optional</i></li><li><b>target</b> — <i>Array</i> — <code>= []</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
##objectToArray
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#array-objecttoarrayobject-object-function-valuegen-array-target--)

<dl><dt>Parameters</dt><dd><ul><li><b>array</b> — <i>Array</i></li><li><b>keyGen</b> — <i>Function</i> — <i>optional</i></li><li><b>valueGen</b> — <i>Function</i> — <i>optional</i></li><li><b>target</b> — <i>Object</i> — <code>= {}</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>
##arrayToObject
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#object-arraytoobjectarray-array-function-keygen-function-valuegen-object-target--)

## *String* capitalize(*String* string)

Capitalizes the given string.
```javascript
console.log(utils.capitalize('name'))
// Name
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#string-capitalizestring-string)

## *String* addSlashes(*String* string)

Adds backslashes before each `'` and `"` characters found in the given string.
```javascript
console.log(utils.addSlashes('a"b'))
// a\"b
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#string-addslashesstring-string)

## *String* uid([[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) length = `8`])

Returns pseudo-unique string with the given length.
This function doesn't quarantee uniqueness of the returned data.
```javascript
console.log(utils.uid())
// "50"
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#string-uidinteger-length--8)

## *Any* tryFunction(*Function* function, [*Any* context, *Array* arguments, *Any* onFail])

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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#any-tryfunctionfunction-function-any-context-array-arguments-any-onfail)

## *Any* catchError(*Function* function, [*Any* context, *Array* arguments])

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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#any-catcherrorfunction-function-any-context-array-arguments)

## *Function* bindFunctionContext(*Function* function, *Any* context)

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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#function-bindfunctioncontextfunction-function-any-context)

## [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) errorToObject(*Error* error)

Returns a plain object with the given error name, message and other custom properties.
Standard error `name` and `message` properties are not enumerable.
```javascript
var error = new ReferenceError('error message!');
console.log(utils.errorToObject(error));
// {name: 'ReferenceError', message: 'error message!'}
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#object-errortoobjecterror-error)

## [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) getOwnProperties([*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) object)

Returns an array or an object with own properties associated in the given object.

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#object-getownpropertiesobject-object)

## *Boolean* isEqual([*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) object1, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) object2, [*Function* compareFunction, [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) maxDeep = `Infinity`])

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

> [`Source`](/Neft-io/neft/tree/master/src/utils/index.litcoffee#boolean-isequalobject-object1-object-object2-function-comparefunction-integer-maxdeep--infinity)

## Glossary

 - [NOP](#function-nop)
 - [Float](#boolean-isfloatany-value)
 - [Integer](#boolean-isintegerany-value)
 - [Primitive](#boolean-isprimitiveany-value)
 - [Object](#boolean-isobjectany-value)
 - [PlainObject](#boolean-isplainobjectany-value)
 - [Arguments](#boolean-isargumentsany-value)
 - [utils.is()](#boolean-isany-value1-any-value2)

