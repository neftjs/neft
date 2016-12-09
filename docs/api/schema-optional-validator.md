# Optional Validator

> **API Reference** ▸ [Schema](/api/schema.md) ▸ **Optional Validator**

<!-- toc -->
Marks the property as optional.

An `undefined` and a `null` values are omitted.

```javascript
var schema = new Schema({
  name: {
    optional: true,
    type: 'string'
  },
  text: {
    type: 'string'
  }
});

console.log(schema.validate({name: 'Max', text: 'Hello!'}));
// true

console.log(schema.validate({text: 'Hello!'}));
// true

console.log(utils.catchError(schema.validate, schema, [{name: 'Max'}])+'');
// "SchemaError: Required property text not found"
```


> [`Source`](https://github.com/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/schema/validators/optional.litcoffee)

