List @library
=============

Module used for data-binding on arrays.

Access it with:
```javascript
var List = require('list');
```

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	signal = require 'signal'

	module.exports = class List extends signal.Emitter
		@__name__ = 'List'
		@__path__ = 'List'

*List* List([*Array* data])
---------------------------

Creates a new list instance.

```javascript
var list = new List([1, 2]);
console.log(list instanceof List);
// true
```

		constructor: (arr=[]) ->
			assert.isArray arr

			unless @ instanceof List
				return new List arr

			super()
			@_data = arr

		# List is not a standard Array object
		utils.defineProperty @::, '0', null, ->
			throw "Can't get elements from a list as properties; " +
			      "use `List::get()` method instead"
		, ->
			throw "Can't set elements into a list with properties; " +
			      "use `List::set()` method instead"

*Signal* List::onChange(*Any* oldValue, *Integer* index)
--------------------------------------------------------

Signal called on each value change.

		signal.Emitter.createSignal @, 'onChange'

*Signal* List::onInsert(*Any* value, *Integer* index)
-----------------------------------------------------

Signal called when a value was added.

		signal.Emitter.createSignal @, 'onInsert'

*Signal* List::onPop(*Any* oldValue, *Integer* index)
-----------------------------------------------------

Signal called when a value was removed.

		signal.Emitter.createSignal @, 'onPop'

ReadOnly *Integer* List::length
-------------------------------

Amount of values stored in the list.

```javascript
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

Returns the value under the given index.

Returns `undefined` for unknown index.

The index can't be negative.

```javascript
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

Sets the given value under the given index.

The index must exists in the list.

The value can't be an `undefined`. Use [pop()][list/List::pop()] instead.

Calls [onChange()][list/List::onChange()] signal.

```javascript
var types = new List(['fantasy', 'Thriller']);

types.onChange.connect(function(oldVal, i){
  console.log("element "+oldVal+" changed to "+this.get(i));
});

types.set(0, 'Fantasy');
// element fantasy changed to Fantasy

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
			@onChange.emit oldVal, i

			val

*Array* List::items()
---------------------

Returns ar array of the stored values in the list.

Always returns the same array instance.

```javascript
var list = new List([1, 2]);

console.log(list.items());
// [1, 2]

console.log(Array.isArray(list.items()));
// true
```

### Iterate over a list
```javascript
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

		append: (val) ->
			assert.isNot val, undefined

			@_data.push val

			# signal
			@onInsert.emit val, @length - 1

			val

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

		insert: (i, val) ->
			assert.operator i, '>=', 0
			assert.operator i, '<=', @length
			assert.isNot val, undefined

			@_data.splice i, 0, val

			# signal
			@onInsert.emit val, i

			val

*List* List::extend(*List|Array* items)
---------------------------------------

Appends all values stored in the given items into the list.

Calls [onInsert()][list/List::onInsert()] signal for each value.

		extend: (items) ->
			if items instanceof List
				arr = items.items()
			else
				arr = items

			assert.isArray arr

			for val in arr
				@append val

			items

*Any* List::remove(*Any* value)
-------------------------------

Removes the given value from the list.

Calls [onPop()][list/List::onPop()] signal.

```javascript
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

Removes the value stored in the list under the given index.

The index must exists in the list.

Calls [onPop()][list/List::onPop()] signal.

```javascript
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
			if i is undefined
				i = @length - 1
			assert.operator i, '>=', 0
			assert.operator i, '<', @length

			oldVal = @_data[i]
			@_data.splice i, 1

			# signal
			@onPop.emit oldVal, i

			oldVal

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

console.log(list.items());
// []
```

		clear: ->
			while @_data.length
				@pop()

			null

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

		index: (val) ->
			assert.isNot val, undefined

			@_data.indexOf val

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

		has: (val) ->
			@index(val) isnt -1

*Array* List::toJSON()
----------------------

		toJSON: ->
			@_data

*String* List::toString()
-------------------------

		toString: ->
			@_data+''
