Validators: required
====================

Use this validator to point *rows* which have to be defined.

Passed *row* must exists in the object and can't be `undefined` or `null`.

##### Example
```coffeescript
Schema = require 'schema'

schema = new Schema
	name:
		required: true

schema.validate name: 1
# ok

schema.validate name: null
# fail

schema.validate age: 2
# fail
```

	'use strict'

	module.exports = (row, value, expected) ->

		unless value?
			throw new TypeError "Schema: #{row} is required"