> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Dict**

# Dict

Module used for data-binding on objects.
Access it with:
```javascript
const { Dict } = Neft
```

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#dict)

## Table of contents
  * [**Class** Dict](#class-dict)
    * [fromJSON](#fromjson)
    * [constructor](#constructor)
    * [length](#length)
    * [onChange](#onchange)
    * [set](#set)
    * [has](#has)
    * [extend](#extend)
    * [pop](#pop)
    * [clear](#clear)
    * [keys](#keys)
    * [*Array* Dict::values()](#array-dictvalues)
    * [*Array* Dict::items()](#array-dictitems)
      * [Iterate over a dict](#iterate-over-a-dict)
  * [Glossary](#glossary)

## **Class** Dict

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#class-dict)

<dl><dt>Static method of</dt><dd><i>Dict</i></dd><dt>Parameters</dt><dd><ul><li><b>|</b> — <i>String</i></li><li><b>json</b> — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Dict</i></dd></dl>
###fromJSON
Creates a new [*Dict*](/Neft-io/neft/wiki/Dict-API.md#class-dict) from a json string.
This function should be used with `toJSON()` output.

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#dict-dictfromjsonstringobject-json)

<dl><dt>Prototype method of</dt><dd><i>Dict</i></dd><dt>Parameters</dt><dd><ul><li><b>data</b> — <i>Object</i> — <i>optional</i></li></ul></dd></dl>
###constructor
Creates a new dict instance.
The given data parameter determines default keys with their values.
```javascript
var data = new Dict({
  name: 'xyz'
});
console.log(data.name);
// xyz
```

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#dictconstructorobject-data)

<dl><dt>Prototype property of</dt><dd><i>Dict</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>read only</dt></dl>
###length
Amount of keys stored in a dict.
```javascript
var dict = Dict({prop: 1});
console.log(dict.length);
// 1
```

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#readonly-integer-dictlength)

<dl><dt>Prototype method of</dt><dd><i>Dict</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li><li><b>oldValue</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
###onChange
Signal called on each key value change.
```javascript
var user = new Dict({
  country: 'Germany'
});
user.onChange.connect(function(key, oldVal){
  console.log(key + " property changed from " + oldVal + " to " + this[key]);
});
user.set('country', 'US');
// country property changed from Germany to US
```

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#signal-dictonchangestring-key-any-oldvalue)

<dl><dt>Prototype method of</dt><dd><i>Dict</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li><li><b>value</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
###set
Sets the given value for the given key stored in the dict.
The value can't be an undefined. Use `pop()` instead.
Calls `onChange()` signal.
```javascript
var links = new Dict({
  facebook: 'https://facebook.com/neft.io',
  twitter: 'https://twitter.com/neft_io'
});
links.onChange.connect(function(key, oldVal){
  console.log(key + " changed from " + oldVal + " to " + this[key]);
});
links.set('googlePlus', 'https://plus.google.com/+NeftIo-for-apps/');
// googlePlus changed from undefined to https://...
```

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#any-dictsetstring-key-any-value)

<dl><dt>Prototype method of</dt><dd><i>Dict</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
###has
Returns `true` if the given key exists in the dict.

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#boolean-dicthasstring-key)

<dl><dt>Prototype method of</dt><dd><i>Dict</i></dd><dt>Parameters</dt><dd><ul><li><b>|</b> — <i>Object</i></li><li><b>object</b> — <i>Dict</i></li></ul></dd><dt>Returns</dt><dd><i>Dict</i></dd></dl>
###extend
Sets all keys with their values from the given object.
Calls `onChange()` signal for each key.

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#dict-dictextendobjectdict-object)

<dl><dt>Prototype method of</dt><dd><i>Dict</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
###pop
Removes the given key from the dict.
The key must exists in the dict.
Calls `onChange()` signal.
```javascript
var data = new Dict;
data.set('name', 'John');
data.onChange.connect(function(key, oldVal){
  if (this[key] === undefined){
    console.log(key + " property has been removed");
  }
});
data.pop('name');
// name property has been removed
```

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#any-dictpopstring-key)

<dl><dt>Prototype method of</dt><dd><i>Dict</i></dd></dl>
###clear
Removes all stored keys from the dict.
Calls `onChange()` signal for each stored key.

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#dictclear)

<dl><dt>Prototype method of</dt><dd><i>Dict</i></dd><dt>Returns</dt><dd><i>Array</i></dd><dt>read only</dt></dl>
###keys
Returns an array of keys stored in the dict.
Always returns the same array instance.
```javascript
var data = new Dict({
  x: 10,
  y: 30
});
console.log(data.keys());
// ['x', 'y']
```

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#readonly-array-dictkeys)

### *Array* Dict::values()

Returns an array of values stored in the dict.
Always returns the same array instance.
```javascript
var data = new Dict({
  x: 10,
  y: 30
});
console.log(data.values());
// [10, 30]
```

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#array-dictvalues)

### *Array* Dict::items()

Returns an array of key-value pairs stored in the dict.
Always returns the same array instance.
```javascript
var data = new Dict({
  x: 10,
  y: 30
});
console.log(data.items());
// [['x', 10], ['y', 30]]
```

#### Iterate over a dict

```javascript
var dict = new Dict({prop1: 1, prop2: 2});
var items = dict.items();
for (var i = 0; i < items.length; i++){
  console.log(items[i][0], items[i][1]);
}
// ['prop1', 1]
// ['prop2', 2]
```

> [`Source`](/Neft-io/neft/tree/master/src/dict/index.litcoffee#iterate-over-a-dict)

## Glossary

- [Dict](#class-dict)

