# Array Validator

Determines whether the tested value is an array.

```javascript
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
            throw new Schema.Error row, 'array', "#{row} must be an array"
