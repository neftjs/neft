> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Utils**

# Utils

Access it with:
```javascript
const { utils } = Neft;
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee)

## Nested APIs

* [[Asynchronous|Utils-Asynchronous-API]]
* [[Properties extraction|Utils-Properties extraction-API]]
* [[Stringifying|Utils-Stringifying-API]]

## Table of contents
* [Utils](#utils)
  * [isNode](#isnode)
  * [isServer](#isserver)
  * [isClient](#isclient)
  * [isBrowser](#isbrowser)
  * [isQt](#isqt)
  * [isAndroid](#isandroid)
  * [isIOS](#isios)
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
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; utils.isNode</code></dd><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
`true` if the application is running in the node.js environment.

##isServer
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; utils.isServer</code></dd><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
`utils.isNode` link.

##isClient
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; utils.isClient</code></dd><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
`utils.isNode` inverse.

##isBrowser
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; utils.isBrowser</code></dd><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
##isQt
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; utils.isQt</code></dd><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
##isAndroid
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; utils.isAndroid</code></dd><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
##isIOS
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; utils.isIOS</code></dd><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#readonly-boolean-utilsisios)

##NOP
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; utils.NOP</code></dd><dt>Static property of</dt><dd><i>utils</i></dd><dt>Type</dt><dd><i>Function</i></dd></dl>
No operation (an empty function).

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#function-utilsnop)

##is
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; utils.is(&#x2A;Any&#x2A; value1, &#x2A;Any&#x2A; value2)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>value2 — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#boolean-utilsisany-value1-any-value2)

##isFloat
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; utils.isFloat(&#x2A;Any&#x2A; value)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#boolean-utilsisfloatany-value)

##isInteger
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; utils.isInteger(&#x2A;Any&#x2A; value)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#boolean-utilsisintegerany-value)

##isPrimitive
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; utils.isPrimitive(&#x2A;Any&#x2A; value)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the given value is a `null`, string, number, boolean or an `undefined`.

```javascript
console.log(utils.isPrimitive(null));
// true

console.log(utils.isPrimitive('abc'));
// true

console.log(utils.isPrimitive([]));
// false
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#boolean-utilsisprimitiveany-value)

