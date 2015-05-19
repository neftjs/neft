options @validator
=======

This validator determines accepted property values.

```
var schema = new Schema({
  city: {
    options: ['Paris', 'Warsaw']
  }
});

console.log(utils.catchError(schema.validate, schema, [{city: 'Berlin'}])+'');
// "SchemaError: Passed city value is not acceptable"

console.log(schema.validate({city: 'Warsaw'}));
// true
```

This validator also accepts an object in place of array.

In such case, we check whether property value exists as an object key.

```
var cities = {
  Paris: {
    country: 'France'
  },
  Warsaw: {
    country: 'Poland'
  }
};

var schema = new Schema({
  city: {
    options: cities
  }
});

console.log(utils.catchError(schema.validate, schema, [{city: 'Moscow'}])+'');
// "SchemaError: Passed city value is not acceptable"

console.log(schema.validate({city: 'Paris'}));
// true
```

	'use strict'

	assert = require 'neft-assert'
	utils = require 'utils'

	module.exports = (Schema) -> (row, value, expected) ->
		assert.isObject expected
		, "options validator option for #{row} property must be an object or array"

		if Array.isArray(expected)
			passed = utils.has expected, value
		else
			passed = expected.hasOwnProperty value

		unless passed
			throw new Schema.Error row, 'options', "Passed #{row} value is not acceptable"
