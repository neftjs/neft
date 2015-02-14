min
===

Determines the minimum range from number.

*value* can be greater or equal maximum.

```
var schema = new Schema({
  age: {
    min: 0
  }
});

console.log(utils.catchError(schema.validate, schema, [{age: -5}])+'');
// "SchemaError: Minimum range of age is 0"

console.log(schema.validate({age: 'string'}));
// true

console.log(schema.validate({age: 20}));
// true

console.log(schema.validate({age: 0}));
// true
```

	'use strict'

	assert = require 'neft-assert'

	module.exports = (Schema) -> (row, value, expected) ->
		assert.isFloat expected
		, "min validator option for #{row} property must be float"

		if value < expected
			throw new Schema.Error "Minimum range of #{row} is #{expected}"