max
===

Determines the maximum range from number.

*value* can be lower or equal maximum.

```
var schema = new Schema({
  age: {
    max: 200
  }
});

log(schema.validate({age: 201}));
// RangeError: Schema: Maximum range of age is 200

log(schema.validate({age: 'string'}));
// TypeError: Schema internal: max for age row must be a number

log(schema.validate({age: 200}));
// true

log(schema.validate({age: -5}));
// true
```

	'use strict'

	module.exports = (row, value, expected) ->
		if typeof expected isnt 'number'
			throw new TypeError "Schema internal: max for #{row} row must be a number"

		if typeof value is 'number' and value > expected
			throw new RangeError "Schema: Maximum range of #{row} is #{expected}"