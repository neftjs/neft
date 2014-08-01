Validators: re
==============

Using this validator you can check whether *value* passed regular expression.

##### Example
```coffeescript
Schema = new 'schema'

schema = new Schema
	word:
		re: ///^\S+$///

schema.validate word: ''
# fail

schema.validate word: 'a b'
# fail

schema.validate word: 'abc'
# ok
```

	'use strict'

	module.exports = (row, value, expected) ->

		if expected.constructor isnt RegExp
			throw new TypeError "Schema internal: re for #{row} row must be a regular expression"

		unless expected.test value
			throw new TypeError "Schema: #{row} doesn't passed regular expression"