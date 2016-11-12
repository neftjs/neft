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

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/schema/validators/max.litcoffee)

