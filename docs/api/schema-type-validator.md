# Type Validator

> **API Reference** ▸ [Schema](/api/schema.md) ▸ **Type Validator**

<!-- toc -->
Verifies the tested value type using the `typeof`.

```javascript
var schema = new Schema({
  desc: {
    type: 'object'
  }
});

console.log(utils.catchError(schema.validate, schema, [{desc: 231}])+'');
// "SchemaError: desc must be a object"

console.log(schema.validate({desc: {}}));
// true

console.log(schema.validate({desc: []}));
// true
// because in js `typeof []` is `object` ...
// you should use array validator instead ...
```


> [`Source`](https://github.com/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/schema/validators/type.litcoffee)

