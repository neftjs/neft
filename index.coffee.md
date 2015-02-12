List
====

**Powerful array**

As you know, `Array`s are list-like objects in JavaScript.

This helper replaces poor `Array` `API` and brings signals called when something change.

Unfortunately, you have to use `get()` and `set()` methods to manipulate elements in a list.

```
var List = require('list');
```

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	signal = require 'signal'

*List* List([*Any* data...])
----------------------------

Creates new *list* based on the *given* elements.

```
var list = new List([1, 2]);

console.log(list instanceof List);
// true
```

#### Arguments notation

It's allowed to pass elements as an arguments.

```
var list = new List(1, 2);
```

#### *new* keyword

Using *new* keyword is not required.

```
var list = List([1, 2]);
```

	module.exports = class List

		@__name__ = 'List'
		@__path__ = 'List'

		constructor: ->

			arr = arguments[0]
			if arguments.length > 1 or not Array.isArray arr
				arr = []
				arr[i] = arg for arg, i in arguments
			
			unless @ instanceof List
				return new List arr

			# properties
			# TODO: mark as not enumerable (toJSON must be added)
			utils.defineProperty @, '_data', utils.ENUMERABLE, arr

		# List is not a standard Array object
		utils.defineProperty @::, '0', null, ->
			throw "You can't get elements from a list as standard properties; " +
			      "use `List::get()` method instead"
		, ->
			throw "You can't set elements into a list as standard properties; " +
			      "use `List::set()` method instead"

*Signal* List::changed(*Any* oldValue, *Integer* index)
-------------------------------------------------------

**Signal** called on each element value change.

Use ***onChanged*** handler to listen on signals.

		signal.createLazy @::, 'changed'

*Signal* List::inserted(*Any* value, *Integer* index)
-----------------------------------------------------

**Signal** called on each element insert.

Use ***onInserted*** handler to listen on signals.

		signal.createLazy @::, 'inserted'

*Signal* List::popped(*Any* oldValue, *Integer* index)
------------------------------------------------------

**Signal** called on each element pop.

Use ***onPopped*** handler to listen on signals.

		signal.createLazy @::, 'popped'

*Integer* List::length
----------------------

Number of elements in a list.

This property is **read-only**.

```
var list = new List('a', 'b');

console.log(list.length);
// 2
```

		desc = utils.CONFIGURABLE | utils.ENUMERABLE
		utils.defineProperty @::, 'length', desc, ->
			@_data.length
		, null

*Any* List::get(*Integer* index)
--------------------------------

Returns **value** of the element stored at given *index*.

For unknown elements, `undefined` is returned.

```
var list = new List('a', 'b');

console.log(list.get(0));
// a

console.log(list.get(1));
// b

console.log(list.get(2));
// undefined
```

		get: (i) ->
			expect(i).not().toBe.lessThan 0

			@_data[i]

*Any* List::set(*Integer* index, *Any* value)
---------------------------------------------

Changes element *value*.

Element at given *index* must be stored in a list.

`List::changed()` signal is called with the given *index* and overriden element *value*.

Given *value* is returned as a **result**.

```
var types = new List('fantasy', 'Thriller');

types.onChanged.connect(function(oldVal, i){
  console.log("Element "+oldVal+" changed to "+this.get(i));
});

types.set(0, 'Fantasy');
// Element fantasy changed to Fantasy

types.set(0, 'Fantasy');
// nothing changed ...
```

		set: (i, val) ->
			expect(i).not().toBe.lessThan 0
			expect(i).toBe.lessThan @length
			expect(val).not().toBe undefined

			oldVal = @_data[i]
			if oldVal is val
				return val

			@_data[i] = val

			# signal
			@changed? oldVal, i

			val

*Array* List::items()
---------------------

Returns array of all the elements stored in a list.

Always the same instance is returned, so don't change this array manually.
Use `utils.clone()` otherwise.

