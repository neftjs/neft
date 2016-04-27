regexp @validator
=================

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

	'use strict'

	assert = require 'neft-assert'

	module.exports = (Schema) -> (row, value, expected) ->
		assert expected instanceof RegExp
		, "regexp validator option for the #{row} property must be a regular expression"

		unless expected.test value
			throw new Schema.Error row, 'regexp', "#{row} doesn't pass the regular expression"
