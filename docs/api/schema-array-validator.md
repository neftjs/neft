# Array Validator

> **API Reference** ▸ [Schema](/api/schema.md) ▸ **Array Validator**

<!-- toc -->
Determines whether the tested value is an array.

```javascript
var schema = new Schema({
  friends: {
    array: true
  }
});

console.log(utils.catchError(schema.validate, schema, [{friends: {}}])+'');
// "SchemaError: friends must be an array"

console.log(schema.validate({friends: []}));
// true
```


> [`Source`](https:/github.com/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/schema/validators/array.litcoffee)

