Dict
====

@requires utils

Basics helper which has been made to extends functionalitites of the default JavaScript.

It's similar to the Python Dict helper and was designed on it, but brings a little bit more.

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	signal = require 'signal'

	module.exports = class Dict

		@__name__ = 'Dict'
		@__path__ = 'Dict'

		KEYS = 1<<0
		VALUES = 1<<1
		ITEMS = 1<<2
		ALL = (ITEMS<<1) - 1

*Dict* Dict.fromJSON(*String|Object* json)
------------------------------------------

Creates new *Dict* from the json.

See `Dict::toJSON` to see how to stringify a *Dict* instance and use it here.

		@fromJSON = (json) ->
			json = utils.tryFunction JSON.parse, JSON, [json], json
			expect(json).toBe.simpleObject()

			new Dict json

*Dict* Dict([*Object* data])
----------------------------

Creates new *Dict* instance.

*data* parameter determines default properties with their values.

Using *new* keyword is not required.

```
var data = new Dict({
  name: 'xyz'
});

console.log(data.get('name'));
// xyz
```

		constructor: (obj={}) ->
			expect(obj).toBe.object()

			# support no `new` syntax
			unless @ instanceof Dict
				return new Dict obj

			# properties
			utils.defineProperty @, '__hash__', null, utils.uid()
			utils.defineProperty @, '_data', null, obj
			utils.defineProperty @, '_keys', utils.WRITABLE, null
			utils.defineProperty @, '_values', utils.WRITABLE, null
			utils.defineProperty @, '_items', utils.WRITABLE, null
			utils.defineProperty @, '_dirty', utils.WRITABLE, ALL

*Integer* Dict::length
----------------------

Returns amount of the keys stored in the *Dict* instance.

This value can't be changed manually.

		desc = utils.CONFIGURABLE | utils.ENUMERABLE
		utils.defineProperty @::, 'length', desc, ->
			@keys().length
		, null

*Signal* Dict::changed(*String* key, *Any* oldValue)
----------------------------------------------------

Lazy **signal** called on each property value change.

You can listen on this signal using the `onChanged` handler.

```
var user = new Dict({
  country: 'Germany'
});

user.onChanged.connect(function(key, oldVal){
  console.log(key + " property changed from " + oldVal + " to " + this.get(key));
});

user.set('country', 'US');
// country property changed from Germany to US
```

		signal.createLazy @::, 'changed'

*Any* Dict::get(*String* key)
-----------------------------

Get a property value stored in the *Dict*.

Returns *undefined* only for unknown properties.

```
var bunny = new Dict({
  speedX: 5,
  speedY: 2
});

console.log(bunny.get('speedX'));
// 5

console.log(bunny.get('speedY'));
// 2

console.log(bunny.get('speedZ'));
// undefined
```

		get: (key) ->
			expect(key).toBe.truthy().string()

			@_data[key]

*Any* Dict::set(*String* key, *Any* value)
------------------------------------------

Change the property value or create a new property.

Calls `Dict::changed()` **signal** if the value is different than before.
This signal is called with two parameters *key* and *oldValue*.

Passed *value* can't be a `undefined`, because it's used only for unknown properties.

Given *value* is returned as a **result**.

```
var links = new Dict({
  facebook: 'https://facebook.com/neft.io',
  twitter: 'https://twitter.com/neft_io'
});

links.onChanged.connect(function(key, oldVal){
  console.log(key + " changed from " + oldVal + " to " + this.get(key));
});

links.set('googlePlus', 'https://plus.google.com/+NeftIo-for-apps/');
// googlePlus changed from undefined to https://...
```

		set: (key, val) ->
			expect(key).toBe.truthy().string()
			expect(val).not().toBe undefined

			oldVal = @_data[key]

			# break if value didn't change
			if oldVal is val
				return @

			# update value
			@_data[key] = val

			# dirty
			@_dirty |= ALL

			# signal
			@changed? key, oldVal

			val

Dict::pop(*String* key)
-----------------------

Remove exists property from the *Dict*.

This method calls `Dict::changed()` **signal** with standard parameters.

```
var data = new Dict;

data.set('name', 'John');

data.onChanged.connect(function(key, oldVal){
  if (this.get(key) === undefined){
    console.log(key + " property has been removed");
  }
});

data.pop('name');
// name property has been rmeoved
```

		pop: (key) ->
			expect(key).toBe.truthy().string()
			expect().some().keys(@_data).toBe key

			oldVal = @_data[key]
			delete @_data[key]

			# dirty
			@_dirty |= ALL

			# signal
			@changed? key, oldVal

			null

*Array* Dict::keys()
--------------------

Returns array of the existed properties names in the *Dict*.

It always returns the same array, so don't modify it manually.
Use `utils.clone()` otherwise.

```
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
				for key of @_data
					arr[i] = key
					i++

				arr.length = i

			@_keys

*Array* Dict::values()
----------------------

Returns array of the existed properties values in the *Dict*.

It always returns the same array, so don't modify it manually.
Use `utils.clone()` otherwise.

```
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
				for key, val of @_data
					arr[i] = val
					i++

				arr.length = i

			@_values

*Array* Dict::items()
---------------------

Returns array of key-value pairs of all existed properties.

It always returns the same arrays, so don't modify it manually.
Use `utils.clone()` otherwise.

```
var data = new Dict({
  x: 10,
  y: 30
});

console.log(data.items());
// [['x', 10], ['y', 30]]
```

		items: ->
			if @_dirty & ITEMS
				arr = @_values ?= []

				i = 0
				for key, val of @_data
					arr[i] ?= ['', null]
					arr[i][0] = key
					arr[i][1] = val
					i++

				arr.length = i

			@_values

*Object* Dict::toJSON()
-----------------------

Returns an object which can be stringified to JSON.

Check `Dict.fromJSON` to reverse this operation.

		toJSON: ->
			@_data

*String* Dict::toString()
-------------------------

Returns pseudo-unique string determining this *Dict* instance.

		toString: ->
			@__hash__