##isObject
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; utils.isObject(&#x2A;Any&#x2A; value)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#boolean-utilsisobjectany-value)

##isPlainObject
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; utils.isPlainObject(&#x2A;Any&#x2A; value)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#boolean-utilsisplainobjectany-value)

##isArguments
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; utils.isArguments(&#x2A;Any&#x2A; value)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the given value is an arguments object.

```javascript
(function(){
  console.log(utils.isArguments(arguments))
  // true
})();

console.log(utils.isArguments({}))
// false
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#boolean-utilsisargumentsany-value)

##merge
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; utils.merge(&#x2A;NotPrimitive&#x2A; source, &#x2A;NotPrimitive&#x2A; object)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>source — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></dd></dl>
Overrides the given source object properties by the given object own properties.

The source object is returned.

```javascript
var config = {a: 1, b: 2};
utils.merge(config, {b: 99, d: 100});
console.log(config);
// {a: 1, b: 99, d: 100}
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#notprimitive-utilsmergenotprimitive-source-notprimitive-object)

##mergeAll
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; utils.mergeAll(&#x2A;NotPrimitive&#x2A; source, &#x2A;NotPrimitive&#x2A; objects...)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>source — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li><li>objects... — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></dd></dl>
Like the utils.merge(), but the amount of objects to merge is unknown.

```javascript
var config = {a: 1};
utils.merge(config, {b: 2}, {c: 3});
console.log(config);
// {a: 1, b: 2, c: 3}
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#notprimitive-utilsmergeallnotprimitive-source-notprimitive-objects)

##mergeDeep
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; utils.mergeDeep(&#x2A;NotPrimitive&#x2A; source, &#x2A;NotPrimitive&#x2A; object)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>source — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#notprimitive-utilsmergedeepnotprimitive-source-notprimitive-object)

##fill
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; utils.fill(&#x2A;NotPrimitive&#x2A; source, &#x2A;NotPrimitive&#x2A; object)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>source — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#notprimitive-utilsfillnotprimitive-source-notprimitive-object)

##remove
<dl><dt>Syntax</dt><dd><code>utils.remove(&#x2A;NotPrimitive&#x2A; object, &#x2A;Any&#x2A; element)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li><li>element — <i>Any</i></li></ul></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#utilsremovenotprimitive-object-any-element)

##removeFromUnorderedArray
<dl><dt>Syntax</dt><dd><code>utils.removeFromUnorderedArray(&#x2A;Array&#x2A; array, &#x2A;Any&#x2A; element)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>array — <i>Array</i></li><li>element — <i>Any</i></li></ul></dd></dl>
Removes the given element from the given array.

Elements order may be changed.

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#utilsremovefromunorderedarrayarray-array-any-element)

##getPropertyDescriptor
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; utils.getPropertyDescriptor(&#x2A;NotPrimitive&#x2A; object, &#x2A;String&#x2A; property)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li><li>property — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#object-utilsgetpropertydescriptornotprimitive-object-string-property)

##lookupGetter
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; utils.lookupGetter(&#x2A;NotPrimitive&#x2A; object, &#x2A;String&#x2A; property)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li><li>property — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
Returns the given property getter function defined in the given object.

```javascript
var object = {loaded: 2, length: 5};
utils.defineProperty(object, 'progress', null, function(){
  return this.loaded / this.length;
}, null);
console.log(utils.lookupGetter(object, 'progress'));
// function(){ return this.loaded / this.length; }
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#function-utilslookupgetternotprimitive-object-string-property)

##lookupSetter
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; utils.lookupSetter(&#x2A;NotPrimitive&#x2A; object, &#x2A;String&#x2A; property)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li><li>property — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
Returns the given property setter function defined in the given object.

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#function-utilslookupsetternotprimitive-object-string-property)

##defineProperty
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; utils.defineProperty(&#x2A;NotPrimitive&#x2A; object, &#x2A;String&#x2A; property, &#x2A;Integer&#x2A; descriptors, [&#x2A;Any&#x2A; value, &#x2A;Function&#x2A; setter])</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li><li>property — <i>String</i></li><li>descriptors — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li><li>value — <i>Any</i> — <i>optional</i></li><li>setter — <i>Function</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#notprimitive-utilsdefinepropertynotprimitive-object-string-property-integer-descriptors-any-value-function-setter)

##overrideProperty
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; utils.overrideProperty(&#x2A;NotPrimitive&#x2A; object, &#x2A;String&#x2A; property, [&#x2A;Any&#x2A; value, &#x2A;Function&#x2A; setter])</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li><li>property — <i>String</i></li><li>value — <i>Any</i> — <i>optional</i></li><li>setter — <i>Function</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#notprimitive-utilsoverridepropertynotprimitive-object-string-property-any-value-function-setter)

##clone
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; utils.clone(&#x2A;Any&#x2A; param)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>param — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
Returns clone of the given array or object.

```javascript
console.log(utils.clone([1, 2]))
// [1, 2]

console.log(utils.clone({a: 1}))
// {a: 1}
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#any-utilscloneany-param)

##cloneDeep
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; utils.cloneDeep(&#x2A;Any&#x2A; param)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>param — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#any-utilsclonedeepany-param)

##isEmpty
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; utils.isEmpty(&#x2A;String&#x2A;|&#x2A;NotPrimitive&#x2A; object)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a> or <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#boolean-utilsisemptystringnotprimitive-object)

##last
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; utils.last(&#x2A;NotPrimitive&#x2A; array)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>array — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
Returns the last element of the given array, or an array-like object.

```javascript
console.log(utils.last(['a', 'b']))
// b

console.log(utils.last([]))
// undefined
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#any-utilslastnotprimitive-array)

##clear
<dl><dt>Syntax</dt><dd><code>&#x2A;NotPrimitive&#x2A; utils.clear(&#x2A;NotPrimitive&#x2A; object)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#notprimitive-utilsclearnotprimitive-object)

##setPrototypeOf
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; utils.setPrototypeOf(&#x2A;NotPrimitive&#x2A; object, &#x2A;NotPrimitive&#x2A;|&#x2A;Null&#x2A; prototype)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li><li>prototype — <i>Null</i> or <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#object-utilssetprototypeofnotprimitive-object-notprimitivenull-prototype)

##has
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; utils.has(&#x2A;Any&#x2A; object, &#x2A;Any&#x2A; value)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Any</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#boolean-utilshasany-object-any-value)

##objectToArray
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; utils.objectToArray(&#x2A;Object&#x2A; object, [&#x2A;Function&#x2A; valueGen, &#x2A;Array&#x2A; target = `[]`])</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li><li>valueGen — <i>Function</i> — <i>optional</i></li><li>target — <i>Array</i> — <code>= []</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#array-utilsobjecttoarrayobject-object-function-valuegen-array-target--)

##arrayToObject
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; utils.arrayToObject(&#x2A;Array&#x2A; array, [&#x2A;Function&#x2A; keyGen, &#x2A;Function&#x2A; valueGen, &#x2A;Object&#x2A; target = `{}`])</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>array — <i>Array</i></li><li>keyGen — <i>Function</i> — <i>optional</i></li><li>valueGen — <i>Function</i> — <i>optional</i></li><li>target — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <code>= {}</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#object-utilsarraytoobjectarray-array-function-keygen-function-valuegen-object-target--)

##capitalize
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; utils.capitalize(&#x2A;String&#x2A; string)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>string — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
Capitalizes the given string.

```javascript
console.log(utils.capitalize('name'))
// Name
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#string-utilscapitalizestring-string)

##addSlashes
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; utils.addSlashes(&#x2A;String&#x2A; string)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>string — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
Adds backslashes before each `'` and `"` characters found in the given string.

```javascript
console.log(utils.addSlashes('a"b'))
// a\"b
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#string-utilsaddslashesstring-string)

##uid
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; utils.uid([&#x2A;Integer&#x2A; length = `8`])</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>length — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a> — <code>= 8</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
Returns pseudo-unique string with the given length.

This function doesn't quarantee uniqueness of the returned data.

```javascript
console.log(utils.uid())
// "50"
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#string-utilsuidinteger-length--8)

##tryFunction
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; utils.tryFunction(&#x2A;Function&#x2A; function, [&#x2A;Any&#x2A; context, &#x2A;Array&#x2A; arguments, &#x2A;Any&#x2A; onFail])</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>function — <i>Function</i></li><li>context — <i>Any</i> — <i>optional</i></li><li>arguments — <i>Array</i> — <i>optional</i></li><li>onFail — <i>Any</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#any-utilstryfunctionfunction-function-any-context-array-arguments-any-onfail)

##catchError
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; utils.catchError(&#x2A;Function&#x2A; function, [&#x2A;Any&#x2A; context, &#x2A;Array&#x2A; arguments])</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>function — <i>Function</i></li><li>context — <i>Any</i> — <i>optional</i></li><li>arguments — <i>Array</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#any-utilscatcherrorfunction-function-any-context-array-arguments)

##bindFunctionContext
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; utils.bindFunctionContext(&#x2A;Function&#x2A; function, &#x2A;Any&#x2A; context)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>function — <i>Function</i></li><li>context — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#function-utilsbindfunctioncontextfunction-function-any-context)

##errorToObject
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; utils.errorToObject(&#x2A;Error&#x2A; error)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>error — <i>Error</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
Returns a plain object with the given error name, message and other custom properties.

Standard error `name` and `message` properties are not enumerable.

```javascript
var error = new ReferenceError('error message!');
console.log(utils.errorToObject(error));
// {name: 'ReferenceError', message: 'error message!'}
```

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#object-utilserrortoobjecterror-error)

##getOwnProperties
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; utils.getOwnProperties(&#x2A;Object&#x2A; object)</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
Returns an array or an object with own properties associated in the given object.

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#object-utilsgetownpropertiesobject-object)

##isEqual
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; utils.isEqual(&#x2A;Object&#x2A; object1, &#x2A;Object&#x2A; object2, [&#x2A;Function&#x2A; compareFunction, &#x2A;Integer&#x2A; maxDeep = `Infinity`])</code></dd><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object1 — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li><li>object2 — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li><li>compareFunction — <i>Function</i> — <i>optional</i></li><li>maxDeep — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a> — <code>= Infinity</code> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/00d48f19a9b22932ace5d660101e9fa2b6991fb9/src/utils/index.litcoffee#boolean-utilsisequalobject-object1-object-object2-function-comparefunction-integer-maxdeep--infinity)

# Glossary

 - [NOP](#nop)
 - [Float](#isfloat)
 - [Integer](#isinteger)
 - [Primitive](#isprimitive)
 - [NotPrimitive](#isprimitive)
 - [Object](#isobject)
 - [PlainObject](#isplainobject)
 - [Arguments](#isarguments)
 - [utils.is()](#is)
