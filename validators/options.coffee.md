options
=======

Determine possible values for the *row*.

### Example
```
schema = new Schema
	city:
		options: ['Paris', 'Warsaw']

schema.validate city: 'Berlin'
# TypeError: Schema: city value is not provided

schema.validate city: 'Warsaw'
# true
```

This validator also accepts an object in place of array.

In such case, we check whether passed *row* value exists as an object key.

```
cities =
	Paris:
		country: 'France'
	Warsaw:
		country: 'Poland'

schema = new Schema
	city:
		options: cities

schema.validate city: 'Moscow'
# TypeError: Schema: city value is not provided

schema.validate city: 'Paris'
# true
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