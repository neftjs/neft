# Min Validator

> **API Reference** ▸ [Schema](/api/schema.md) ▸ **Min Validator**

<!-- toc -->
Determines the minimum range on the number.

The tested value can be greater or equal maximum.

```javascript
var schema = new Schema({
  age: {
    min: 0
  }
});

console.log(utils.catchError(schema.validate, schema, [{age: -5}])+'');
// "SchemaError: Minimum range of age is 0"

console.log(schema.validate({age: 'string'}));
// true

console.log(schema.validate({age: 20}));
// true

console.log(schema.validate({age: 0}));
// true
```


> [`Source`](https://github.com/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/schema/validators/min.litcoffee)

