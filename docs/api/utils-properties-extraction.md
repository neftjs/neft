# Properties extraction

> **API Reference** ▸ [Utils](/api/utils.md) ▸ **Properties extraction**

<!-- toc -->

> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/utils/namespace.litcoffee)


* * * 

### `utils.get()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Object</i></li><li>path — <i>String</i></li><li>target — <i>OptionsArray</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/utils/namespace.litcoffee#any-utilsgetobject-object-string-path-optionsarray-target)

## **Class** utils.get.OptionsArray()

Special version of an Array, returned if the result of the utils.get()
function is a list of the possible values.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/utils/namespace.litcoffee)


* * * 

### `utils.isStringArray()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

Checks whether the given string references into an array according
to the notation in the utils.get() function.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/utils/namespace.litcoffee#boolean-utilsisstringarraystring-value)

