optional @validator
===================

Marks the property as optional.

An `undefined` and a `null` values are omitted.

```javascript
var schema = new Schema({
  name: {
  },
  text: {
  }
});

console.log(schema.validate({name: 'Max', text: 'Hello!'}));
// true

console.log(schema.validate({text: 'Hello!'}));
// true

console.log(utils.catchError(schema.validate, schema, [{name: 'Max'}])+'');
// "SchemaError: Required property text not found"
```

