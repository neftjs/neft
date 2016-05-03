type @validator
===============

Verifies the tested value type using the `typeof`.

```javascript
var schema = new Schema({
  desc: {
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

