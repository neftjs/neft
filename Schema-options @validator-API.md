options @validator
==================

Determines accepted property values.

```javascript
var schema = new Schema({
  city: {
  }
});

console.log(utils.catchError(schema.validate, schema, [{city: 'Berlin'}])+'');
// "SchemaError: Passed city value is not acceptable"

console.log(schema.validate({city: 'Warsaw'}));
// true
```

If the object has been given, validator checks whether the tested value exists as an object key.

```javascript
var cities = {
  Paris: {
  },
  Warsaw: {
  }
};

var schema = new Schema({
  city: {
  }
});

console.log(utils.catchError(schema.validate, schema, [{city: 'Moscow'}])+'');
// "SchemaError: Passed city value is not acceptable"

console.log(schema.validate({city: 'Paris'}));
// true
```

