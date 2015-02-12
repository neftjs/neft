re
==

Using this validator you can check whether *value* passed regular expression.

```
var schema = new Schema({
  word: {
    re: ///^\S+$///
  }
});

log(schema.validate({word: ''});
// TypeError: Schema: word doesn't passed regular expression

log(schema.validate({word: 'a b'});
// TypeError: Schema: word doesn't passed regular expression

log(schema.validate({word: 'abc'});
// true
```

	'use strict'

	module.exports = (row, value, expected) ->

		if expected.constructor isnt RegExp
			throw new TypeError "Schema internal: re for #{row} row must be a regular expression"

		unless expected.test value
			throw new TypeError "Schema: #{row} doesn't passed regular expression"