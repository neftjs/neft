Schema
======

Validate data using specified validators.

The whole process in this module must be synchronous.

When invalid data has been passed, standard JavaScript errors should be raised
(`Error`, `TypeError`, `RangeError`).

	'use strict'

	validators =
		required: require('./validators/required')
		array: require('./validators/array')
		object: require('./validators/object')
		function: require('./validators/function')
		max: require('./validators/max')
		min: require('./validators/min')
		options: require('./validators/options')
		re: require('./validators/re')
		type: require('./validators/type')

	utils = require 'utils'

	objKeys = Object.keys

*class* Schema
--------------

	module.exports = class Schema

### Constructor( *Object* schema )

Craate new *Schema* instance with got *requirements object*.

Check supported validators to create your own *schema*.

The *requirements object* must provide all possible rows which are validated.

##### Example
```coffeescript
Schema = require 'schema'

new Schema
	address:
		required: 'string'
		type: 'string'
	delivery:
		type: 'boolean'
```

		constructor: (@schema) ->

			unless utils.isPlainObject schema
				throw new TypeError "Schema(): schema structure is not an object"

			unless objKeys(schema).length
				throw new TypeError "Schema(): schema can't be empty"

			for row, elem of schema
				unless utils.isPlainObject elem
					throw new TypeError "Schema(): schema for #{row} row is not an object"

### *Object* schema

This property keeps passed *schema* object from the constructor.

Object is not *readonly*, so you can change the config in realtime.

		schema: null

### validate( *Object* data )

Validate passed *data* by the already registered validators.

This method throws an error if data is invalid.

##### Example
```coffeescript
Schema = require 'schema'

schema = new Schema
	age:
		required: true
		type: 'number'
		min: 0
		max: 200

schema.validate name: 'Jony'
# throws `TypeError: Schema::validate(): unexpected name row`

schema.validate age: -5
# throws `RangeError: Schema: Minimum range of age is 0`

schema.validate age: 20
# returns `true`
```

##### Tip
###### Get an boolean value
To get `true`/`false` which determines whether data passed validator or not,
you can use `tryFunc` from [utils][module_utils] module.

```coffeescript
utils = require 'utils'

utils.tryFunction schema.validate, schema, [age: -1], false
# returns `false`

utils.tryFunction schema.validate, schema, [age: 5], false
# returns `true`
```

		validate: (data) ->

			# check if there is no unprovided rows
			for row of data
				unless @schema.hasOwnProperty row
					throw new TypeError "Schema::validate(): unexpected #{row} row"

			# by rows
			for row, options of @schema

				# get current value
				# add support for string referecing into sub-properties and
				# multiple values by `utils.get()`
				values = utils.get data, row

				# by validators
				for validator, validate of validators when options.hasOwnProperty validator

					expected = options[validator]

					if values instanceof utils.get.OptionsArray

						for value, i in values

							validate row, value, expected

					else

						validate row, values, expected

			true