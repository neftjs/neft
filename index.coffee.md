Signal
======

Signals are quite different than popular events, but have the same work to do: call listeners.

They are several adventages in using this module rather than `emitter`:

1. You don't have to extends by the `Emitter` class. `Signal` is just a property.
2. You have always standardised signals/events to be listened.
3. No side private property must be created (`_events` in `emitter`).
4. Signals can be easily removed using `delete` keyword.

#

	'use strict'

	[utils, expect] = ['utils', 'expect'].map require

	###
	Returns property descriptor which can be used
	to define property
	###
	exports.getPropertyDesc = do ->

		config =
			configurable: true
			get: null

		(name) ->
				expect(name).toBe.truthy().string()

				config.get = ->
					defSignal @, name

				config

	###
	Create new signal and define it as a property
	###
	defSignal = (obj, name) ->
		signal = createSignal obj
		utils.defProp obj, name, 'cw', signal
		signal

*Signal* create( *Object* obj, *String* name )
----------------------------------------------

Use this function to register new signal called *name* in *object*.

After this action, signal is available as a property. Such property is not *enumerable*.

This method returns new *Signal* function with all methods, such as `connect()`, `disconnect()` etc.

##### Example
```coffeescript
signal = require 'signal'

obj = {}
signal.create obj, 'onUpdate'
obj.onUpdate.connect -> console.log 'update!'
obj.onUpdate()
```

##### Naming

Naming signals are standardised. It's recommended to follow this pattern, but it's not required.

1. Name should be prefixed by `on`: `onUpdate`, `onDestroy` etc.
2. `camelCase` practice should be respected: `onTextChange`, `onNextItemChanged`
3. Use present form before doing something, and past tense to mark finished operations:
   `onTextChange` should be called when the text is still unchanged, but
   `onTextChanged` (with `d`) should be called when the text has been changed.

#

	exports.create = (obj, name) ->
		expect(obj).not().toBe.primitive()
		expect(name).toBe.truthy().string()

		defSignal obj, name

*Signal* defineGetter( *Object* obj, *String* name )
----------------------------------------------------

	exports.defineGetter = (obj, name) ->
		expect(obj).not().toBe.primitive()
		expect(name).toBe.truthy().string()

		Object.defineProperty obj, name, exports.getPropertyDesc(name)

Signal
------

*Signal* is a function returned by the *create()* method.

Calling this function is equivalent to triggering an event.

##### Important

You can pass maximum only two arguments while calling signal.
All further arguments are omitted.

```coffeescript
signal = require 'signal'

obj = {}
signal.create obj, 'onUpdate'

obj.onUpdate.connect (a, b, c) ->
	console.log a, b, c
	# `a, b, undefined` will be logged

obj.onUpdate 'a', 'b', 'c'
```

	###
	Function creates new Signal function which can be used to
	trigger, connect and disconnect listeners.
	###
	createSignal = do ->
		useProto = do ->
			try
				func = ->
				proto = func.__proto__ = {a: 1}
				if func.a is 1
					return true
				false

		signalFunc = (store, a, b) ->
			n = store.length
			i = -1
			while ++i < n
				func = store[i]
				if func is null
					store.splice i, 1
					i--; n--
					continue

				func.call @, a, b

			null

		(obj) ->
			expect(obj).not().toBe.primitive()

			store = []
			signal = signalFunc.bind obj, store
			signal.store = store

			if useProto
				signal.__proto__ = SignalPrototype
			else
				utils.merge signal, SignalPrototype

			signal

	###
	Signal prototype joined into each Signal function
	###
	SignalPrototype =

### Signal::connect( *Function* listener )

Add new signal listener.

Duplicated are not allowed.

		connect: (listener) ->
			expect(listener).toBe.function()
			expect().some(@store).not().toBe listener

			@store.push listener

### Signal::disconnect( *Function* listener )

Remove function from the listeners.

Unknown functions (not connected) are not allowed.

##### Example
```coffeescript
signal = require 'signal'

obj = {}
signal.create obj, 'onUpdate'

listener = -> throw 'panic!'

signal.onUpdate.connect listener
signal.onUpdate.disconnect listener

signal.onUpdate()
# no error raised
```

		disconnect: (listener) ->
			expect(listener).toBe.function()
			expect().some(@store).toBe listener

			index = @store.indexOf listener
			@store[index] = null