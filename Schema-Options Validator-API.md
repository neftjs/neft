> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Options Validator**

# Options Validator

Determines accepted property values.
```javascript
var schema = new Schema({
  city: {
    options: ['Paris', 'Warsaw']
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
    country: 'France'
  },
  Warsaw: {
    country: 'Poland'
  }
};
var schema = new Schema({
  city: {
    options: cities
  }
});
console.log(utils.catchError(schema.validate, schema, [{city: 'Moscow'}])+'');
// "SchemaError: Passed city value is not acceptable"
console.log(schema.validate({city: 'Paris'}));
// true
```

> [`Source`](/Neft-io/neft/tree/master/src/schema/validators/options.litcoffee#options-validator)

