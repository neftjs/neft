> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Type Validator**

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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/schema/validators/type.litcoffee#type-validator)

