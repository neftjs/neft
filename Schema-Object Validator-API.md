> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Schema|Schema-API]] ▸ **Object Validator**

# Object Validator

Determines whether the tested value is an object.

The [utils.isObject()][utils/utils.isObject()] is used internally.

```javascript
var schema = new Schema({
  dict: {
    object: true
  }
});

console.log(utils.catchError(schema.validate, schema, [{dict: 'text'}])+'');
// "SchemaError: dict must be an object"

console.log(utils.catchError(schema.validate, schema, [{dict: null}])+'');
// "SchemaError: Required property dict not found"

console.log(schema.validate({dict: {}}));
// true
```

This validator accepts the properties array used to describe the allowed properties.

```javascript
var schema = new Schema({
  dict: {
    object: {
      properties: ['name', 'age']
    }
  }
});

console.log(utils.catchError(schema.validate, schema, [{dict: { address: 'abc' }}])+'');
// "SchemaError: dict doesn't provide address property"

console.log(schema.validate({dict: { name: 'John' }}));
// true
```

> [`Source`](/Neft-io/neft/blob/2aaed99455b1ed473d23e1aec13cd859d63d5b3b/src/schema/validators/object.litcoffee#object-validator)

