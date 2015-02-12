Schema
======

**Validate data**

Module used to validate structures e.g. got data from the client.

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

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

	objKeys = Object.keys

*Schema* Schema(*Object* schema)
--------------------------------

Creates new *Schema* instance.

Given *schema* object must provides options for each possible property.

Check validators documentation for more information.

```
new Schema({
  address: {
    required: 'string',
    type: 'string'
  },
  delivery: {
    type: 'boolean'
  }
});
```

	module.exports = class Schema

		constructor: (@schema) ->
			expect(schema).toBe.simpleObject()

			unless objKeys(schema).length
				throw new TypeError "Schema(): schema can't be empty"

			for row, elem of schema
				unless utils.isPlainObject elem
					throw new TypeError "Schema(): schema for #{row} row is not an object"

*Object* Schema::schema
-----------------------

Saved schema object from the constructor.

It's allowed to change this object in runtime.

		schema: null

*Boolean* Schema::validate(*NotPrimitive* data)
-----------------------------------------------

Validates given *data* object by the schema validators.

This method throws an error if data is invalid, otherwise `true` is returned.
To get always a boolean value, you can use `utils.tryFunction()`.

```
var schema = new Schema({
  age: {
    required: true,
    type: 'number',
    min: 0,
    max: 200
  }
});

console.log(schema.validate(name: 'Jony'));
// TypeError: Schema::validate(): unexpected name row

console.log(schema.validate(age: -5));
// RangeError: Schema: Minimum range of age is 0

console.log(schema.validate(age: 20));
// true

console.log(utils.tryFunction(schema.validate, schema, [age: -1], false));
// false

console.log(utils.tryFunction(schema.validate, schema, [age: 5], false));
// true
```

		validate: (data) ->
			expect(data).not().toBe.primitive()

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
