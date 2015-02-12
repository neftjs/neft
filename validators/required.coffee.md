required
========

Use this validator to point *rows* which have to be defined.

Passed *row* must exists in the object and can't be `undefined` nor `null`.

```
var schema = new Schema({
  name: {
    required: true
  }
});

log(schema.validate({name: 1});
// true

log(schema.validate({name: null});
// TypeError: Schema: name is required

log(schema.validate({age: 2});
// TypeError: Schema: name is required
```

	'use strict'

	module.exports = (row, value, expected) ->

		unless value?
			throw new TypeError "Schema: #{row} is required"