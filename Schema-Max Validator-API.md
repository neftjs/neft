> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Schema|Schema-API]] ▸ **Max Validator**

# Max Validator

Determines the maximum range of the number.

The tested value can be lower or equal maximum.

```javascript
var schema = new Schema({
  age: {
    max: 200
  }
});

console.log(utils.catchError(schema.validate, schema, [{age: 201}])+'');
// "SchemaError: Maximum range of age is 200"

console.log(schema.validate({age: 'string'}));
// true

console.log(schema.validate({age: 200}));
// true

console.log(schema.validate({age: -5}));
// true
```

> [`Source`](/Neft-io/neft/blob/2aaed99455b1ed473d23e1aec13cd859d63d5b3b/src/schema/validators/max.litcoffee#max-validator)

