> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Schema**

# Schema

Module used to validate structures.

Access it with:
```javascript
const { Schema } = Neft;
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/schema/index.litcoffee#schema)

## Nested APIs* [[Array Validator|Schema-Array Validator-API]]
* [[Max Validator|Schema-Max Validator-API]]
* [[Min Validator|Schema-Min Validator-API]]
* [[Object Validator|Schema-Object Validator-API]]
* [[Optional Validator|Schema-Optional Validator-API]]
* [[Options Validator|Schema-Options Validator-API]]
* [[RegExp Validator|Schema-RegExp Validator-API]]
* [[Type Validator|Schema-Type Validator-API]]

## Table of contents
* [Schema](#schema)
  * [**Class** SchemaError()](#class-schemaerror)
  * [**Class** Schema](#class-schema)
    * [constructor](#constructor)
    * [schema](#schema)
    * [validate](#validate)
      * [Nested properties](#nested-properties)

## **Class** SchemaError()

Raised by `Schema::validate()` if given data doesn't pass the schema.

Access it with:
```javascript
var Schema = require('schema');
var SchemaError = Schema.Error;
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/schema/index.litcoffee#class-schemaerror)

## **Class** Schema

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/schema/index.litcoffee#class-schema)

###constructor
<dl><dt>Syntax</dt><dd><code>Schema::constructor(&#x2A;Object&#x2A; schema)</code></dd><dt>Prototype method of</dt><dd><i>Schema</i></dd><dt>Parameters</dt><dd><ul><li>schema — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/schema/index.litcoffee#constructor)

###schema
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Schema::schema</code></dd><dt>Prototype property of</dt><dd><i>Schema</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
Saved schema object from the constructor.

It's allowed to change this object in runtime.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/schema/index.litcoffee#schema)

###validate
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Schema::validate(&#x2A;Object&#x2A; data)</code></dd><dt>Prototype method of</dt><dd><i>Schema</i></dd><dt>Parameters</dt><dd><ul><li>data — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
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

#### Nested properties

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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/schema/index.litcoffee#nested-properties)

