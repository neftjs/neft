Validators: array
=================

When `type` validator returns `object` for array (as standard *typeof* operator),
this validator is used to determine whether *value* is a truly array (must extends *Array* prototype).

Remember that `arguments` and many other array-like objects in *JavaScript* are not truly arrays!

##### Example
```coffeescript
Schema = require 'schema'

schema = new Schema
	friends:
		array: true

schema.validate friends: {}
# fail

schema.validate friends: []
# ok

schema.validate {}
# ok, bacuse `friends` are not required
```

	'use strict'

	isArray = Array.isArray

	module.exports = (row, value, expected) ->

		unless isArray value
			throw new TypeError "Schema: #{row} must be an array"