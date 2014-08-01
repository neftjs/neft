Validators: type
================

This valdiator uses standard *typeof* expression to check whether *value* type is equal required.

##### Important

Unlike standard `typeof` behaviour, this validator returns `undefined` for `NaN` and `null`.

##### Example
```coffeescript
Schema = require 'schema'

schema = new Schema
	desc:
		type: 'object'

schema.validate desc: 231
# fail

schema.validate desc: null
# fail

schema.validate desc: {}
# ok

schema.validate desc: []
# ok; because in js `typeof [] === 'object'` is true
```

	'use strict'

	module.exports = (row, value, expected) ->

		if typeof expected isnt 'string'
			throw new TypeError "Schema internal: type for #{row} row must be a string"

		if value is NaN or value is null
			value = undefined

		if value? and typeof value isnt expected
			throw new TypeError "Schema: #{row} must be a #{expected}"