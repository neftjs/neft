Signal
======

Signals are used as standard `events` but brings new features and fix some issues, which
standard events based on the strings have.

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

	{assert} = console

	createSignal = (obj, name) ->
		expect(obj).not().toBe.primitive()
		expect(name).toBe.truthy().string()

		handlerName = exports.getHandlerName name

		assert not obj[name]?
		, "Signal `#{name}` can't be created, because object `#{obj}` " +
		  "has already defined such property"

		obj[name] = createSignalFunction obj

	createHandler = (obj, name) ->
		expect(obj).not().toBe.primitive()
		expect(name).toBe.truthy().string()

		handlerName = exports.getHandlerName name

		assert not obj[handlerName]?
		, "Handler `#{handlerName}` can't be created, because object `#{obj}` " +
		  "has already defined such property"

		signal = obj[name]
		obj[handlerName] = createHandlerFunction obj, signal

*String* signal.getHandlerName(*String* signalName)
-----------------------------------------------------

Returns handler name based on the signal name.

In pratice it adds *on* prefix and capitalize the signal name.

### Example

signal.getHandlerName 'xChanged'
// onXChanged

	exports.getHandlerName = do ->
		cache = {}

		(name) ->
			if cache.hasOwnProperty name
				cache[name]
			else
				cache[name] = "on#{utils.capitalize name}"

*Boolean* signal.isHandlerName(*String* name)
---------------------------------------------

Returns true if the given *name* is a proper handler name.

In pratice it returns true if the *name* is prefixed by *on*.

### Example

signal.isHandlerName 'onXChanged'
// true

signal.isHandlerName 'xChanged'
// false

signal.isHandlerName 'onxChanged'
// false (because x is lowercase)

	exports.isHandlerName = (name) ->
		expect(name).toBe.string()

		///^on[A-Z]///.test name

*Handler* signal.create(*NotPrimitive* object, *String* name)
-------------------------------------------------------------

Creates new signal and handler for this signal in the given *object* under the given *name*.

### Example

obj = {}

signal.create obj, 'xChanged'

obj.onXChanged.connect ->
  console.log arguments

obj.xChanged 1, 2
// [1, 2]

	exports.create = (obj, name) ->
		expect(obj).not().toBe.primitive()
		expect(name).toBe.truthy().string()

		createSignal obj, name
		createHandler obj, name

*Handler* signal.createLazy(*NotPrimitive* object, *String* name)
-----------------------------------------------------------------

Creates new lazy signal in the given *object* under the given *name*.

Lazy signal is a optimized version of the standard *signal.create()* function.
It creates new *signal* function only if it's needed (any listeners wan't to listen on it).

It can be also used to create signals in the prototypes.

### Example

class Dog
  handler = signal.createLazy @::, 'ageChanged'

  handler.onInitialized (ctx, name) ->
    console.log "Signal #{name} initialized"

myDog = new Dog

console.log(Object.keys(myDog)) // []

myDog.onAgeChanged.connect ->
// Signal ageChanged initialized

console.log Object.keys(myDog)
// ['ageChanged']

console.log Object.keys(Object.getPrototypeOf(myDog))
// ['onAgeChanged']

	exports.createLazy = (obj, name) ->
		expect(obj).not().toBe.primitive()
		expect(name).toBe.truthy().string()

		handlerName = exports.getHandlerName name
		handler = createHandler obj, name

		exports.create handler, 'initialized'

		utils.defProp obj, handlerName, 'ec', ->
			signal = @[name]
			unless signal?
				signal = @[name] = createSignalFunction @, handler
				handler.initialized @, name

			handler.listeners = signal.listeners
			handler
		, null

		handler

*Function* Signal
=================

Signal function is used to call all handler listeners.

### Example

obj = {}
signal.create obj, 'changed'

obj.changed()
// call all connected listeners ...

	createSignalFunction = (obj) ->
		signal = ->
			n = listeners.length
			return unless n

			args = []
			for arg, i in arguments
				args[i] = arg

			i = -1
			while ++i < n
				func = listeners[i]
				if func is null
					listeners.splice i, 1
					i--; n--
					continue

				func.apply obj, args

			null

		listeners = signal.listeners = []

		signal

*Function* Handler
==================

Handler function used to connect and disconnect listeners.

Handler is always stored in the property prefixed by the *on* (e.g. *onWidthChanged*).

If it's called it works as a alias for the *Handler.connect()*.

### Example

obj = {}

signal.create obj, 'pressed'

obj.onPressed ->
  console.log 'listener 1'

obj.onPressed.connect ->
  console.log 'listener 2'

obj.pressed()
// listener 1
// listener 2

	createHandlerFunction = (obj, signal) ->
		handler = (listener) ->
			HandlerPrototype.connect.call handler, listener

		handler.listeners = signal?.listeners
		utils.setPrototypeOf handler, HandlerPrototype

		handler

	HandlerPrototype =

Handler.connect(*Function* listener)
------------------------------------

Connect new listener function to the handler.

Connected function will be called on each signal call.

		connect: (listener) ->
			expect(@).toBe.function()
			expect(listener).toBe.function()
			expect().some(@listeners).not().toBe listener

			@listeners.push listener

			null

Handler.disconnect(*Function* listener)
---------------------------------------

Diconnect already connected listener.

### Example

obj = {}

signal.create obj, 'pressed'

listener = ->
  console.log 'listener called!'

obj.onPressed.connect listener
obj.onPressed.disconnect listener

obj.pressed() // no loggs...

		disconnect: (listener) ->
			expect(@).toBe.function()
			expect(listener).toBe.function()
			expect().some(@listeners).toBe listener

			index = @listeners.indexOf listener
			@listeners[index] = null

			null

Handler.disconnectAll()
-----------------------

Diconnect all already connected listeners from the *handler*.

		disconnectAll: ->
			expect(@).toBe.function()

			for listener in @listeners
				@disconnect listener

			null