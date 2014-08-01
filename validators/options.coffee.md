Validators: options
===================

Determine possible values for the *row*.

##### Example
```coffeescript
Schema = require 'schema'

schema = new Schema
	city:
		options: ['Paris', 'Warsaw']

schema.validate city: 'Berlin'
# fail; `Schema: city value is not provided`

schema.validate city: 'Warsaw'
# ok
```

This validator also accepts an object in place of array.

In such case, we check whether passed *row* value exists as object key.

##### Example
```coffeescript
Schema = require 'schema'

cities =
	Paris:
		country: 'France'
	Warsaw:
		country: 'Poland'

schema = new Schema
	city:
		options: cities

schema.validate city: 'Moscow'
# fail

schema.validate city: 'Paris'
# ok
```

	'use strict'

	isArray = Array.isArray
	objKeys = Object.keys

	module.exports = (row, value, expected) ->

		if typeof expected isnt 'object'
			throw new TypeError "Schema internal: options for #{row} row must be an object or array"

		if isArray expected
			passed = ~ expected.indexOf value
		else
			passed = ~ objKeys(expected).indexOf value + ''

		unless passed
			throw new TypeError "Schema: #{row} value is not provided"