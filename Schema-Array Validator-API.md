> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Array Validator**

# Array Validator

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

> [`Source`](/Neft-io/neft/tree/master/src/schema/validators/array.litcoffee#array-validator)

