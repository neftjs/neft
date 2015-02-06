Signal
======

Signals are used as standard `events` but brings new features and fix some issues, which
standard events based on the strings have.

	'use strict'

	utils = require 'utils'
	assert = require 'assert'

	createSignal = (obj, name) ->
		assert.isNotPrimitive obj
		assert.isString name
		assert.notLengthOf name, 0

		handlerName = exports.getHandlerName name

		assert not obj.hasOwnProperty name
		, "Signal `#{name}` can't be created, because object `#{obj}` " +
		  "has already defined such property"

		obj[name] = createSignalFunction obj

	createHandler = (obj, name) ->
		assert.isNotPrimitive obj
		assert.isString name
		assert.notLengthOf name, 0

		handlerName = exports.getHandlerName name

		assert not obj.hasOwnProperty handlerName
		, "Handler `#{handlerName}` can't be created, because object `#{obj}` " +
		  "has already defined such property"

		signal = obj[name]
		obj[handlerName] = createHandlerFunction obj, signal

signal.STOP_PROPAGATION
-----------------------

	exports.STOP_PROPAGATION = 1 << 30

*String* signal.getHandlerName(*String* signalName)
-----------------------------------------------------

Returns handler name based on the signal name.

In pratice it adds *on* prefix and capitalize the signal name.

```
console.log(signal.getHandlerName('xChanged'));
// onXChanged
```

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

```
console.log(signal.isHandlerName('onXChanged'));
// true

console.log(signal.isHandlerName('xChanged'));
// false

console.log(signal.isHandlerName('onxChanged'));
// false (because x is lowercase)
```

	exports.isHandlerName = (name) ->
		assert.isString name

		///^on[A-Z]///.test name

*Handler* signal.create(*NotPrimitive* object, *String* name)
-------------------------------------------------------------

Creates new signal and handler for this signal in the given *object* under the given *name*.

```
var obj = {};

signal.create(obj, 'renamed');

obj.onRenamed.connect(function(){
  console.log(arguments);
});

obj.renamed('Max', 'George');
// {0: "Max", 1: "George"}
```

	exports.create = (obj, name) ->
		assert.isNotPrimitive obj
		assert.isString name
		assert.notLengthOf name, 0

		createSignal obj, name
		createHandler obj, name

*Handler* signal.createLazy(*NotPrimitive* object, *String* name)
-----------------------------------------------------------------

Creates new lazy signal in the given *object* under the given *name*.

Lazy signal is a optimized version of the standard *signal.create()* function.
It creates new *signal* function only if it's needed (any listeners wan't to listen on it).

It can be also used to create signals in the prototypes.

```
function Dog(){
}

var handler = signal.createLazy(Dog.prototype, 'ageChanged');

handler.onInitialized(function(ctx, name){
  console.log("Signal " + name + " initialized");
});

var myDog = new Dog;
console.log(Object.keys(myDog));
// []

myDog.onAgeChanged.connect(function(){
  console.log('Signal called');
});
// Signal ageChanged initialized

myDog.ageChanged();
// Signal called

console.log(Object.keys(myDog));
// ['ageChanged']

console.log(Object.keys(Object.getPrototypeOf(myDog)));
// ['onAgeChanged']
```

	exports.createLazy = (obj, name) ->
		assert.isNotPrimitive obj
		assert.isString name
		assert.notLengthOf name, 0

		handlerName = exports.getHandlerName name
		handler = createHandler obj, name

		exports.create handler, 'initialized'

		desc = utils.ENUMERABLE | utils.CONFIGURABLE
		utils.defineProperty obj, handlerName, desc, ->
			signal = @[name]
			unless signal?
				signal = @[name] = createSignalFunction @, handler
				handler.initialized @, name

			handler.listeners = signal.listeners
			handler
		, null

		handler

	callSignal = (obj, listeners, args) ->
		i = 0
		n = listeners.length
		while i < n
			func = listeners[i]
			if func is null
				listeners.splice i, 2
				n -= 2
			else
				result = func.apply(listeners[i+1] or obj, args)
				if result is exports.STOP_PROPAGATION
					return result
				i += 2

		return

	createSignalFunction = (obj) ->
		signal = ->
			callSignal obj, listeners, arguments

		listeners = signal.listeners = []

		signal

*Handler* Handler()
===================

Handler function used to connect and disconnect listeners.

Handler is always stored in the property prefixed by the *on* (e.g. *onWidthChanged*).

If it's called it works as a alias for the *Handler.connect()*.

	createHandlerFunction = (obj, signal) ->
		handler = (listener, ctx) ->
			handler.connect listener, ctx

		handler.listeners = signal?.listeners
		utils.setPrototypeOf handler, HandlerPrototype

		handler

	HandlerPrototype =

Handler.connect(*Function* listener)
------------------------------------

Connect new listener function to the handler.

Connected function will be called on each signal call.

```
var obj = {};

signal.create(obj, 'pressed');

obj.onPressed(function(){
  console.log('listener 1');
});

obj.onPressed.connect(function(){
  console.log('listener 2');
});

obj.pressed()
// listener 1
// listener 2
```

		connect: (listener, ctx=null) ->
			assert.isFunction @
			assert.isFunction listener

			@listeners.push listener, ctx

			return

Handler.disconnect(*Function* listener)
---------------------------------------

Diconnect already connected listener.

```
var obj = {};

signal.create(obj, 'pressed');

var listener = function(){
  console.log('listener called!');
};

obj.onPressed.connect(listener);
obj.onPressed.disconnect(listener);

obj.pressed()
// no loggs...
```

		disconnect: (listener, ctx=null) ->
			assert.isFunction @
			assert.isFunction listener

			{listeners} = @
			index = 0

			loop
				index = listeners.indexOf listener, index
				if index is -1 or listeners[index+1] is ctx
					break
				index += 2
			assert.isNot index, -1

			listeners[index] = null
			listeners[index + 1] = null

			return

Handler.disconnectAll()
-----------------------

Diconnect all already connected listeners from the *handler*.

		disconnectAll: ->
			assert.isFunction @

			{listeners} = @
			for _, i in listeners
				listeners[i] = null

			return
