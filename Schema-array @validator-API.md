array @validator
================

Determines whether the tested value is an array.

```javascript
var schema = new Schema({
  friends: {
  }
});

console.log(utils.catchError(schema.validate, schema, [{friends: {}}])+'');
// "SchemaError: friends must be an array"

console.log(schema.validate({friends: []}));
// true
```

