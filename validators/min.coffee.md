min @validator
==============

Determines the minimum range on the number.

The tested value can be greater or equal maximum.

```javascript
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

		if not value or value.length < expected
			throw new Schema.Error row, 'min', "Minimum range of #{row} is #{expected}"
