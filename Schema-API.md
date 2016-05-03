Schema @library
===============

Module used to validate structures.

Access it with:
```javascript
var Schema = require('schema');
```

*SchemaError* SchemaError()
---------------------------

Raised by the `Schema::validate()` if given data doesn't pass the schema.

Access it with:
```javascript
var Schema = require('schema');
var SchemaError = Schema.Error;
```

*Schema* Schema(*Object* schema)
--------------------------------

Creates a new Schema instance used to validate data.

Specify schema validators for each of the accepted property.

```javascript
new Schema({
  address: {
  },
  delivery: {
  }
});
```

*Object* Schema::schema
-----------------------

Saved schema object from the constructor.

It's allowed to change this object in runtime.

*Boolean* Schema::validate(*Object* data)
-----------------------------------------

Validates the given data object by the schema.

Returns `true` if the data is valid, otherwise throws an SchemaError instance.

```javascript
var schema = new Schema({
  age: {
  }
});

console.log(utils.catchError(schema.validate, schema, [{}])+'');
// "SchemaError: Required property age not found"

console.log(utils.catchError(schema.validate, schema, [{name: 'Jony'}])+'');
// "SchemaError: Unexpected name property"

console.log(utils.catchError(schema.validate, schema, [{age: -5}])+'');
// "SchemaError: Minimum range of age is 0"

console.log(schema.validate({age: 20}));
// true

console.log(utils.tryFunction(schema.validate, schema, [{age: -1}], false));
// false

console.log(utils.tryFunction(schema.validate, schema, [{age: 5}], false));
// true
```

### Nested properties

Use dot in the property name to valdiate deep objects.

```javascript
var schema = new Schema({
  obj: {
  },
  'obj.prop1.name': {
  }
});

console.log(utils.catchError(schema.validate, schema, [{obj: {prop1: {name: 123}}}])+'');
// "SchemaError: obj.prop1.name must be a string"

console.log(schema.validate({obj: {prop1: {name: 'Lily'}}}));
// true
```

This function uses the [utils.get()][utils/utils.get()] internally.

```javascript
var schema = new Schema({
  names: {
  },
  'names[]': {
  }
});

console.log(utils.catchError(schema.validate, schema, [{names: [123, null]}])+'');
// "SchemaError: names[] must be a string"

console.log(schema.validate({names: ['Lily', 'Max']}));
// true
```

