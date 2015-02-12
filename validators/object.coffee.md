object
======

When `type` validator returns `object` for arrays, objects and
`null` (as standard *typeof* operator),
this validator is used to determine whether passed *value* is a plain object.

*Plain object* can't extends any custom prototypes.
You can read more about *plain objects* in `utils.isPlainObject()`

```
var schema = new Schema({
  dict: {
    object: true
  }
});

log(schema.validate({dict: []});
// TypeError: Schema: dict must be a plain object

log(schema.validate({dict: null});
// TypeError: Schema: dict must be a plain object

log(schema.validate({dict: Object.create({a: 1})});
// TypeError: Schema: dict must be a plain object

log(schema.validate({dict: {}});
// true
```

This validator accepts `properties` array which determine allowed properties.

```
var schema = new Schema({
  dict: {
    object: {
      properties: ['name', 'age']
    }
  }
});

log(schema.validate({dict: { address: 'abc' }});
// TypeError: Schema: dict doesn't provide address property

log(schema.validate({dict: { name: 'John' }});
// true
```

	'use strict'

	utils = require 'utils'

	{isArray} = Array

	module.exports = (row, value, expected) ->
		unless utils.isPlainObject value
			throw new TypeError "Schema: #{row} must be a plain object"

		# available properties
		if props = expected?.properties
			unless isArray props
				throw new TypeError "Schema internal: `object.properties` must be an array"

			for prop of value
				unless ~props.indexOf prop
					throw new TypeError "Schema: #{row} doesn't provide #{prop} property"

		null