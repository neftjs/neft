# List

> **API Reference** ▸ **List**

<!-- toc -->
Access it with:
```javascript
const { List } = Neft;
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee)


* * * 

### `constructor()`

<dl><dt>Parameters</dt><dd><ul><li>data — <i>Array</i> — <i>optional</i></li></ul></dd></dl>

Creates a new list instance.

```javascript
var list = new List([1, 2]);
list instanceof List; // true
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#listconstructorarray-data)


* * * 

### `onChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Any</i></li><li>index — <i>Integer</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

Signal called on each value change.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#signal-listonchangeany-oldvalue-integer-index)


* * * 

### `onInsert()`

<dl><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>index — <i>Integer</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

Signal called when a value was added.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#signal-listoninsertany-value-integer-index)


* * * 

### `onPop()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Any</i></li><li>index — <i>Integer</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

Signal called when a value was removed.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#signal-listonpopany-oldvalue-integer-index)


* * * 

### `length`

<dl><dt>Type</dt><dd><i>Integer</i></dd><dt>Read Only</dt></dl>

Amount of values stored in the list.

```javascript
var list = new List(['a', 'b']);
list.length; // 2
```


* * * 

### `set()`

<dl><dt>Parameters</dt><dd><ul><li>index — <i>Integer</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

Sets the given value under the given index.

The index must exists in the list.

The value can't be an `undefined`. Use `pop()` instead.

Calls `onChange()` signal.

```javascript
var types = new List(['fantasy', 'Thriller']);

types.onChange.connect(function(oldVal, i){
  console.log("element "+oldVal+" changed to "+this[i]);
});

types.set(0, 'Fantasy');
// element fantasy changed to Fantasy

types.set(0, 'Fantasy');
// nothing changed ...
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#any-listsetinteger-index-any-value)


* * * 

### `append()`

<dl><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

Adds the given value on the end on the list.

The value can't be an `undefined`.

Calls `onInsert()` signal.

```javascript
var fridge = new List(['apple', 'milk']);

fridge.onInsert.connect(function(val, i){
  console.log(val+" appended!");
});

fridge.append('cheese');
// cheese appended!

console.log(fridge.items());
// apple, milk, cheese
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#any-listappendany-value)


* * * 

### `insert()`

<dl><dt>Parameters</dt><dd><ul><li>index — <i>Integer</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

Add the given value under the given index.

The index can't be greater than the list length.

The value can't be an `undefined`.

Calls `onInsert()` signal.

```javascript
var list = new List(['a', 'b']);

list.onInsert.connect(function(val, i){
  console.log("new element "+val+" inserted at index "+i);
});

list.insert(1, 'c');
// new element c inserted at index 1

console.log(list.items());
// ['a', 'c', 'b']
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#any-listinsertinteger-index-any-value)


* * * 

### `extend()`

<dl><dt>Parameters</dt><dd><ul><li>items — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>List</i></dd></dl>

Appends all values stored in the given items into the list.

Calls `onInsert()` signal for each value.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#list-listextendobject-items)


* * * 

### `remove()`

<dl><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

Removes the given value from the list.

Calls `onPop()` signal.

```javascript
var list = new List(['a', 'b']);
list[1]; // b

list.remove('b');
list[1]; // undefined

list; // ['a']
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#any-listremoveany-value)


* * * 

### `pop()`

<dl><dt>Parameters</dt><dd><ul><li>index — <i>Integer</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>

Removes the value stored in the list under the given index.

The index must exists in the list.

Calls `onPop()` signal.

```javascript
var list = new List(['a', 'b']);
list[1]; // b

list.pop(1);
list[1]; // undefined

list; // ['a']
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#any-listpopinteger-index)


* * * 

### `clear()`
Removes all values stored in the list.

Calls `onPop()` signal for each value.

```javascript
var list = new List(['a', 'b']);

list.onPop.connect(function(oldVal, i){
  console.log("Element "+oldVal+" popped!");
});

console.log(list.items());
// ['a', 'b']

list.clear()
// Element b popped!
// Element a popped!

console.log(list);
// []
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#listclear)


* * * 

### `index()`

<dl><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Integer</i></dd></dl>

Returns the given value index in the list.

Returns `-1` if the value doesn't exist in the list.

```javascript
var list = new List(['a', 'b']);
list.index('b'); // 1
list.index('c'); // -1
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#integer-listindexany-value)


* * * 

### `has()`

<dl><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

Returns `true` if the given value exists in the list.

```javascript
var list = new List(['a', 'b']);
list.has('a'); // true
list.has('ab123'); // false
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#boolean-listhasany-value)


* * * 

### `toArray()`

<dl><dt>Returns</dt><dd><i>Array</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/list/index.litcoffee#array-listtoarray)

