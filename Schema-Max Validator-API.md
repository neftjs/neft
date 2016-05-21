> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Max Validator**

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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/schema/validators/max.litcoffee#max-validator)

