> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Schema|Schema-API]] ▸ **Min Validator**

# Min Validator

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

> [`Source`](/Neft-io/neft/blob/2aaed99455b1ed473d23e1aec13cd859d63d5b3b/src/schema/validators/min.litcoffee#min-validator)

