> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Min Validator**

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

> [`Source`](/Neft-io/neft/tree/master/src/schema/validators/min.litcoffee#min-validator)

