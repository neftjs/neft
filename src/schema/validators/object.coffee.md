object @validator
=================

Determines whether the tested value is an object.

The [utils.isObject()][utils/utils.isObject()] is used internally.

```javascript
var schema = new Schema({
  dict: {
    object: true
  }
});

console.log(utils.catchError(schema.validate, schema, [{dict: 'text'}])+'');
// "SchemaError: dict must be an object"

console.log(utils.catchError(schema.validate, schema, [{dict: null}])+'');
// "SchemaError: Required property dict not found"

console.log(schema.validate({dict: {}}));
// true
```

This validator accepts the properties array used to describe the allowed properties.

```javascript
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
	utils = require 'neft-utils'

	module.exports = (Schema) -> (row, value, expected) ->
		unless expected
			return

		unless utils.isObject(value)
			throw new Schema.Error row, 'object', "#{row} must be an object"

		# available properties
		if props = expected?.properties
			assert.isArray props

			for prop of value
				unless ~props.indexOf prop
					throw new Schema.Error row, 'object.properties', "#{row} doesn't provide #{prop} property"

		return
