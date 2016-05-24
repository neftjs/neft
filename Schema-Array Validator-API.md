> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Schema|Schema-API]] ▸ **Array Validator**

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

> [`Source`](/Neft-io/neft/blob/2aaed99455b1ed473d23e1aec13cd859d63d5b3b/src/schema/validators/array.litcoffee#array-validator)

