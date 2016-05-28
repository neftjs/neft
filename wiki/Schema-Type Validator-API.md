> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Schema|Schema-API]] ▸ **Type Validator**

# Type Validator

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

> [`Source`](/Neft-io/neft/blob/2aaed99455b1ed473d23e1aec13cd859d63d5b3b/src/schema/validators/type.litcoffee#type-validator)

