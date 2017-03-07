# Utils

> **API Reference** ▸ **Utils**

<!-- toc -->
Access it with:
```javascript
const { utils } = Neft;
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee)


* * * 

### `utils.isNode`

<dl><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>

`true` if the application is running in the node.js environment.


* * * 

### `utils.isServer`

<dl><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>

`utils.isNode` link.


* * * 

### `utils.isClient`

<dl><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>

`utils.isNode` inverse.


* * * 

### `utils.isBrowser`

<dl><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>


* * * 

### `utils.isQt`

<dl><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>


* * * 

### `utils.isAndroid`

<dl><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>


* * * 

### `utils.isIOS`

<dl><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#readonly-boolean-utilsisios)


* * * 

### `utils.NOP`

<dl><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Function</i></dd></dl>

No operation (an empty function).


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#function-utilsnop)


* * * 

### `utils.is()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>value2 — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#boolean-utilsisany-value1-any-value2)


* * * 

### `utils.isFloat()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#boolean-utilsisfloatany-value)


* * * 

### `utils.isInteger()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#boolean-utilsisintegerany-value)


* * * 

### `utils.isPrimitive()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

Returns `true` if the given value is a `null`, string, number, boolean or an `undefined`.

```javascript
console.log(utils.isPrimitive(null));
// true

console.log(utils.isPrimitive('abc'));
// true

console.log(utils.isPrimitive([]));
// false
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#boolean-utilsisprimitiveany-value)


* * * 

### `utils.isObject()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#boolean-utilsisobjectany-value)


* * * 

### `utils.isPlainObject()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#boolean-utilsisplainobjectany-value)


* * * 

### `utils.isArguments()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

Returns `true` if the given value is an arguments object.

```javascript
(function(){
  console.log(utils.isArguments(arguments))
  // true
})();

console.log(utils.isArguments({}))
// false
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#boolean-utilsisargumentsany-value)


* * * 

### `utils.merge()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>source — <i>NotPrimitive</i></li><li>object — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>

Overrides the given source object properties by the given object own properties.

The source object is returned.

```javascript
var config = {a: 1, b: 2};
utils.merge(config, {b: 99, d: 100});
console.log(config);
// {a: 1, b: 99, d: 100}
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#notprimitive-utilsmergenotprimitive-source-notprimitive-object)


* * * 

### `utils.mergeAll()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>source — <i>NotPrimitive</i></li><li>objects... — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>

Like the utils.merge(), but the amount of objects to merge is unknown.

```javascript
var config = {a: 1};
utils.merge(config, {b: 2}, {c: 3});
console.log(config);
// {a: 1, b: 2, c: 3}
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#notprimitive-utilsmergeallnotprimitive-source-notprimitive-objects)


* * * 

### `utils.mergeDeep()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>source — <i>NotPrimitive</i></li><li>object — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#notprimitive-utilsmergedeepnotprimitive-source-notprimitive-object)


* * * 

### `utils.fill()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>source — <i>NotPrimitive</i></li><li>object — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#notprimitive-utilsfillnotprimitive-source-notprimitive-object)


* * * 

### `utils.remove()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>element — <i>Any</i></li></ul></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#utilsremovenotprimitive-object-any-element)


* * * 

### `utils.removeFromUnorderedArray()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>array — <i>Array</i></li><li>element — <i>Any</i></li></ul></dd></dl>

Removes the given element from the given array.

Elements order may be changed.


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#utilsremovefromunorderedarrayarray-array-any-element)


* * * 

### `utils.getPropertyDescriptor()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>property — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#object-utilsgetpropertydescriptornotprimitive-object-string-property)


* * * 

### `utils.lookupGetter()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>property — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>

Returns the given property getter function defined in the given object.

```javascript
var object = {loaded: 2, length: 5};
utils.defineProperty(object, 'progress', null, function(){
  return this.loaded / this.length;
}, null);
console.log(utils.lookupGetter(object, 'progress'));
// function(){ return this.loaded / this.length; }
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#function-utilslookupgetternotprimitive-object-string-property)


* * * 

### `utils.lookupSetter()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>property — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>

Returns the given property setter function defined in the given object.


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#function-utilslookupsetternotprimitive-object-string-property)


* * * 

### `utils.defineProperty()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>property — <i>String</i></li><li>descriptors — <i>Integer</i></li><li>value — <i>Any</i> — <i>optional</i></li><li>setter — <i>Function</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#notprimitive-utilsdefinepropertynotprimitive-object-string-property-integer-descriptors-any-value-function-setter)


* * * 

### `utils.overrideProperty()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>property — <i>String</i></li><li>value — <i>Any</i> — <i>optional</i></li><li>setter — <i>Function</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#notprimitive-utilsoverridepropertynotprimitive-object-string-property-any-value-function-setter)


* * * 

### `utils.clone()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>param — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

