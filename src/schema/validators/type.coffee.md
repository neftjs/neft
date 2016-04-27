type @validator
===============

Verifies the tested value type using the `typeof`.

```javascript
var schema = new Schema({
  desc: {
    type: 'object'
  }
});

console.log(utils.catchError(schema.validate, schema, [{desc: 231}])+'');
// "SchemaError: desc must be a object"

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

		if typeof value isnt expected
			throw new Schema.Error row, 'type', "#{row} must be a #{expected}"
