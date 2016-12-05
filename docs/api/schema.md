# Schema

> **API Reference** ▸ **Schema**

<!-- toc -->
Module used to validate structures.

Access it with:
```javascript
const { Schema } = Neft;
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/schema/index.litcoffee)

## **Class** SchemaError()

Raised by `Schema::validate()` if given data doesn't pass the schema.

Access it with:
```javascript
var Schema = require('schema');
var SchemaError = Schema.Error;
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/schema/index.litcoffee)


* * * 

### `constructor()`

<dl><dt>Parameters</dt><dd><ul><li>schema — <i>Object</i></li></ul></dd></dl>

Creates a new Schema instance used to validate data.

Specify schema validators for each of the accepted property.

```javascript
new Schema({
    address: {
        type: 'string'
    },
    delivery: {
        optional: true,
        type: 'boolean'
    }
});
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/schema/index.litcoffee#schemaconstructorobject-schema)


* * * 

### `schema`

<dl><dt>Type</dt><dd><i>Object</i></dd></dl>

Saved schema object from the constructor.

It's allowed to change this object in runtime.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/schema/index.litcoffee#object-schemaschema)


* * * 

### `validate()`

<dl><dt>Parameters</dt><dd><ul><li>data — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

Validates the given data object by the schema.

Returns `true` if the data is valid, otherwise throws an SchemaError instance.

```javascript
var schema = new Schema({
  age: {
    type: 'number',
    min: 0,
    max: 200
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
    type: 'object'
  },
  'obj.prop1.name': {
    type: 'string'
  }
});

console.log(utils.catchError(schema.validate, schema, [{obj: {prop1: {name: 123}}}])+'');
// "SchemaError: obj.prop1.name must be a string"

console.log(schema.validate({obj: {prop1: {name: 'Lily'}}}));
// true
```

This function uses *utils.get()* internally.

```javascript
var schema = new Schema({
  names: {
    array: true
  },
  'names[]': {
    type: 'string'
  }
});

console.log(utils.catchError(schema.validate, schema, [{names: [123, null]}])+'');
// "SchemaError: names[] must be a string"

console.log(schema.validate({names: ['Lily', 'Max']}));
// true
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/schema/index.litcoffee)

