List @library
====

**Powerful array**

This helper replaces *Array* API and adds new features,
like signals called on each change.

Unfortunately, you have to use *get()* and *set()* methods
to extract or change element in a list.

Access it with:
```
var List = require('list');
```

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'

*List* List([*Array* data])
---------------------------

Creates a new list.

*new* keyword is optional.

```
var list = new List([1, 2]);
console.log(list instanceof List);
// true
```

	module.exports = class List extends signal.Emitter
		@__name__ = 'List'
		@__path__ = 'List'

		constructor: (arr=[]) ->
			assert.isArray arr

			unless @ instanceof List
				return new List arr

			signal.Emitter.call @
			@_data = arr

		# List is not a standard Array object
		utils.defineProperty @::, '0', null, ->
			throw "You can't get elements from a list as standard properties; " +
			      "use `List::get()` method instead"
		, ->
			throw "You can't set elements into a list as standard properties; " +
			      "use `List::set()` method instead"

*Signal* List::changed(*Any* oldValue, *Integer* index)
-------------------------------------------------------

This signal is called for each element value change.

		signal.Emitter.createSignal @, 'changed'

*Signal* List::inserted(*Any* value, *Integer* index)
-----------------------------------------------------

This signal is called for each inserted element.

		signal.Emitter.createSignal @, 'inserted'

*Signal* List::popped(*Any* oldValue, *Integer* index)
------------------------------------------------------

This signal is called for each popped element.

		signal.Emitter.createSignal @, 'popped'

ReadOnly *Integer* List::length
-------------------------------

This property stores number of elements in a list.

```
var list = new List(['a', 'b']);

console.log(list.length);
// 2
```

		desc = utils.CONFIGURABLE
		utils.defineProperty @::, 'length', desc, ->
			@_data.length
		, null

*Any* List::get(*Integer* index)
--------------------------------

This method returns element stored at given *index*.

For unknown elements, *undefined* is returned.

```
var list = new List(['a', 'b']);

console.log(list.get(0));
// a

console.log(list.get(1));
// b

console.log(list.get(2));
// undefined
```

		get: (i) ->
			assert.operator i, '>=', 0

			@_data[i]

*Any* List::set(*Integer* index, *Any* value)
---------------------------------------------

This method changes element value.

Element at given *index* must be stored in a list.

*changed()* signal is called with overriden element *value* and given *index*.

Given *value* is returned by this method.

```
var types = new List(['fantasy', 'Thriller']);

types.onChanged.connect(function(oldVal, i){
  console.log("Element "+oldVal+" changed to "+this.get(i));
});

types.set(0, 'Fantasy');
// Element fantasy changed to Fantasy

types.set(0, 'Fantasy');
// nothing changed ...
```

		set: (i, val) ->
			assert.operator i, '>=', 0
			assert.operator i, '<', @length
			assert.isNot val, undefined

			oldVal = @_data[i]
			if oldVal is val
				return val

			@_data[i] = val

			# signal
			@changed oldVal, i

			val

*Array* List::items()
---------------------

This method returns array of all the elements stored in a list.

Always the same instance is returned, so don't change this array manually.

Use `utils.clone()` otherwise.

```
var list = new List([1, 2]);

console.log(list.items());
// [1, 2]

console.log(Array.isArray(list.items()));
// true
```

#### Iterating over a list
```
var list = new List(['a', 'b']);
var items = list.items();
for (var i = 0; i < items.length; i++){  
  console.log(items[i]);
}
// a
// b
```

		items: ->
			@_data

*Any* List::append(*Any* value)
-------------------------------

This method appends new element at the end of a list.

*inserted()* signal is called with the given *value* and element *index*.

*value* can't be an `undefined`, because this value is reserved only for unknown elements.

```
var fridge = new List(['apple', 'milk']);

fridge.onInserted.connect(function(val, i){
  console.log(val+" appended!");
});

fridge.append('cheese');
// cheese appended!

console.log(fridge.items());
// apple, milk, cheese
```

		append: (val) ->
			assert.isNot val, undefined

			@_data.push val

			# signal
			@inserted val, @length - 1

			val

*Any* List::insert(*Integer* index, *Any* value)
------------------------------------------------

This method inserts a new element at the given position.

*inserted()* signal is called with given value and index.

Given *value* is returned.

```
var list = new List(['a', 'b']);

list.onInserted.connect(function(val, i){
  console.log("New element "+val+" inserted at index "+i);
});

list.insert(1, 'c');
// New element c inserted at index 1

console.log(list.items());
// ['a', 'c', 'b']
```

		insert: (i, val) ->
			assert.operator i, '>=', 0
			assert.operator i, '<', @length
			assert.isNot val, undefined

			@_data.splice i, 0, val

			# signal
			@inserted val, i

			val

*Any* List::remove(*Any* value)
-------------------------------

This function removes given *value* from a list.

*popped()* signal is called with the given *value* and popped element *index*.

Given *value* is returned.

```
var list = new List(['a', 'b']);

console.log(list.get(1));
// b

list.remove('b');
console.log(list.get(1));
// undefined

console.log(list.items());
// ['a']
```

		remove: (val) ->
			assert.ok utils.has(@_data, val)

			i = @index val
			if i isnt -1
				@pop i

			val

*Any* List::pop([*Integer* index])
----------------------------------

This method removes element store at given *index*,
or the last element if no parameter passed.

Given *index* must exist in the list.

*popped()* signal is called with the popped element *value* and it's *index*.

The removed element value is returned.

```
var list = new List(['a', 'b']);

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
				assert.operator i, '>=', 0
				assert.operator i, '<', @length
			else
				i = @length - 1

			oldVal = @_data[i]
			@_data.splice i, 1

			# signal
			@popped oldVal, i

			oldVal

List::clear()
-------------

This method removes all elements stored in a list.

*popped()* signal is called on each element starting from the last one.

```
var list = new List(['a', 'b']);

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

This method returns index of the given element *value* in a list.

Given value can't be an `undefined`, because this value is reserved only for unknown elements.

If no value exists in a list, *-1* is returned.

```
var list = new List(['a', 'b']);

console.log(list.index('b'));
// 1

console.log(list.index('c'));
// -1
```

		index: (val) ->
			assert.isNot val, undefined

			@_data.indexOf val

*Boolean* List::has(*Any* value)
--------------------------------

This method checks whether given *value* exists in a list.

```
var list = new List(['a', 'b']);

console.log(list.has('a'));
// true

console.log(list.has('ab123'));
// false
```

		has: (val) ->
			@index(val) isnt -1

*Array* List::toJSON()
----------------------

		toJSON: ->
			@_data

*String* List::toString()
-------------------------

		toString: ->
			@__hash__