Returns clone of the given array or object.

```javascript
console.log(utils.clone([1, 2]))
// [1, 2]

console.log(utils.clone({a: 1}))
// {a: 1}
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#any-utilscloneany-param)


* * * 

### `utils.cloneDeep()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>param — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#any-utilsclonedeepany-param)


* * * 

### `utils.isEmpty()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i> or <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#boolean-utilsisemptystringnotprimitive-object)


* * * 

### `utils.last()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>array — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

Returns the last element of the given array, or an array-like object.

```javascript
console.log(utils.last(['a', 'b']))
// b

console.log(utils.last([]))
// undefined
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#any-utilslastnotprimitive-array)


* * * 

### `utils.clear()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#notprimitive-utilsclearnotprimitive-object)


* * * 

### `utils.setPrototypeOf()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>prototype — <i>Null</i> or <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#object-utilssetprototypeofnotprimitive-object-notprimitivenull-prototype)


* * * 

### `utils.has()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Any</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#boolean-utilshasany-object-any-value)


* * * 

### `utils.objectToArray()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Object</i></li><li>valueGen — <i>Function</i> — <i>optional</i></li><li>target — <i>Array</i> — <code>= []</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#array-utilsobjecttoarrayobject-object-function-valuegen-array-target--)


* * * 

### `utils.arrayToObject()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>array — <i>Array</i></li><li>keyGen — <i>Function</i> — <i>optional</i></li><li>valueGen — <i>Function</i> — <i>optional</i></li><li>target — <i>Object</i> — <code>= {}</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#object-utilsarraytoobjectarray-array-function-keygen-function-valuegen-object-target--)


* * * 

### `utils.capitalize()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>string — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>

Capitalizes the given string.

```javascript
console.log(utils.capitalize('name'))
// Name
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#string-utilscapitalizestring-string)


* * * 

### `utils.addSlashes()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>string — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>

Adds backslashes before each `'` and `"` characters found in the given string.

```javascript
console.log(utils.addSlashes('a"b'))
// a\"b
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#string-utilsaddslashesstring-string)


* * * 

### `utils.uid()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>length — <i>Integer</i> — <code>= 8</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>

Returns pseudo-unique string with the given length.

This function doesn't quarantee uniqueness of the returned data.

```javascript
console.log(utils.uid())
// "50"
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#string-utilsuidinteger-length--8)


* * * 

### `utils.tryFunction()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>function — <i>Function</i></li><li>context — <i>Any</i> — <i>optional</i></li><li>arguments — <i>Array</i> — <i>optional</i></li><li>onFail — <i>Any</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#any-utilstryfunctionfunction-function-any-context-array-arguments-any-onfail)


* * * 

### `utils.catchError()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>function — <i>Function</i></li><li>context — <i>Any</i> — <i>optional</i></li><li>arguments — <i>Array</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#any-utilscatcherrorfunction-function-any-context-array-arguments)


* * * 

### `utils.bindFunctionContext()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>function — <i>Function</i></li><li>context — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#function-utilsbindfunctioncontextfunction-function-any-context)


* * * 

### `utils.errorToObject()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>error — <i>Error</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>

Returns a plain object with the given error name, message and other custom properties.

Standard error `name` and `message` properties are not enumerable.

```javascript
var error = new ReferenceError('error message!');
console.log(utils.errorToObject(error));
// {name: 'ReferenceError', message: 'error message!'}
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#object-utilserrortoobjecterror-error)


* * * 

### `utils.getOwnProperties()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>

Returns an array or an object with own properties associated in the given object.


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#object-utilsgetownpropertiesobject-object)


* * * 

### `utils.deprecate()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>function — <i>Function</i></li><li>message — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>

Prints a warning that the given function should not be used.

Returns a new function which warns once by default.


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#function-utilsdeprecatefunction-function-string-message)


* * * 

### `utils.isEqual()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object1 — <i>Object</i></li><li>object2 — <i>Object</i></li><li>compareFunction — <i>Function</i> — <i>optional</i></li><li>maxDeep — <i>Integer</i> — <code>= Infinity</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

Returns `true` if the given objects have equal values.

The given compareFunction is used to compare two values (which at least one them is primitive).
By default the compareFunction uses triple comparison (`===`).

```javascript
utils.isEqual([1, 0], [1, 0])
// true

utils.isEqual({a: 1}, {a: 1})
// true

utils.isEqual({a: {aa: 1}}, {a: {aa: 1}})
// true

utils.isEqual([0, 1], [1, 0])
// false

utils.isEqual({a: {aa: 1}}, {a: {aa: 1, ab: 2}})
// false
```


> [`Source`](https://github.com/Neft-io/neft/blob/6413f269be2b775d556b4cf9e545595461357009/src/utils/index.litcoffee#boolean-utilsisequalobject-object1-object-object2-function-comparefunction-integer-maxdeep--infinity)

