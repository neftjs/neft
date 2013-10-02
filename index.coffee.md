Schema
======

### Goals

Validate data using specified validators. If no error are raised, data passed.

Standard JS errors should be raising, when invalid data is passed.

### Schema structure

Structure is a namespace with *row* name and options as specified:

*  `required` - if *row* has been specified,
*  `array` - if *value* is an array,
*  `object = [{Object}]` - if *value* is a pure object (without any other protos);
   define available properties by specified `properties`,
*  `function` - if *value* is a proper function,
*  `max = {Number}` - if *value* is lower or the same as *expected*,
*  `min = {Number}` - if *value* is greater or the same as *expected*,
*  `options = {Object|Array}` - if *value* was provided in the *expected*
   (keys if Object, elements if Array),
*  `re = {RegExp}` - if *value* test *expected* regexp,
*  `type = {String}` - if *value* is the same type as *expected*
   (for `NaN` and `null` the type is `undefined`).

Provided schema validators options shoduldn't be validated if no specified options
are required. Schema object could be edit in realtime also.

Validators
----------

	validators =
		required: require('./validators/required.coffee')
		array: require('./validators/array.coffee')
		object: require('./validators/object.coffee')
		function: require('./validators/function.coffee')
		max: require('./validators/max.coffee')
		min: require('./validators/min.coffee')
		options: require('./validators/options.coffee')
		re: require('./validators/re.coffee')
		type: require('./validators/type.coffee')

*class* Schema
--------------

	'use strict'

	utils = require 'utils'

	objKeys = Object.keys

	module.exports = class Schema

### Constructor

		constructor: (@schema) ->

			unless utils.isObject schema
				throw new TypeError "Schema(): schema structure is not an object"

			unless objKeys(schema).length
				throw new TypeError "Schema(): schema can't be empty"

			for row, elem of schema
				unless utils.isObject elem
					throw new TypeError "Schema(): schema for #{row} row is not an object"

### Properties

#### schema

		schema: null

### Methods

#### validate()

Standard JS errors will be raised if data not passed, otherwise `true`.

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