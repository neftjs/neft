type
====

This valdiator uses standard *typeof* expression to check whether *value* type is equal required.

Unlike standard `typeof`, this validator returns `undefined` for `NaN` and `null`.

```
var schema = new Schema({
  desc: {
    type: 'object'
  }
});

console.log(utils.catchError(schema.validate, schema, [{desc: 231}])+'');
// "SchemaError: desc must be a object"

console.log(utils.catchError(schema.validate, schema, [{desc: null}])+'');
// "SchemaError: Required property desc not found"

console.log(schema.validate({desc: {}}));
// true

console.log(schema.validate({desc: []}));
// true
// because in js `typeof []` is `object` ...
// you should use array validator instead ...
```

	'use strict'

	assert = require 'neft-assert'

	module.exports = (Schema) -> (row, value, expected) ->
		assert.isString expected
		, "type validator option for #{row} property must be a string"

		if isNaN(value) or value is null
			value = undefined

		if value? and typeof value isnt expected
			throw new Schema.Error "#{row} must be a #{expected}"