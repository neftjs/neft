> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Properties extraction**

# Properties extraction

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/namespace.litcoffee#properties-extraction)

## Table of contents
* [Properties extraction](#properties-extraction)
  * [get](#get)
  * [**Class** utils.get.OptionsArray()](#class-utilsgetoptionsarray)
  * [isStringArray](#isstringarray)

##get
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; get(&#x2A;Object&#x2A; object, &#x2A;String&#x2A; path, [&#x2A;OptionsArray&#x2A; target])</code></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li><li>path — <i>String</i></li><li>target — <i>OptionsArray</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
Extracts property, deep property or an array of possible properties from the given object.

```javascript
var obj = {prop: 1};
console.log(utils.get(obj, 'prop'));
// 1

var obj = {prop: {deep: 1}};
console.log(utils.get(obj, 'prop.deep'));
// 1

var obj = {prop: [{deep: 1}, {deep: 2}]};
console.log(utils.get(obj, 'prop[].deep'));
// [1, 2]
// 'utils.get.OptionsArray' instance ...

var obj = {prop: [{deep: 1}, {deep: 2}]};
console.log(utils.get(obj, 'prop[]'));
// [{deep: 1}, {deep: 2}]
// 'utils.get.OptionsArray' instance ...

var obj = {prop: [{deep: {}}, {deep: {result: 1}}]};
console.log(utils.get(obj, 'prop[].deep.result'));
// [1]
// 'utils.get.OptionsArray' instance ...
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/namespace.litcoffee#get)

## **Class** utils.get.OptionsArray()

Special version of an Array, returned if the result of the utils.get()
function is a list of the possible values.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/namespace.litcoffee#class-utilsgetoptionsarray)

##isStringArray
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; isStringArray(&#x2A;String&#x2A; value)</code></dd><dt>Parameters</dt><dd><ul><li>value — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Checks whether the given string references into an array according
to the notation in the utils.get() function.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/namespace.litcoffee#isstringarray)

