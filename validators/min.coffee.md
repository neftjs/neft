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

log(schema.validate({age: -5}));
// RangeError: Schema: Minimum range of age is 0

log(schema.validate({age: 'string'}));
// RangeError: Schema internal: max for age row must be a number

log(schema.validate({age: 20}));
// true

log(schema.validate({age: 0}));
// true
```

	'use strict'

	module.exports = (row, value, expected) ->
		if typeof expected isnt 'number'
			throw new TypeError "Schema internal: max for #{row} row must be a number"

		if typeof value is 'number' and value < expected
			throw new RangeError "Schema: Minimum range of #{row} is #{expected}"