Dict @library
====

**Powerful object**

This helper replaces *Object* API and adds new features and signal called on each change.

Unfortunately, you have to use *get()* and *set()* methods
to extract or change properties in a dict.

Access it with:
```
var dict = require('dict');
```

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'

	module.exports = class Dict extends signal.Emitter
		@__name__ = 'Dict'
		@__path__ = 'Dict'

		KEYS = 1<<0
		VALUES = 1<<1
		ITEMS = 1<<2
		ALL = (ITEMS<<1) - 1

*Dict* Dict.fromJSON(*String|Object* json)
------------------------------------------

Creates new *Dict* from a json.

See *Dict::toJSON* to check how to stringify a *Dict* instance and use it here.

		@fromJSON = (json) ->
			json = utils.tryFunction JSON.parse, JSON, [json], json
			assert.isPlainObject json

			new Dict json

*Dict* Dict([*Object* data])
----------------------------

Creates a new *Dict* instance.

*data* parameter determines default properties with their values.

*new* keyword is not required.

```
var data = new Dict({
  name: 'xyz'
});

console.log(data.get('name'));
// xyz
```

		constructor: (obj={}) ->
			# support no `new` syntax
			unless @ instanceof Dict
				return new Dict obj

			assert.isObject obj

			super()
			@__hash__ = utils.uid()
			@_data = obj
			@_keys = null
			@_values = null
			@_items = null
			@_dirty = ALL

			Object.preventExtensions @

ReadOnly *Integer* Dict::length
-------------------------------

This property stores amount of keys existed in a *Dict*.

```
var dict = Dict({prop: 1});

console.log(dict.length);
// 1
```

		desc = utils.CONFIGURABLE | utils.ENUMERABLE
		utils.defineProperty @::, 'length', desc, ->
			@keys().length
		, null

*Signal* Dict::changed(*String* key, *Any* oldValue)
----------------------------------------------------

This signal is called when a property value changes.

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

		signal.Emitter.createSignal @, 'changed'

*Any* Dict::get(*String* key)
-----------------------------

This method returns given *key* property value.

It returns *undefined* only for not existed properties.

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
			assert.isString key
			assert.notLengthOf key, 0

			@_data[key]

*Any* Dict::set(*String* key, *Any* value)
------------------------------------------

This method is used to change property value or create a new property.

*changed()* signal is called if the value has been changed.

Passed *value* can't be a *undefined*,
because this value is reserved only for unknown properties.

Given *value* is returned as a result of this method.

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
			assert.isString key
			assert.notLengthOf key, 0
			assert.isNot val, undefined

			oldVal = @_data[key]

			# break if value didn't change
			if oldVal is val
				return @

			# update value
			@_data[key] = val

			# dirty
			@_dirty |= ALL

			# signal
			@changed key, oldVal

			val

Dict::pop(*String* key)
-----------------------

This method removes an existing property from a *dict*.

*changed()* signal is called with property key and its old value.

```
var data = new Dict;

data.set('name', 'John');

data.onChanged.connect(function(key, oldVal){
  if (this.get(key) === undefined){
    console.log(key + " property has been removed");
  }
});

data.pop('name');
// name property has been removed
```

		pop: (key) ->
			assert.isString key
			assert.notLengthOf key, 0
			assert.isNot @_data[key], undefined

			oldVal = @_data[key]
			delete @_data[key]

			# dirty
			@_dirty |= ALL

			# signal
			@changed key, oldVal

			return

*Array* Dict::keys()
--------------------

This method returns array of names of stored properties.

It always returns the same array instance, so don't modify it manually.
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

This method returns array of values of stored properties.

It always returns the same array instance, so don't modify it manually.
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

This method returns array of key-value pairs of all stored properties.

It always returns the same array instance, so don't modify it manually.
Use `utils.clone()` otherwise.

```
var data = new Dict({
  x: 10,
  y: 30
});

console.log(data.items());
// [['x', 10], ['y', 30]]
```

#### Iterating over a dict
```
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
				for key, val of @_data
					arr[i] ?= ['', null]
					arr[i][0] = key
					arr[i][1] = val
					i++

				arr.length = i

			@_values

*Object* Dict::toJSON()
-----------------------

This method returns object ready to be stringified to JSON.

Check *Dict.fromJSON* to reverse this operation.

		toJSON: ->
			@_data

*String* Dict::toString()
-------------------------

This method returns a pseudo-unique string determining this *Dict* instance.

		toString: ->
			@__hash__
