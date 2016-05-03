List @library
=============

Module used for data-binding on arrays.

Access it with:
```javascript
var List = require('list');
```

*List* List([*Array* data])
---------------------------

Creates a new list instance.

```javascript
var list = new List([1, 2]);
console.log(list instanceof List);
// true
```

*Signal* List::onChange(*Any* oldValue, *Integer* index)
--------------------------------------------------------

Signal called on each value change.

*Signal* List::onInsert(*Any* value, *Integer* index)
-----------------------------------------------------

Signal called when a value was added.

*Signal* List::onPop(*Any* oldValue, *Integer* index)
-----------------------------------------------------

Signal called when a value was removed.

ReadOnly *Integer* List::length
-------------------------------

Amount of values stored in the list.

```javascript
var list = new List(['a', 'b']);

console.log(list.length);
// 2
```

*Any* List::set(*Integer* index, *Any* value)
---------------------------------------------

Sets the given value under the given index.

The index must exists in the list.

The value can't be an `undefined`. Use [pop()][list/List::pop()] instead.

Calls [onChange()][list/List::onChange()] signal.

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

*Any* List::append(*Any* value)
-------------------------------

Adds the given value on the end on the list.

The value can't be an `undefined`.

Calls [onInsert()][list/List::onInsert()] signal.

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

*Any* List::insert(*Integer* index, *Any* value)
------------------------------------------------

Add the given value under the given index.

The index can't be greater than the list length.

The value can't be an `undefined`.

Calls [onInsert()][list/List::onInsert()] signal.

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

*List* List::extend(*Object* items)
-----------------------------------

Appends all values stored in the given items into the list.

Calls [onInsert()][list/List::onInsert()] signal for each value.

*Any* List::remove(*Any* value)
-------------------------------

Removes the given value from the list.

Calls [onPop()][list/List::onPop()] signal.

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

*Any* List::pop([*Integer* index])
----------------------------------

Removes the value stored in the list under the given index.

The index must exists in the list.

Calls [onPop()][list/List::onPop()] signal.

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

List::clear()
-------------

Removes all values stored in the list.

Calls [onPop()][list/List::onPop()] signal for each value.

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

*Integer* List::index(*Any* value)
----------------------------------

Returns the given value index in the list.

Returns `-1` if the value doesn't exist in the list.

```javascript
var list = new List(['a', 'b']);

console.log(list.index('b'));
// 1

console.log(list.index('c'));
// -1
```

*Boolean* List::has(*Any* value)
--------------------------------

Returns `true` if the given value exists in the list.

```
var list = new List(['a', 'b']);

console.log(list.has('a'));
// true

console.log(list.has('ab123'));
// false
```

*Array* List::toArray()
-----------------------