```
var list = new List(1, 2);

console.log(list.items());
// [1, 2]

console.log(Array.isArray(list.items()));
// true
```

#### Iterating over a list
```
var list = new List('a', 'b');
var items = list.items();
for (var i = 0, n = items.length; i < n; i++){  
  console.log(items[i]);
}
// a
// b
```

		items: ->
			@_data

*Any* List::append(*Any* value)
-------------------------------

Append new element at the end of a list.

`List::inserted()` signal is called with the element *index* and given *value*.

*value* can't be a `undefined`, because this value is reserved only for unknown elements.

```
var fridge = new List('apple', 'milk');

fridge.onInserted.connect(function(val, i){
  console.log(val+" appended!");
});

fridge.append('cheese');
// cheese appended!

console.log(fridge.items());
// apple, milk, cheese
```

		append: (val) ->
			expect(val).not().toBe undefined

			@_data.push val

			# signal
			@inserted? val, @length - 1

			val

*Any* List::insert(*Integer* index, *Any* value)
------------------------------------------------

Inserts new element at given position.

Added value is returned.

`List::inserted()` signal is called with parameters passed to this function.

```
var list = new List('a', 'b');

list.onInserted.connect(function(val, i){
  console.log("New element "+val+" inserted at index "+i);
});

list.insert(1, 'c');
// New element c inserted at index 1

console.log(list.items());
// ['a', 'c', 'b']
```

		insert: (i, val) ->
			expect(i).not().toBe.lessThan 0
			expect(i).not().toBe.greaterThan @length
			expect(val).not().toBe undefined

			@_data.splice i, 0, val

			# signal
			@inserted? val, i

			val

*Any* List::remove(*Any* value)
-------------------------------

Removes given *value* from a list.

`List::popped()` signal is called with the popped element *index* as a parameter.

Given *value* is returned.

```
var list = new List('a', 'b');

console.log(list.get(1));
// b

list.remove('b');
console.log(list.get(1));
// undefined

console.log(list.items());
// ['a']
```

		remove: (val) ->
			expect().some(@_data).toBe val

			i = @index val
			if i isnt -1
				@pop i

			val

*Any* List::pop([*Integer* index])
----------------------------------

Removes element at given *index*, or the last element by default.

Given *index* must exists in the list.

`List::popped()` signal is called with the popped element *value* and it's *index*.

Removed element is returned.

```
var list = new List('a', 'b');

console.log(list.get(1));
// b

list.pop(1);
console.log(list.get(1));
// undefined

console.log(list.items());
// ['a']
```

		pop: (i) ->
			if i isnt undefined
				expect(i).not().toBe.lessThan 0
				expect(i).toBe.lessThan @length

			i ?= @length - 1
			oldVal = @_data[i]

			@_data.splice i, 1

			# signal
			@popped? oldVal, i

			oldVal

List::clear()
-------------

Removes all elements stored in a list.

Notice that this method will call `List::popped()` signal on each element.

```
var list = new List('a', 'b');

list.onPopped.connect(function(oldVal, i){
  console.log("Element "+oldVal+" popped!");
});

console.log(list.items());
// ['a', 'b']

list.clear()
// Element b popped!
// Element a popped!

console.log(list.items());
// []
```

		clear: ->
			while @_data.length 
				@pop()

			null

*Integer* List::index(*Any* value)
----------------------------------

Returns index of the given value in a list.

Given value can't be a `undefined`, becuase it's used for unknown elements.

If no value exists in this list `-1` is returned.

```
var list = new List('a', 'b');

console.log(list.index('b'));
// 1

console.log(list.index('c'));
// -1
```

		index: (val) ->
			expect(val).not().toBe undefined

			@_data.indexOf val

*Boolean* List::has(*Any* value)
--------------------------------

Returns true if given *value* exists in a list.

```
var list = new List('a', 'b');

console.log(list.has('a'));
// true

console.log(list.has('ab123'));
// false
```

		has: (val) ->
			@index(val) isnt -1
