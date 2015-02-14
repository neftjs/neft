object
======

When `type` validator returns `object` for arrays, objects and
`null` (as standard *typeof* operator),
this validator is used to determine whether passed *value* is a plain object.

*Plain object* can't extends any custom prototypes.
You can read more about *plain objects* in `utils.isPlainObject()`

```
var schema = new Schema({
  dict: {
    object: true
  }
});

console.log(utils.catchError(schema.validate, schema, [{dict: []}])+'');
// "SchemaError: dict must be a plain object"

console.log(utils.catchError(schema.validate, schema, [{dict: null}])+'');
// "SchemaError: Required property dict not found"

console.log(utils.catchError(schema.validate, schema, [{dict: Object.create({a: 1})}])+'');
// "SchemaError: dict must be a plain object"

console.log(schema.validate({dict: {}}));
// true
```

This validator accepts `properties` array which determine allowed properties.

```
var schema = new Schema({
  dict: {
    object: {
      properties: ['name', 'age']
    }
  }
});

console.log(utils.catchError(schema.validate, schema, [{dict: { address: 'abc' }}])+'');
// "SchemaError: dict doesn't provide address property"

console.log(schema.validate({dict: { name: 'John' }}));
// true
```

	'use strict'

	assert = require 'neft-assert'
	utils = require 'utils'

	{isArray} = Array

	module.exports = (Schema) -> (row, value, expected) ->
		unless expected
			return

		unless utils.isPlainObject value
			throw new Schema.Error "#{row} must be a plain object"

		# available properties
		if props = expected?.properties
			assert.isArray props

			for prop of value
				unless ~props.indexOf prop
					throw new Schema.Error "#{row} doesn't provide #{prop} property"

		return