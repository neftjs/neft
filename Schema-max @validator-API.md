max @validator
==============

Determines the maximum range of the number.

The tested value can be lower or equal maximum.

```javascript
var schema = new Schema({
  age: {
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

