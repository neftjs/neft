> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Utils**

> * [[Asynchronous|Utils-Asynchronous-API]]
> * [[Properties extraction|Utils-Properties extraction-API]]
> * [[Stringifying|Utils-Stringifying-API]]

# Utils

Access it with:
```javascript
const { utils } = Neft;
```
See one of submodules:
 - [[Asynchronous|Utils-Asynchronous-API]]
 - [[Properties extraction|Utils-Properties-extraction-API]]
 - [[Stringifying|Utils-Stringifying-API]]

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#utils)

## Table of contents
* [Utils](#utils)
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
  * [capitalize](#capitalize)
  * [addSlashes](#addslashes)
  * [uid](#uid)
  * [tryFunction](#tryfunction)
  * [catchError](#catcherror)
  * [bindFunctionContext](#bindfunctioncontext)
  * [errorToObject](#errortoobject)
  * [getOwnProperties](#getownproperties)
  * [isEqual](#isequal)
  * [Glossary](#glossary)

##isNode
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; isNode</code></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
`true` if the application is running in the node.js environment.

##isServer
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; isServer</code></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
`utils.isNode` link.

##isClient
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; isClient</code></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
`utils.isNode` inverse.

##isBrowser
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; isBrowser</code></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#isbrowser)

##NOP
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; NOP</code></dd><dt>Type</dt><dd><i>Function</i></dd></dl>
No operation (an empty function).

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#nop)

##is
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; is(&#x2A;Any&#x2A; value1, &#x2A;Any&#x2A; value2)</code></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>value2 — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#is)

##isFloat
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; isFloat(&#x2A;Any&#x2A; value)</code></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#isfloat)

##isInteger
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; isInteger(&#x2A;Any&#x2A; value)</code></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#isinteger)

##isPrimitive
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; isPrimitive(&#x2A;Any&#x2A; value)</code></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the given value is a `null`, string, number, boolean or an `undefined`.
```javascript
console.log(utils.isPrimitive(null));
// true
console.log(utils.isPrimitive('abc'));
// true
console.log(utils.isPrimitive([]));
// false
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#isprimitive)

##isObject
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; isObject(&#x2A;Any&#x2A; value)</code></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#isobject)

##isPlainObject
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; isPlainObject(&#x2A;Any&#x2A; value)</code></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#isplainobject)

##isArguments
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; isArguments(&#x2A;Any&#x2A; value)</code></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the given value is an arguments object.
```javascript
(function(){
  console.log(utils.isArguments(arguments))
  // true
})();
console.log(utils.isArguments({}))
// false
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#isarguments)

##merge
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; merge(&#x2A;NotPrimitive&#x2A; source, &#x2A;NotPrimitive&#x2A; object)</code></dd><dt>Parameters</dt><dd><ul><li>source — <i>NotPrimitive</i></li><li>object — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
Overrides the given source object properties by the given object own properties.
The source object is returned.
```javascript
var config = {a: 1, b: 2};
utils.merge(config, {b: 99, d: 100});
console.log(config);
// {a: 1, b: 99, d: 100}
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#merge)

##mergeAll
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; mergeAll(&#x2A;NotPrimitive&#x2A; source, &#x2A;NotPrimitive&#x2A; objects...)</code></dd><dt>Parameters</dt><dd><ul><li>source — <i>NotPrimitive</i></li><li>objects... — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
Like the utils.merge(), but the amount of objects to merge is unknown.
```javascript
var config = {a: 1};
utils.merge(config, {b: 2}, {c: 3});
console.log(config);
// {a: 1, b: 2, c: 3}
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#mergeall)

##mergeDeep
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; mergeDeep(&#x2A;NotPrimitive&#x2A; source, &#x2A;NotPrimitive&#x2A; object)</code></dd><dt>Parameters</dt><dd><ul><li>source — <i>NotPrimitive</i></li><li>object — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#mergedeep)

##fill
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; fill(&#x2A;NotPrimitive&#x2A; source, &#x2A;NotPrimitive&#x2A; object)</code></dd><dt>Parameters</dt><dd><ul><li>source — <i>NotPrimitive</i></li><li>object — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#fill)

##remove
<dl><dt>Syntax</dt><dd><code>remove(&#x2A;NotPrimitive&#x2A; object, &#x2A;Any&#x2A; element)</code></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>element — <i>Any</i></li></ul></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#remove)

##removeFromUnorderedArray
<dl><dt>Syntax</dt><dd><code>removeFromUnorderedArray(&#x2A;Array&#x2A; array, &#x2A;Any&#x2A; element)</code></dd><dt>Parameters</dt><dd><ul><li>array — <i>Array</i></li><li>element — <i>Any</i></li></ul></dd></dl>
Removes the given element from the given array.
Elements order may be changed.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#removefromunorderedarray)

##getPropertyDescriptor
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; getPropertyDescriptor(&#x2A;NotPrimitive&#x2A; object, &#x2A;String&#x2A; property)</code></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>property — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#getpropertydescriptor)

##lookupGetter
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; lookupGetter(&#x2A;NotPrimitive&#x2A; object, &#x2A;String&#x2A; property)</code></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>property — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
Returns the given property getter function defined in the given object.
```javascript
var object = {loaded: 2, length: 5};
utils.defineProperty(object, 'progress', null, function(){
  return this.loaded / this.length;
}, null);
console.log(utils.lookupGetter(object, 'progress'));
// function(){ return this.loaded / this.length; }
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#lookupgetter)

##lookupSetter
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; lookupSetter(&#x2A;NotPrimitive&#x2A; object, &#x2A;String&#x2A; property)</code></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>property — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
Returns the given property setter function defined in the given object.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#lookupsetter)

##defineProperty
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; defineProperty(&#x2A;NotPrimitive&#x2A; object, &#x2A;String&#x2A; property, &#x2A;Integer&#x2A; descriptors, [&#x2A;Any&#x2A; value, &#x2A;Function&#x2A; setter])</code></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>property — <i>String</i></li><li>descriptors — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li><li>value — <i>Any</i> — <i>optional</i></li><li>setter — <i>Function</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#defineproperty)

##overrideProperty
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; overrideProperty(&#x2A;NotPrimitive&#x2A; object, &#x2A;String&#x2A; property, [&#x2A;Any&#x2A; value, &#x2A;Function&#x2A; setter])</code></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>property — <i>String</i></li><li>value — <i>Any</i> — <i>optional</i></li><li>setter — <i>Function</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#overrideproperty)

##clone
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; clone(&#x2A;Any&#x2A; param)</code></dd><dt>Parameters</dt><dd><ul><li>param — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
Returns clone of the given array or object.
```javascript
console.log(utils.clone([1, 2]))
// [1, 2]
console.log(utils.clone({a: 1}))
// {a: 1}
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#clone)

##cloneDeep
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; cloneDeep(&#x2A;Any&#x2A; param)</code></dd><dt>Parameters</dt><dd><ul><li>param — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#clonedeep)

##isEmpty
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; isEmpty(&#x2A;String&#x2A;|&#x2A;NotPrimitive&#x2A; object)</code></dd><dt>Parameters</dt><dd><ul><li>| — <i>String</i></li><li>object — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#isempty)

##last
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; last(&#x2A;NotPrimitive&#x2A; array)</code></dd><dt>Parameters</dt><dd><ul><li>array — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
Returns the last element of the given array, or an array-like object.
```javascript
console.log(utils.last(['a', 'b']))
// b
console.log(utils.last([]))
// undefined
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#last)

##clear
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; clear(&#x2A;NotPrimitive&#x2A; object)</code></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li></ul></dd><dt>Returns</dt><dd><i>NotPrimitive</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#clear)

##setPrototypeOf
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; setPrototypeOf(&#x2A;NotPrimitive&#x2A; object, &#x2A;NotPrimitive&#x2A;|&#x2A;Null&#x2A; prototype)</code></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i></li><li>| — <i>NotPrimitive</i></li><li>prototype — <i>Null</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#setprototypeof)

##has
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; has(&#x2A;Any&#x2A; object, &#x2A;Any&#x2A; value)</code></dd><dt>Parameters</dt><dd><ul><li>object — <i>Any</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#has)

##objectToArray
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; objectToArray(&#x2A;Object&#x2A; object, [&#x2A;Function&#x2A; valueGen, &#x2A;Array&#x2A; target = `[]`])</code></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li><li>valueGen — <i>Function</i> — <i>optional</i></li><li>target — <i>Array</i> — <code>= []</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#objecttoarray)

##arrayToObject
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; arrayToObject(&#x2A;Array&#x2A; array, [&#x2A;Function&#x2A; keyGen, &#x2A;Function&#x2A; valueGen, &#x2A;Object&#x2A; target = `{}`])</code></dd><dt>Parameters</dt><dd><ul><li>array — <i>Array</i></li><li>keyGen — <i>Function</i> — <i>optional</i></li><li>valueGen — <i>Function</i> — <i>optional</i></li><li>target — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <code>= {}</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#arraytoobject)

##capitalize
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; capitalize(&#x2A;String&#x2A; string)</code></dd><dt>Parameters</dt><dd><ul><li>string — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
Capitalizes the given string.
```javascript
console.log(utils.capitalize('name'))
// Name
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#capitalize)

##addSlashes
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; addSlashes(&#x2A;String&#x2A; string)</code></dd><dt>Parameters</dt><dd><ul><li>string — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
Adds backslashes before each `'` and `"` characters found in the given string.
```javascript
console.log(utils.addSlashes('a"b'))
// a\"b
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#addslashes)

##uid
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; uid([&#x2A;Integer&#x2A; length = `8`])</code></dd><dt>Parameters</dt><dd><ul><li>length — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a> — <code>= 8</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
Returns pseudo-unique string with the given length.
This function doesn't quarantee uniqueness of the returned data.
```javascript
console.log(utils.uid())
// "50"
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#uid)

##tryFunction
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; tryFunction(&#x2A;Function&#x2A; function, [&#x2A;Any&#x2A; context, &#x2A;Array&#x2A; arguments, &#x2A;Any&#x2A; onFail])</code></dd><dt>Parameters</dt><dd><ul><li>function — <i>Function</i></li><li>context — <i>Any</i> — <i>optional</i></li><li>arguments — <i>Array</i> — <i>optional</i></li><li>onFail — <i>Any</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#tryfunction)

##catchError
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; catchError(&#x2A;Function&#x2A; function, [&#x2A;Any&#x2A; context, &#x2A;Array&#x2A; arguments])</code></dd><dt>Parameters</dt><dd><ul><li>function — <i>Function</i></li><li>context — <i>Any</i> — <i>optional</i></li><li>arguments — <i>Array</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#catcherror)

##bindFunctionContext
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; bindFunctionContext(&#x2A;Function&#x2A; function, &#x2A;Any&#x2A; context)</code></dd><dt>Parameters</dt><dd><ul><li>function — <i>Function</i></li><li>context — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#bindfunctioncontext)

##errorToObject
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; errorToObject(&#x2A;Error&#x2A; error)</code></dd><dt>Parameters</dt><dd><ul><li>error — <i>Error</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
Returns a plain object with the given error name, message and other custom properties.
Standard error `name` and `message` properties are not enumerable.
```javascript
var error = new ReferenceError('error message!');
console.log(utils.errorToObject(error));
// {name: 'ReferenceError', message: 'error message!'}
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#errortoobject)

##getOwnProperties
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; getOwnProperties(&#x2A;Object&#x2A; object)</code></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
Returns an array or an object with own properties associated in the given object.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#getownproperties)

##isEqual
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; isEqual(&#x2A;Object&#x2A; object1, &#x2A;Object&#x2A; object2, [&#x2A;Function&#x2A; compareFunction, &#x2A;Integer&#x2A; maxDeep = `Infinity`])</code></dd><dt>Parameters</dt><dd><ul><li>object1 — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li><li>object2 — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li><li>compareFunction — <i>Function</i> — <i>optional</i></li><li>maxDeep — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a> — <code>= Infinity</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/index.litcoffee#isequal)

## Glossary

 - [NOP](#nop)
 - [Float](#isfloat)
 - [Integer](#isinteger)
 - [Primitive](#isprimitive)
 - [Object](#isobject)
 - [PlainObject](#isplainobject)
 - [Arguments](#isarguments)
 - [utils.is()](#is)

