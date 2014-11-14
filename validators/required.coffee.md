required
========

Use this validator to point *rows* which have to be defined.

Passed *row* must exists in the object and can't be `undefined` nor `null`.

### Example
```
schema = new Schema
	name:
		required: true

schema.validate name: 1
# true

schema.validate name: null
# TypeError: Schema: name is required

schema.validate age: 2
# TypeError: Schema: name is required
```

	'use strict'

	module.exports = (row, value, expected) ->

		unless value?
			throw new TypeError "Schema: #{row} is required"