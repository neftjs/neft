# Dict

> **API Reference** ▸ **Dict**

<!-- toc -->
Access it with:
```javascript
const { Dict } = Neft
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee)


* * * 

### `Dict.fromJSON()`

<dl><dt>Static method of</dt><dd><i>Dict</i></dd><dt>Parameters</dt><dd><ul><li>json — <i>Object</i> or <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Dict</i></dd></dl>

Returns a new *Dict* based on the given *json*.

Example:

```javascript
const dict = Dict.fromJSON('{"param": "value"}');
dict.param; // value
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#dict-dictfromjsonstringobject-json)


* * * 

### `constructor()`

<dl><dt>Parameters</dt><dd><ul><li>data — <i>Object</i> — <i>optional</i></li></ul></dd></dl>

Creates a new dict instance.

The given *data* parameter determines default keys with their values.

Example:

```javascript
var data = new Dict({
  name: 'xyz'
});
data.name; // xyz
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#dictconstructorobject-data)


* * * 

### `length`

<dl><dt>Type</dt><dd><i>Integer</i></dd><dt>Read Only</dt></dl>

Returns an amount of keys stored in this *Dict*.

This property cannot be changed manually.

Example:

```javascript
var dict = Dict({ prop: 1 });
dict.length; // 1
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#readonly-integer-dictlength)


* * * 

### `onChange()`

<dl><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

Signal called on each key value change.

Example:

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


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#signal-dictonchangestring-key-any-oldvalue)


* * * 

### `set()`

<dl><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

Sets the given value under the given key in this *Dict*.

The given value can't be an undefined. Use `pop()` instead.

Calls `onChange()` signal.

Example:

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


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#any-dictsetstring-key-any-value)


* * * 

### `has()`

<dl><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

Returns `true` if the given key exists in this *Dict*.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#boolean-dicthasstring-key)


* * * 

### `extend()`

<dl><dt>Parameters</dt><dd><ul><li>object — <i>Dict</i> or <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Dict</i></dd></dl>

Sets all keys with their values from the given object into this *Dict*.

Calls `onChange()` signal for each given key.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#dict-dictextendobjectdict-object)


* * * 

### `pop()`

<dl><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

Removes the given key from this *Dict*.

The given key must exists.

Calls `onChange()` signal.

Example:

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


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#any-dictpopstring-key)


* * * 

### `clear()`
Removes all stored keys from this *Dict*.

Calls `onChange()` signal for each stored key.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#dictclear)


* * * 

### `keys()`

<dl><dt>Returns</dt><dd><i>Array</i></dd><dt>Read Only</dt></dl>

Returns an array of keys stored in this *Dict*.

Returned array is *read only* and cannot be modified.

Always returns the same array instance.

Example:

```javascript
var data = new Dict({
  x: 10,
  y: 30
});
data.keys(); // ['x', 'y']
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#readonly-array-dictkeys)


* * * 

### `values()`

<dl><dt>Returns</dt><dd><i>Array</i></dd></dl>

Returns an array of values stored in this *Dict*.

Returned array is *read only* and cannot be modified.

Always returns the same array instance.

Example:

```javascript
var data = new Dict({
  x: 10,
  y: 30
});
data.values(); // [10, 30]
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#array-dictvalues)


* * * 

### `items()`

<dl><dt>Returns</dt><dd><i>Array</i></dd></dl>

Returns an array of key-value pairs stored in this *Dict*.

Returned array is *read only* and cannot be modified.

Always returns the same array instance.

Example:

```javascript
var data = new Dict({
  x: 10,
  y: 30
});
data.items(); // [['x', 10], ['y', 30]]
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/dict/index.litcoffee#array-dictitems)

