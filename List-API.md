> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **List**

# List

> data-binding on arrays
Access it with:
```javascript
const { List } = Neft;
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#list)

## Table of contents
* [List](#list)
* [**Class** List](#class-list)
  * [constructor](#constructor)
  * [onChange](#onchange)
  * [onInsert](#oninsert)
  * [onPop](#onpop)
  * [length](#length)
  * [set](#set)
  * [append](#append)
  * [insert](#insert)
  * [extend](#extend)
  * [remove](#remove)
  * [pop](#pop)
  * [clear](#clear)
  * [index](#index)
  * [has](#has)
  * [toArray](#toarray)
* [Glossary](#glossary)

# **Class** List

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#class-list)

##constructor
<dl><dt>Syntax</dt><dd><code>List::constructor([&#x2A;Array&#x2A; data])</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>data — <i>Array</i> — <i>optional</i></li></ul></dd></dl>
Creates a new list instance.
```javascript
var list = new List([1, 2]);
console.log(list instanceof List);
// true
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#constructor)

##onChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; List::onChange(&#x2A;Any&#x2A; oldValue, &#x2A;Integer&#x2A; index)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Any</i></li><li>index — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Signal called on each value change.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#onchange)

##onInsert
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; List::onInsert(&#x2A;Any&#x2A; value, &#x2A;Integer&#x2A; index)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>index — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Signal called when a value was added.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#oninsert)

##onPop
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; List::onPop(&#x2A;Any&#x2A; oldValue, &#x2A;Integer&#x2A; index)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Any</i></li><li>index — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Signal called when a value was removed.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#onpop)

##length
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Integer&#x2A; List::length</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd><dt>Read only</dt></dl>
Amount of values stored in the list.
```javascript
var list = new List(['a', 'b']);
console.log(list.length);
// 2
```

##set
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; List::set(&#x2A;Integer&#x2A; index, &#x2A;Any&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>index — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#set)

##append
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; List::append(&#x2A;Any&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#append)

##insert
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; List::insert(&#x2A;Integer&#x2A; index, &#x2A;Any&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>index — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#insert)

##extend
<dl><dt>Syntax</dt><dd><code>&#x2A;List&#x2A; List::extend(&#x2A;Object&#x2A; items)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>items — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd></dl>
Appends all values stored in the given items into the list.
Calls `onInsert()` signal for each value.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#extend)

##remove
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; List::remove(&#x2A;Any&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#remove)

##pop
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; List::pop([&#x2A;Integer&#x2A; index])</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>index — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#pop)

##clear
<dl><dt>Syntax</dt><dd><code>List::clear()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#clear)

##index
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; List::index(&#x2A;Any&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
Returns the given value index in the list.
Returns `-1` if the value doesn't exist in the list.
```javascript
var list = new List(['a', 'b']);
console.log(list.index('b'));
// 1
console.log(list.index('c'));
// -1
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#index)

##has
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; List::has(&#x2A;Any&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the given value exists in the list.
```javascript
var list = new List(['a', 'b']);
console.log(list.has('a'));
// true
console.log(list.has('ab123'));
// false
```

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#has)

##toArray
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; List::toArray()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/list/index.litcoffee#toarray)

# Glossary

- [List](#class-list)

