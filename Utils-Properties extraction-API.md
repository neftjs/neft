> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Properties extraction**

# Properties extraction

> [`Source`](/Neft-io/neft/tree/master/src/utils/namespace.litcoffee#properties-extraction)

## Table of contents
  * [get](#get)
  * [**Class** utils.get.OptionsArray()](#class-utilsgetoptionsarray)
  * [isStringArray](#isstringarray)

##get
<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>Object</i></li><li><b>path</b> — <i>String</i></li><li><b>target</b> — <i>OptionsArray</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/namespace.litcoffee#any-getobject-object-string-path-optionsarray-target)

## **Class** utils.get.OptionsArray()

Special version of an Array, returned if the result of the utils.get()
function is a list of the possible values.

> [`Source`](/Neft-io/neft/tree/master/src/utils/namespace.litcoffee#class-utilsgetoptionsarray)

##isStringArray
<dl><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Checks whether the given string references into an array according
to the notation in the utils.get() function.

> [`Source`](/Neft-io/neft/tree/master/src/utils/namespace.litcoffee#boolean-isstringarraystring-value)

