Validators: function
====================

Use this validator to check whether passed function can be properly called.

##### Example
```coffeescript
Schema = require 'schema'

schema = new Schema
	calculate:
		function: true

schema.validate calculate: -> throw new Error
# fail

schema.validate calculate: -> someUnknownProperty.a = 2
# fail

schema.validate calculate: (a, b) -> a + b
# ok
```

	'use strict'

	module.exports = (row, value, expected) ->

		try

			func = new Function value

			eval func

		catch err

			throw new TypeError "Schema: #{row} must be a proper function body"