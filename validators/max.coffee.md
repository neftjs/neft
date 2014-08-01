Validators: max
===============

Determine the maximum range from number.

*value* can be lower or equal maximum.

##### Example
```coffeescript
Schema = require 'schema'

schema = new Schema
	age:
		max: 200

schema.validate age: 201
# fail

schema.validate age: 200
# ok

schema.validate age: -5
# ok
```

	'use strict'

	module.exports = (row, value, expected) ->

		if typeof expected isnt 'number'
			throw new TypeError "Schema internal: max for #{row} row must be a number"

		if value > expected
			throw new RangeError "Schema: Maximum range of #{row} is #{expected}"