min
===

Determines the minimum range from number.

*value* can be greater or equal maximum.

### Example
```
schema = new Schema
	age:
		min: 0

schema.validate age: -5
# RangeError: Schema: Minimum range of age is 0

schema.validate age: 'string'
# RangeError: Schema internal: max for age row must be a number

schema.validate age: 20
# true

schema.validate age: 0
# true
```

	'use strict'

	module.exports = (row, value, expected) ->
		if typeof expected isnt 'number'
			throw new TypeError "Schema internal: max for #{row} row must be a number"

		if typeof value is 'number' and value < expected
			throw new RangeError "Schema: Minimum range of #{row} is #{expected}"