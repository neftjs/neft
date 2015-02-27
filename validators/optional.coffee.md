optional
========

Use this validator to mark property as optional.

*undefined* and *null* values are omitted.

```
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

	module.exports = (Schema) -> ->