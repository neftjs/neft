> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Schema|Schema-API]] ▸ **RegExp Validator**

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

> [`Source`](/Neft-io/neft/blob/2aaed99455b1ed473d23e1aec13cd859d63d5b3b/src/schema/validators/regexp.litcoffee#regexp-validator)

