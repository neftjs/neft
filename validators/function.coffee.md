function @TODO
========

Use this validator to check whether passed function can be properly called.

Use `type` validator to check whether function was passed.

```
var schema = new Schema({
  calculate: {
    function: true
  }
});

log(schema.validate(calculate: -> throw new Error));
// TypeError: Schema: calculate must be a proper function body

log(schema.validate(calculate: -> someUnknownProperty.a = 2));
// TypeError: Schema: calculate must be a proper function body

log(schema.validate(calculate: (a, b) -> a + b));
// true
```

	'use strict'

	module.exports = (row, value, expected) ->
		try
			func = new Function value
			eval func

		catch err
			throw new TypeError "Schema: #{row} must be a proper function body"