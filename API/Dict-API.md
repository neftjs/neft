> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Dict**

# Dict

> data-binding for objects

Access it with:
```javascript
const { Dict } = Neft
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#dict)

## Table of contents
* [Dict](#dict)
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
  * [values](#values)
  * [items](#items)
    * [Iterate over a dict](#iterate-over-a-dict)
* [Glossary](#glossary)

# **Class** Dict

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#class-dict)

##fromJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Dict&#x2A; Dict.fromJSON(&#x2A;String&#x2A;|&#x2A;Object&#x2A; json)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd><dt>Parameters</dt><dd><ul><li>json — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> or <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd></dl>
Creates a new [Dict](/Neft-io/neft/wiki/Dict-API#class-dict) from a json string.

This function should be used with `toJSON()` output.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#fromjson)

##constructor
<dl><dt>Syntax</dt><dd><code>Dict::constructor([&#x2A;Object&#x2A; data])</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd><dt>Parameters</dt><dd><ul><li>data — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd></dl>
Creates a new dict instance.

The given data parameter determines default keys with their values.

```javascript
var data = new Dict({
  name: 'xyz'
});
data.name; // xyz
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#constructor)

##length
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Integer&#x2A; Dict::length</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd><dt>Read Only</dt></dl>
Amount of keys stored in a dict.

```javascript
var dict = Dict({prop: 1});
dict.length; // 1
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#length)

##onChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Dict::onChange(&#x2A;String&#x2A; key, &#x2A;Any&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#onchange)

##set
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; Dict::set(&#x2A;String&#x2A; key, &#x2A;Any&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#set)

##has
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Dict::has(&#x2A;String&#x2A; key)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the given key exists in the dict.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#has)

##extend
<dl><dt>Syntax</dt><dd><code>&#x2A;Dict&#x2A; Dict::extend(&#x2A;Object&#x2A;|&#x2A;Dict&#x2A; object)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a> or <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd></dl>
Sets all keys with their values from the given object.

Calls `onChange()` signal for each key.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#extend)

##pop
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; Dict::pop(&#x2A;String&#x2A; key)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#pop)

##clear
<dl><dt>Syntax</dt><dd><code>Dict::clear()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd></dl>
Removes all stored keys from the dict.

Calls `onChange()` signal for each stored key.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#clear)

##keys
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Array&#x2A; Dict::keys()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd><dt>Returns</dt><dd><i>Array</i></dd><dt>Read Only</dt></dl>
Returns an array of keys stored in the dict.

Always returns the same array instance.

```javascript
var data = new Dict({
  x: 10,
  y: 30
});
data.keys(); // ['x', 'y']
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#keys)

##values
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Dict::values()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
Returns an array of values stored in the dict.

Always returns the same array instance.

```javascript
var data = new Dict({
  x: 10,
  y: 30
});
data.values(); // [10, 30]
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#values)

##items
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Dict::items()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
Returns an array of key-value pairs stored in the dict.

Always returns the same array instance.

```javascript
var data = new Dict({
  x: 10,
  y: 30
});
data.items(); // [['x', 10], ['y', 30]]
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

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/dict/index.litcoffee#iterate-over-a-dict)

# Glossary

- [Dict](#class-dict)

