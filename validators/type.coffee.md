type
====

This valdiator uses standard *typeof* expression to check whether *value* type is equal required.

#### NaN and null

Unlike standard `typeof`, this validator returns `undefined` for `NaN` and `null`.

```
schema = new Schema
	desc:
		type: 'object'

schema.validate desc: 231
# TypeError: Schema: desc must be a object

schema.validate desc: null
# TypeError: Schema: desc must be a object

schema.validate desc: {}
# true

schema.validate desc: []
# true
# because in js `typeof []` is `object` ...
```

	'use strict'

	module.exports = (row, value, expected) ->
		if typeof expected isnt 'string'
			throw new TypeError "Schema internal: type for #{row} row must be a string"

		if isNaN(value) or value is null
			value = undefined

		if value? and typeof value isnt expected
			throw new TypeError "Schema: #{row} must be a #{expected}"