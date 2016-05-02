max @validator
==============

Determines the maximum range of the number.

The tested value can be lower or equal maximum.

```javascript
var schema = new Schema({
  age: {
    max: 200
  }
});

console.log(utils.catchError(schema.validate, schema, [{age: 201}])+'');
// "SchemaError: Maximum range of age is 200"

console.log(schema.validate({age: 'string'}));
// true

console.log(schema.validate({age: 200}));
// true

console.log(schema.validate({age: -5}));
// true
```

    'use strict'

    assert = require 'src/assert'

    module.exports = (Schema) -> (row, value, expected) ->
        assert.isFloat expected
        , "max validator option for #{row} property must be float"

        if not value or value > expected
            throw new Schema.Error row, 'max', "Maximum range of #{row} is #{expected}"
