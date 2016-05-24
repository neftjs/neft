> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Schema|Schema-API]] ▸ **Optional Validator**

# Optional Validator

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

> [`Source`](/Neft-io/neft/blob/2aaed99455b1ed473d23e1aec13cd859d63d5b3b/src/schema/validators/optional.litcoffee#optional-validator)

