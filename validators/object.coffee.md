Validators: object
==================

When `type` validator returns `object` for arrays, objects and `null` (as standard *typeof* operator),
this validator is used to determine whether passed *value* is a simple object.

*Simple object* can't extends any custom prototypes.
You can write more about *simple objects* in [utils][module_utils] module.

##### Example
```coffeescript
Schema = require 'schema'

schema = new Schema
	dict:
		object: true

schema.validate dict: []
# fail

schema.validate dict: null
# fail

schema.validate dict: Object.create({a: 1})
# fail

schema.validate dict: {}
# ok
```

This validator accepts `properties` array which determine allowed properties.

##### Example
```coffeescript
Schema = require 'schema'

schema = new Schema
	dict:
		object:
			properties: ['name', 'age']

schema.validate dict: { address: 'abc' }
# fail; `TypeError: Schema: dict doesn't provide address property`

schema.validate dict: { name: 'John' }
# ok
```

	'use strict'

	utils = require 'utils'

	isArray = Array.isArray

	module.exports = (row, value, expected) ->

		unless utils.isObject value
			throw new TypeError "Schema: #{row} must be an object"

		# available properties
		if props = expected?.properties

			unless isArray props
				throw new TypeError "Schema internal: object validator requires that `properties` is an array"

			for prop of value
				unless ~props.indexOf prop
					throw new TypeError "Schema: #{row} doesn't provide #{prop} property"

		null