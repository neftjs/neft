# RegExp Validator

> **API Reference** ▸ [Schema](/api/schema.md) ▸ **RegExp Validator**

<!-- toc -->
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


> [`Source`](https://github.com/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/schema/validators/regexp.litcoffee)

