> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **List**

# List

Module used for data-binding on arrays.
Access it with:
```javascript
const { List } = Neft;
```

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#list)

## Table of contents
  * [**Class** List](#class-list)
    * [constructor([data])](#listconstructorarray-data)
    * [onChange(oldValue, index)](#signal-listonchangeany-oldvalue-integer-index)
    * [onInsert(value, index)](#signal-listoninsertany-value-integer-index)
    * [onPop(oldValue, index)](#signal-listonpopany-oldvalue-integer-index)
    * [length](#readonly-integer-listlength)
    * [set(index, value)](#any-listsetinteger-index-any-value)
    * [append(value)](#any-listappendany-value)
    * [insert(index, value)](#any-listinsertinteger-index-any-value)
    * [extend(items)](#list-listextendobject-items)
    * [remove(value)](#any-listremoveany-value)
    * [pop([index])](#any-listpopinteger-index)
    * [clear()](#listclear)
    * [index(value)](#integer-listindexany-value)
    * [has(value)](#boolean-listhasany-value)
    * [toArray()](#array-listtoarray)
  * [Glossary](#glossary)

## **Class** List

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#class-list)

### List::constructor([*Array* data])

Creates a new list instance.
```javascript
var list = new List([1, 2]);
console.log(list instanceof List);
// true
```

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#listconstructorarray-data)

### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) List::onChange(*Any* oldValue, [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) index)

Signal called on each value change.

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#signal-listonchangeany-oldvalue-integer-index)

### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) List::onInsert(*Any* value, [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) index)

Signal called when a value was added.

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#signal-listoninsertany-value-integer-index)

### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) List::onPop(*Any* oldValue, [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) index)

Signal called when a value was removed.

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#signal-listonpopany-oldvalue-integer-index)

### ReadOnly [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) List::length

Amount of values stored in the list.
```javascript
var list = new List(['a', 'b']);
console.log(list.length);
// 2
```

### *Any* List::set([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) index, *Any* value)

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

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#any-listsetinteger-index-any-value)

### *Any* List::append(*Any* value)

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

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#any-listappendany-value)

### *Any* List::insert([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) index, *Any* value)

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

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#any-listinsertinteger-index-any-value)

### [*List*](/Neft-io/neft/wiki/List-API.md#class-list) List::extend([*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) items)

Appends all values stored in the given items into the list.
Calls `onInsert()` signal for each value.

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#list-listextendobject-items)

### *Any* List::remove(*Any* value)

Removes the given value from the list.
Calls `onPop()` signal.
```javascript
var list = new List(['a', 'b']);
console.log(list[1]);
// b
list.remove('b');
console.log(list[1]);
// undefined
console.log(list);
// ['a']
```

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#any-listremoveany-value)

### *Any* List::pop([[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) index])

Removes the value stored in the list under the given index.
The index must exists in the list.
Calls `onPop()` signal.
```javascript
var list = new List(['a', 'b']);
console.log(list[1]);
// b
list.pop(1);
console.log(list[1]);
// undefined
console.log(list);
// ['a']
```

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#any-listpopinteger-index)

### List::clear()

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

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#listclear)

### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) List::index(*Any* value)

Returns the given value index in the list.
Returns `-1` if the value doesn't exist in the list.
```javascript
var list = new List(['a', 'b']);
console.log(list.index('b'));
// 1
console.log(list.index('c'));
// -1
```

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#integer-listindexany-value)

### *Boolean* List::has(*Any* value)

Returns `true` if the given value exists in the list.
```javascript
var list = new List(['a', 'b']);
console.log(list.has('a'));
// true
console.log(list.has('ab123'));
// false
```

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#boolean-listhasany-value)

### *Array* List::toArray()

> [`Source`](/Neft-io/neft/tree/master/src/list/index.litcoffee#array-listtoarray)

## Glossary

- [List](#class-list)

