> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Properties extraction**

Properties extraction
=====================

> [`Source`](/Neft-io/neft/tree/master/src/utils/namespace.litcoffee#properties-extraction)

## Table of contents
  * [utils.get(object, path, [target])](#any-utilsgetobject-object-string-path-optionsarray-target)
  * [utils.get.OptionsArray()](#optionsarray-utilsgetoptionsarray)
  * [utils.isStringArray(value)](#boolean-utilsisstringarraystring-value)

*Any* utils.get(*Object* object, *String* path, [*OptionsArray* target])
------------------------------------------------------------------------

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

> [`Source`](/Neft-io/neft/tree/master/src/utils/namespace.litcoffee#any-utilsgetobject-object-string-path-optionsarray-target)

*OptionsArray* utils.get.OptionsArray()
---------------------------------------

Special version of an Array, returned if the result of the utils.get()
function is a list of the possible values.

> [`Source`](/Neft-io/neft/tree/master/src/utils/namespace.litcoffee#optionsarray-utilsgetoptionsarray)

*Boolean* utils.isStringArray(*String* value)
---------------------------------------------

Checks whether the given string references into an array according
to the notation in the utils.get() function.

> [`Source`](/Neft-io/neft/tree/master/src/utils/namespace.litcoffee#boolean-utilsisstringarraystring-value)

