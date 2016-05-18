> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **RegExp Validator**

# RegExp Validator

Checks whether the tested value passed the given regular expression.
```javascript
var schema = new Schema({
  word: {
    regexp: /^\S+$/
  }
});
console.log(utils.catchError(schema.validate, schema, [{word: ''}])+'');
// "SchemaError: word doesn't pass the regular expression"
console.log(utils.catchError(schema.validate, schema, [{word: 'a b'}])+'');
// "SchemaError: word doesn't pass the regular expression"
console.log(schema.validate({word: 'abc'}));
// true
```

> [`Source`](/Neft-io/neft/tree/master/src/schema/validators/regexp.litcoffee#regexp-validator)

