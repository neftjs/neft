Dict
====

Basics helper which has been made to extends functionalitites of the default JavasScript.

It's similar to the Python Dict helper and was designed on it, but brings a little bit more.

	'use strict'

	[utils, expect, signal] = ['utils', 'expect', 'signal'].map require

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

See *Dict::toJSON* to see how to stringify a *Dict* instance and use it here.

		@fromJSON = (json) ->
			json = utils.tryFunc JSON.parse, JSON, [json], json
			expect(json).toBe.simpleObject()

			new Dict json

*String* Dict.getPropertySignalName(*String* propertyName)
----------------------------------------------------------

Returns name of the signal name, based on the property name.

By default this function adds into the property name *Changed* word.

Read more about signals on the *signal* module documentation and
check methods on this class which call signals.

To create signal handler name based on the signal name, check `signal.getHandlerName()`.

### Example

Dict.getPropertySignalName('name') // nameChanged
signal.getHandlerName('nameChanged') // onNameChanged

		@getPropertySignalName = do (cache = {}) -> (propName) ->
			expect(propName).toBe.truthy().string()

			if cache.hasOwnProperty propName
				cache[propName]
			else
				cache[propName] = "#{propName}Changed"

Dict.defineProperty(*NotPrimitive* prototype, *String* propertyName)
--------------------------------------------------------------------

Define new *Dict* custom property on the given *prototype*.

*Dict* properties are used for fast getting and setting properties in opposite to
use *Dict::get()* and *Dict::set()* methods.

Additionally, each setter calls special signal
which is determined by the *Dict.getPropertySignalName()*.

All created signals are *lazy* (see more in the *signal* module documentation page), so
it's can be easily used in the classes prototypes. Additionally it brings a little
optimization, because signal handlers without listeners are not created and called
on each property value change.

### Example

class Dog extends Dict
	constructor: ->
		super
			age: 4

	Dict.defineProperty @::, 'age'

myDog = new Dog

console.log(myDog.age) // 4

myDog.onAgeChanged.connect (oldVal) ->
	console.log "Age has been changed from #{oldVal} to #{@age}"

myDog.age++ // Age has been changed from 4 to 5

		@defineProperty = do ->
			createGetter = (propName) ->
				->
					Dict::get.call @, propName

			createSetter = (propName) ->
				signalName = Dict.getPropertySignalName propName

				(val) ->
					oldVal = @_data[propName]

					# break if value didn't change
					if oldVal is val
						return @

					Dict::set.call @, propName, val

					# signal
					@[signalName]? oldVal

			(prototype, propName) ->
				expect(prototype).not().toBe.primitive()
				expect(propName).toBe.truthy().string()

				# handler
				signalName = Dict.getPropertySignalName propName
				signal.createLazy prototype, signalName

				# getter/setter
				getter = createGetter propName
				setter = createSetter propName
				utils.defProp prototype, propName, 'ec', getter, setter

				null

*new* Dict([*Object* data])
-------------------------

Creates new *Dict* instance.

*data* parameter determines default properties with their values.

Using *new* keyword is not required.

### Example

data = new Dict
	name: 'xyz'

console.log(data.get 'name') // xyz

		constructor: (obj={}) ->
			expect(obj).toBe.object()

			# support no `new` syntax
			unless @ instanceof Dict
				return new Dict obj

			# properties
			utils.defProp @, '__hash__', '', utils.uid()
			utils.defProp @, '_data', '', obj
			utils.defProp @, '_keys', 'w', null
			utils.defProp @, '_values', 'w', null
			utils.defProp @, '_items', 'w', null
			utils.defProp @, '_dirty', 'w', ALL

*Integer* Dict::length
----------------------

Returns amount of the keys stored in the *Dict* instance.

This value can't be changed manually.

		utils.defProp @::, 'length', 'ce', ->
			@keys().length
		, null

*Signal* Dict::changed()
------------------------

Lazy *signal* called on each property value change.

### Example

user = new Dict
	country: 'Germany'

user.onChanged.connect (key, oldVal) ->
	console.log "User #{key} property changed from #{oldVal} to #{@get(key)}"

user.set 'country', 'US' // User country property changed from Germany to US

		signal.createLazy @::, 'changed'

*Any* Dict::get(*String* key)
-----------------------------

Get a property value stored in the *Dict*.

Returns *undefined* only for unknown properties.

### Example

bunny = new Dict
	speedX: 5
	speedY: 2

console.log(bunny.get 'speedX') // 5
console.log(bunny.get 'speedY') // 2
console.log(bunny.get 'speedZ') // undefined

		get: (key) ->
			expect(key).toBe.truthy().string()

			@_data[key]

Dict::set(*String* key, *Any* value)
------------------------------------

Change the property value on create a new property.

Calls `changed` signal if the value is different than before.
This signal is called with two parameters *key* and *oldValue*.

Passed *value* can't be a *undefined*, because it's used only for unknown properties.

### Example

links = new Dict
	facebook: 'https://facebook.com/neft.io'
	twitter: 'https://twitter.com/neft_io'

links.onChanged.connect (key, oldVal) ->
	console.log "Social link for #{key} changed from #{oldVal} to #{@get(key)}"

links.set 'googlePlus', 'https://plus.google.com/+NeftIo-for-apps/'
// Social link for googlePlus changed from undefined to https://...

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

			null

Dict::pop(*String* key)
-----------------------

Remove exists property from the *Dict*.

This method calls *Dict::changed()* signal.

### Example

member = new Dict

data.set 'name', 'John'

data.onChanged.connect (key, oldVal) ->
	if @get(key) is undefined
		console.log "#{key} property has been removed"

data.pop('name') // name property has been rmeoved

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

### Example

data = new Dict
	x: 10
	y: 30

console.log(data.keys()) // ['x', 'y']

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

### Example

data = new Dict
	x: 10
	y: 30

console.log(data.values()) // [10, 30]

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

### Example

data = new Dict
	x: 10
	y: 30

console.log(data.items()) // [['x', 10], ['y', 30]]

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

Check *Dict.fromJSON* to reverse this operation.

		toJSON: ->
			@_data

*String* Dict::toString()
-------------------------

Returns pseudo-unique string determining this *Dict* instance.

		toString: ->
			@__hash__