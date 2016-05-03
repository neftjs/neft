regexp @validator
=================

Checks whether the tested value passed the given regular expression.

```javascript
var schema = new Schema({
  word: {
  }
});

console.log(utils.catchError(schema.validate, schema, [{word: ''}])+'');
// "SchemaError: word doesn't pass the regular expression"

console.log(utils.catchError(schema.validate, schema, [{word: 'a b'}])+'');
// "SchemaError: word doesn't pass the regular expression"

console.log(schema.validate({word: 'abc'}));
// true
```

