Dict @library
=============

Module used for data-binding on objects.

Access it with:
```javascript
var dict = require('dict');
```

*[Dict]()* [Dict]().fromJSON(*[String]()|[Object]()* json)
------------------------------------------

Creates a new *Dict* from a json string.

This function should be used with [toJSON()][dict/Dict::toJSON()] output.

> [Source]()

*Dict* Dict([*Object* data])
----------------------------

Creates a new dict instance.

The given data parameter determines default keys with their values.

```javascript
var data = new Dict({
  name: 'xyz'
});

console.log(data.name);
// xyz
```

ReadOnly *Integer* Dict::length
-------------------------------

Amount of keys stored in a dict.

```javascript
var dict = Dict({prop: 1});

console.log(dict.length);
// 1
```

*Signal* Dict::onChange(*String* key, *Any* oldValue)
-----------------------------------------------------

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

*Any* Dict::set(*String* key, *Any* value)
------------------------------------------

Sets the given value for the given key stored in the dict.

The value can't be an undefined. Use [pop()][dict/Dict::pop()] instead.

Calls [onChange()][dict/Dict::onChange()] signal.

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

*Boolean* Dict::has(*String* key)
---------------------------------

Returns `true` if the given key exists in the dict.

*Dict* Dict::extend(*Object|Dict* object)
-----------------------------------------

Sets all keys with their values from the given object.

Calls [onChange()][dict/Dict::onChange()] signal for each key.

*Any* Dict::pop(*String* key)
-----------------------------

Removes the given key from the dict.

The key must exists in the dict.

Calls [onChange()][dict/Dict::onChange()] signal.

```javascript
var data = new Dict;

data.set('name', 'John');

data.onChange.connect(function(key, oldVal){
  if (this[key] === undefined){
  }
});

data.pop('name');
// name property has been removed
```

Dict::clear()
-------------

Removes all stored keys from the dict.

Calls [onChange()][dict/Dict::onChange()] signal for each stored key.

ReadOnly *Array* Dict::keys()
-----------------------------

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

*Array* Dict::values()
----------------------

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

*Array* Dict::items()
---------------------

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

### Iterate over a dict
```javascript
var dict = new Dict({prop1: 1, prop2: 2});
var items = dict.items();
for (var i = 0; i < items.length; i++){
  console.log(items[i][0], items[i][1]);
}
// ['prop1', 1]
// ['prop2', 2]
```

