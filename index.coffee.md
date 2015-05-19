Schema @library
======

**Validate data**

Module used to validate structures e.g. got data from the client.

Access it with:
```
var Schema = require('schema');
```

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'

*SchemaError* SchemaError()
---------------------------

This error is raised by the *Schema.prototype.validate()* method
if given *data* doesn't pass schema.

Access it with:
```
var Schema = require('schema');
var SchemaError = Schema.Error;
```

	class SchemaError extends Error
		constructor: (@message) -> super

		name: 'SchemaError'
		message: ''

*Schema* Schema(*Object* schema)
--------------------------------

Creates *Schema* instance used to validate data.

Given *schema* object describes expected structure of the documents.

You use validators to specify proper value for each property.

```
new Schema({
  address: {
    type: 'string'
  },
  delivery: {
    optional: true,
    type: 'boolean'
  }
});
```

	module.exports = class Schema
		@Error = SchemaError

		constructor: (@schema) ->
			assert.isPlainObject schema

			assert.notOk utils.isEmpty(schema)
			, "Schema: schema can't be empty"

			for row, elem of schema
				assert utils.isPlainObject(elem)
				, "Schema: schema for #{row} row is not an object"

			Object.preventExtensions @

*Object* Schema::schema
-----------------------

Saved schema object from the constructor.

It's allowed to change this object in runtime.

		schema: null

*Boolean* Schema::validate(*Object* data)
-----------------------------------------

Validates given *data* object by the schema.

This method throws an error if data is invalid, otherwise `true` is returned.
To get always a boolean value, you can use `utils.tryFunction()`.

```
var schema = new Schema({
  age: {
    type: 'number',
    min: 0,
    max: 200
  }
});

console.log(utils.catchError(schema.validate, schema, [{}])+'');
// "SchemaError: Required property age not found"

console.log(utils.catchError(schema.validate, schema, [{name: 'Jony'}])+'');
// "SchemaError: Unexpected name property"

console.log(utils.catchError(schema.validate, schema, [{age: -5}])+'');
// "SchemaError: Minimum range of age is 0"

console.log(schema.validate({age: 20}));
// true

console.log(utils.tryFunction(schema.validate, schema, [{age: -1}], false));
// false

console.log(utils.tryFunction(schema.validate, schema, [{age: 5}], false));
// true
```

#### Nested properties

You can validate deep objects by writings schemas for nested properties.

Use dot in the property name to point where it's placed.

```
var schema = new Schema({
  obj: {
    type: 'object'
  },
  'obj.prop1.name': {
  	type: 'string'
  }
});

console.log(utils.catchError(schema.validate, schema, [{obj: {prop1: {name: 123}}}])+'');
// "SchemaError: obj.prop1.name must be a string"

console.log(schema.validate({obj: {prop1: {name: 'Lily'}}}));
// true
```

This function uses [utils.get()][] internally,
so all its features are supported (including multiple values).

```
var schema = new Schema({
  names: {
  	array: true
  },
  'names[]': {
  	type: 'string'
  }
});

console.log(utils.catchError(schema.validate, schema, [{names: [123, null]}])+'');
// "SchemaError: names[] must be a string"

console.log(schema.validate({names: ['Lily', 'Max']}));
// true
```

		validators =
			array: require('./validators/array') Schema
			object: require('./validators/object') Schema
			optional: require('./validators/optional') Schema
			max: require('./validators/max') Schema
			min: require('./validators/min') Schema
			options: require('./validators/options') Schema
			regexp: require('./validators/regexp') Schema
			type: require('./validators/type') Schema

		validate: (data) ->
			assert.isNotPrimitive data

			# check if there is no unprovided rows
			for row of data
				unless @schema.hasOwnProperty row
					throw new SchemaError "Unexpected #{row} property"

			# by rows
			for row, rowValidators of @schema
				# get current value
				# add support for string referecing into sub-properties and
				# multiple values by `utils.get()`
				values = utils.get data, row

				if not values? and not rowValidators.optional
					throw new SchemaError "Required property #{row} not found"

				# by validators
				for validatorName, validatorOpts of rowValidators
					validator = validators[validatorName]

					assert validator, "Schema validator #{validatorName} not found"

					if values instanceof utils.get.OptionsArray
						for value, i in values
							validator row, value, validatorOpts
					else
						validator row, values, validatorOpts

			true
