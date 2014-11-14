array
=====

When `type` validator returns `object` for an array (as standard *typeof* operator),
this validator is used to determine whether *value* is a truly array instance.

Remember that `arguments` and many other array-like objects in *JavaScript* are not an arrays!

### Example
```
schema = new Schema
	friends:
		array: true

schema.validate friends: {}
# TypeError: Schema: friends must be an array

schema.validate friends: []
# true

schema.validate {}
# true
# bacuse `friends` is not required ...
```

	'use strict'

	{isArray} = Array

	module.exports = (row, value, expected) ->
		unless isArray value
			throw new TypeError "Schema: #{row} must be an array"