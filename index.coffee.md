Signal @library
======

**Better events**

Signals are used like events, but brings new features and fix some issues, which
standard events based on the strings have.

Each signal is a function and has a corresponding handler.
The handler always is prefixed by the *on* (e.g. signal *changed* has handler *onChanged*).
Handlers are used to connect and disconnect listeners (functions called when a signal occurs).

Access it with:
```
var signal = require('signal');
```

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'

	createSignal = (obj, name) ->
		assert.isNotPrimitive obj
		assert.isString name
		assert.notLengthOf name, 0

		handlerName = exports.getHandlerName name

		assert not obj.hasOwnProperty name
		, "Signal `#{name}` can't be created, because passed object " +
		  "has such property"

		obj[name] = createSignalFunction obj

	createHandler = (obj, name) ->
		assert.isNotPrimitive obj
		assert.isString name
		assert.notLengthOf name, 0

		handlerName = exports.getHandlerName name

		assert not obj.hasOwnProperty handlerName
		, "Handler `#{handlerName}` can't be created, because passed object " +
		  "has such property"

		signal = obj[name]
		obj[handlerName] = createHandlerFunction signal

signal.STOP_PROPAGATION
-----------------------

This special constant value is used to stop calling further listeners.

Must be returned by a listener which want to capture a signal.

```
var obj = {};
signal.create(obj, 'pressed');

obj.onPressed(function(){
  console.log('listener 1');
  return signal.STOP_PROPAGATION;
});

// this listener won't be called, because first listener will capture this signal
obj.onPressed(function(){
  console.log('listener 2');
});

obj.pressed();
// listener 1
```

	STOP_PROPAGATION = exports.STOP_PROPAGATION = 1 << 30

*String* signal.getHandlerName(*String* signalName)
-----------------------------------------------------

This function returns a handler name based on the signal name.

In practice it adds *on* prefix and capitalize the signal name.

```
console.log(signal.getHandlerName('xChanged'));
// onXChanged
```

	exports.getHandlerName = do ->
		cache = Object.create null

		(name) ->
			cache[name] ?= "on#{utils.capitalize(name)}"

*Boolean* signal.isHandlerName(*String* name)
---------------------------------------------

This function returns *true* if the given *name* is a proper handler name.

In practice it returns *true* if the *name* is prefixed by the *on*.

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

This function creates new signal and handler in the given *object* under the given *name*.

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

This function creates a new handler in the given *object* under the given *name*.

The signal is created on demand (only if a listener wants to listen on it).

It can be also used to create signals in the prototype.

```
function Dog(){
}

var handler = signal.createLazy(Dog.prototype, 'ageChanged');

var myDog = new Dog;
console.log(Object.keys(myDog));
// []

myDog.onAgeChanged.connect(function(){
  console.log('Signal called');
});

myDog.ageChanged();
// Signal called

console.log(Object.keys(myDog));
// ['ageChanged']
```

	exports.createLazy = (obj, name) ->
		assert.isNotPrimitive obj
		assert.isString name
		assert.notLengthOf name, 0

		handlerName = exports.getHandlerName name
		handler = createHandler obj, name

		desc = utils.ENUMERABLE | utils.CONFIGURABLE
		utils.defineProperty obj, handlerName, desc, ->
			signal = @[name]
			unless signal?
				signal = @[name] = createSignalFunction @, handler

			handler.listeners = signal.listeners
			handler
		, null

		return

	callSignal = (obj, listeners, arg1, arg2) ->
		i = 0
		while i < listeners.length
			func = listeners[i]
			if func is null
				listeners.splice i, 2
			else
				result = func.call(listeners[i+1] or obj, arg1, arg2)
				if result is STOP_PROPAGATION
					return result
				i += 2
		return

	createSignalFunction = (obj) ->
		signal = (arg1, arg2) ->
			assert.operator arguments.length, '<', 3, 'Signal accepts maximally two parameters; use object instead'
			callSignal obj, listeners, arg1, arg2, obj

		listeners = signal.listeners = []

		signal

*Handler* Handler()
-------------------

This function represents a handler function.

The handler function is used to connect and disconnect listeners.

If this function is called, it works like *Handler.connect()*.

	createHandlerFunction = (signal) ->
		handler = (listener, ctx) ->
			handler.connect listener, ctx

		handler.listeners = signal?.listeners
		utils.setPrototypeOf handler, HandlerPrototype

		handler

	HandlerPrototype =

Handler.connect(*Function* listener, [*Any* context])
-----------------------------------------------------

This function connects new listener function into a handler.

Connected listener will be called on each signal call.

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

The optional second argument will be used as a context in the called listeners.
By default, the listener is called with the object where a signal is created.

```
var obj = {standard: true};
signal.create(obj, 'pressed');

var fakeContext = {fake: true};
obj.onPressed(function(){
  console.log(this);
}, fakeContext);

obj.onPressed(function(){
  console.log(this);
});

obj.pressed();
// {fake: true}
// {standard: true}
```

		connect: (listener, ctx=null) ->
			assert.isFunction @
			assert.isFunction listener

			@listeners.push listener, ctx

			return

Handler.disconnect(*Function* listener, [*Any* context])
--------------------------------------------------------

This function disconnects already connected listener from a handler.

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

This function disconnects all connected listeners from a handler.

		disconnectAll: ->
			assert.isFunction @

			{listeners} = @
			for _, i in listeners
				listeners[i] = null

			return

	exports.Emitter = require('./emitter')
		create: exports.create
		getHandlerName: exports.getHandlerName
		createHandlerFunction: createHandlerFunction
		callSignal: callSignal
