Dict @library
=============

Module used for data-binding on objects.

Access it with:
```javascript
var dict = require('dict');
```

	'use strict'

	utils = require 'neft-utils'
	assert = require 'neft-assert'
	signal = require 'neft-signal'

	module.exports = class Dict extends signal.Emitter
		@__name__ = 'Dict'
		@__path__ = 'Dict'

		KEYS = 1<<0
		VALUES = 1<<1
		ITEMS = 1<<2
		ALL = (ITEMS<<1) - 1

*Dict* Dict.fromJSON(*String|Object* json)
------------------------------------------

Creates a new *Dict* from a json string.

This function should be used with [toJSON()][dict/Dict::toJSON()] output.

		@fromJSON = (json) ->
			json = utils.tryFunction JSON.parse, JSON, [json], json
			assert.isPlainObject json

			new Dict json

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

		constructor: (obj) ->
			# support no `new` syntax
			unless @ instanceof Dict
				return new Dict obj

			if obj?
				assert.isObject obj

			super()

			utils.defineProperty @, '_signals', utils.WRITABLE, @_signals
			utils.defineProperty @, '_keys', utils.WRITABLE, null
			utils.defineProperty @, '_values', utils.WRITABLE, null
			utils.defineProperty @, '_items', utils.WRITABLE, null
			utils.defineProperty @, '_dirty', utils.WRITABLE, ALL

			if utils.isObject(obj)
				utils.merge this, obj

ReadOnly *Integer* Dict::length
-------------------------------

Amount of keys stored in a dict.

```javascript
var dict = Dict({prop: 1});

console.log(dict.length);
// 1
```

		desc = utils.CONFIGURABLE | utils.ENUMERABLE
		utils.defineProperty @::, 'length', desc, ->
			@keys().length
		, null

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

		signal.Emitter.createSignal @, 'onChange'

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

		set: (key, val) ->
			assert.isString key
			assert.notLengthOf key, 0
			assert.isNot val, undefined

			oldVal = @[key]

			# break if value didn't change
			if oldVal is val
				return val

			# update value
			@[key] = val

			# dirty
			@_dirty |= ALL

			# signal
			@onChange.emit key, oldVal

			val

*Boolean* Dict::has(*String* key)
---------------------------------

Returns `true` if the given key exists in the dict.

		has: (key) ->
			assert.isString key
			assert.notLengthOf key, 0

			@[key] isnt undefined

*Dict* Dict::extend(*Object|Dict* object)
-----------------------------------------

Sets all keys with their values from the given object.

Calls [onChange()][dict/Dict::onChange()] signal for each key.

		extend: (obj) ->
			assert.isObject obj

			for key, val of obj
				if obj.hasOwnProperty(key)
					@set key, val

			@

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
    console.log(key + " property has been removed");
  }
});

data.pop('name');
// name property has been removed
```

		pop: (key) ->
			assert.isString key
			assert.notLengthOf key, 0
			assert.isNot @[key], undefined

			oldVal = @[key]
			@[key] = undefined

			# dirty
			@_dirty |= ALL

			# signal
			@onChange.emit key, oldVal

			oldVal

Dict::clear()
-------------

Removes all stored keys from the dict.

Calls [onChange()][dict/Dict::onChange()] signal for each stored key.

		clear: ->
			for key, val of this
				if @hasOwnProperty(key) and val isnt undefined
					@pop key

			return

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

		keys: ->
			if @_dirty & KEYS
				@_dirty ^= KEYS
				arr = @_keys ?= []

				i = 0
				for key, val of @
					if @hasOwnProperty(key) and val isnt undefined
						arr[i] = key
						i++

				arr.length = i

			@_keys

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

		values: ->
			if @_dirty & VALUES
				@_dirty ^= VALUES
				arr = @_values ?= []

				i = 0
				for key, val of @
					if @hasOwnProperty(key) and val isnt undefined
						arr[i] = val
						i++

				arr.length = i

			@_values

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

		items: ->
			if @_dirty & ITEMS
				arr = @_values ?= []

				i = 0
				for key, val of @
					if @hasOwnProperty(key) and val isnt undefined
						arr[i] ?= ['', null]
						arr[i][0] = key
						arr[i][1] = val
						i++

				arr.length = i

			@_values
