Validators: min
===============

Determine the minimum range from number.

*value* can be greater or equal maximum.

##### Example
```coffeescript
Schema = require 'schema'

schema = new Schema
	age:
		min: 0

schema.validate age: -5
# fail

schema.validate age: 20
# ok

schema.validate age: 0
# ok
```

	'use strict'

	module.exports = (row, value, expected) ->

		if typeof expected isnt 'number'
			throw new TypeError "Schema internal: max for #{row} row must be a number"

		if value < expected
			throw new RangeError "Schema: Minimum range of #{row} is #{expected}"