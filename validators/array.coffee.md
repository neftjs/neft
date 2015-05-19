array @validator
=====

This validator is used to determine whether *value* is a true array.

Remember that *arguments* and other array-like objects in *JavaScript* are not arrays.

```
var schema = new Schema({
  friends: {
    array: true
  }
});

console.log(utils.catchError(schema.validate, schema, [{friends: {}}])+'');
// "SchemaError: friends must be an array"

console.log(schema.validate({friends: []}));
// true
```

	'use strict'

	{isArray} = Array

	module.exports = (Schema) -> (row, value, expected) ->
		if expected and not isArray(value)
			throw new Schema.Error "#{row} must be an array"