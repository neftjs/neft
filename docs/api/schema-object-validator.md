# Object Validator

> **API Reference** ▸ [Schema](/api/schema.md) ▸ **Object Validator**

<!-- toc -->
Determines whether the tested value is an object.

The [utils.isObject()][utils/utils.isObject()] is used internally.

```javascript
var schema = new Schema({
  dict: {
    object: true
  }
});

console.log(utils.catchError(schema.validate, schema, [{dict: 'text'}])+'');
// "SchemaError: dict must be an object"

console.log(utils.catchError(schema.validate, schema, [{dict: null}])+'');
// "SchemaError: Required property dict not found"

console.log(schema.validate({dict: {}}));
// true
```

This validator accepts the properties array used to describe the allowed properties.

```javascript
var schema = new Schema({
  dict: {
    object: {
      properties: ['name', 'age']
    }
  }
});

console.log(utils.catchError(schema.validate, schema, [{dict: { address: 'abc' }}])+'');
// "SchemaError: dict doesn't provide address property"

console.log(schema.validate({dict: { name: 'John' }}));
// true
```


> [`Source`](https://github.com/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/schema/validators/object.litcoffee)

