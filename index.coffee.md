Signal @library
======

**Better events**

Signals are used like events, but brings new features and fix some issues, which
standard events based on the strings have.

Each signal is a function and has a corresponding handler.
The handler always is prefixed by the *on* (e.g. signal *changed* has handler *onChanged*).
Signals are used to connect and disconnect listeners (functions called when a signal occurs).

Access it with:
```
var signal = require('signal');
```

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'

signal.STOP_PROPAGATION
-----------------------

This special constant value is used to stop calling further listeners.

Must be returned by a listener which want to capture a signal.

```
var obj = {};
signal.create(obj, 'onPress');

obj.onPress(function(){
  console.log('listener 1');
  return signal.STOP_PROPAGATION;
});

// this listener won't be called, because first listener will capture this signal
obj.onPress(function(){
  console.log('listener 2');
});

obj.onPress.emit();
// listener 1
```

	STOP_PROPAGATION = exports.STOP_PROPAGATION = 1 << 30

*Handler* signal.create([*NotPrimitive* object, *String* name])
---------------------------------------------------------------

This function creates new signal and handler in the given *object* under the given *name*.

```
var obj = {};

signal.create(obj, 'onRename');

obj.onRename.connect(function(){
  console.log(arguments);
});

obj.onRename.emit('Max', 'George');
// {0: "Max", 1: "George"}
```

	exports.create = (obj, name) ->
		signal = createSignalFunction obj
		if name is undefined
			return signal

		assert.isNotPrimitive obj
		assert.isString name
		assert.notLengthOf name, 0

		assert not obj.hasOwnProperty name
		, "Signal `#{name}` can't be created, because passed object " +
		  "has such property"

		obj[name] = signal

	callSignal = (obj, listeners, arg1, arg2) ->
		i = shift = 0
		n = listeners.length
		result = 0
		while i < n
			func = listeners[i]
			if func is null
				shift -= 2
			else
				ctx = listeners[i+1]
				if shift isnt 0
					listeners[i+shift] = func
					listeners[i+shift+1] = ctx
					listeners[i] = null
					listeners[i+1] = null

				if result is 0 and func.call(ctx or obj, arg1, arg2) is STOP_PROPAGATION
					result = STOP_PROPAGATION
			i += 2
		return result

*Signal* Signal()
-------------------

This function represents a handler function.

The handler function is used to connect and disconnect listeners.

If this function is called, it works like *Signal.connect()*.

	createSignalFunction = (obj) ->
		handler = (listener, ctx) ->
			handler.connect listener, ctx

		handler.obj = obj
		handler.listeners = []
		utils.setPrototypeOf handler, SignalPrototype

		handler

	SignalPrototype =

Signal.emit([*Any* argument1, *Any* argument2])
-----------------------------------------------

		emit: (arg1, arg2) ->
			assert.isFunction @
			assert.isArray @listeners
			assert.operator arguments.length, '<', 3, 'Signal accepts maximally two parameters; use object instead'

			callSignal @obj, @listeners, arg1, arg2

Signal.connect(*Function* listener, [*Any* context])
----------------------------------------------------

This function connects new listener function into a handler.

Connected listener will be called on each signal call.

```
var obj = {};
signal.create(obj, 'onPress');

obj.onPress(function(){
  console.log('listener 1');
});

obj.onPress.connect(function(){
  console.log('listener 2');
});

obj.onPress.emit()
// listener 1
// listener 2
```

The optional second argument will be used as a context in the called listeners.
By default, the listener is called with the object where a signal is created.

```
var obj = {standard: true};
signal.create(obj, 'onPress');

var fakeContext = {fake: true};
obj.onPress(function(){
  console.log(this);
}, fakeContext);

obj.onPress(function(){
  console.log(this);
});

obj.onPress.emit();
// {fake: true}
// {standard: true}
```

		connect: (listener, ctx=null) ->
			assert.isFunction @
			assert.isFunction listener

			{listeners} = @

			i = n = listeners.length
			while (i-=2) >= 0
				if listeners[i] isnt null
					break

			if i+2 is n
				listeners.push listener, ctx
			else
				listeners[i+2] = listener
				listeners[i+3] = ctx

			return

Signal.disconnect(*Function* listener, [*Any* context])
-------------------------------------------------------

This function disconnects already connected listener from a handler.

```
var obj = {};

signal.create(obj, 'onPress');

var listener = function(){
  console.log('listener called!');
};

obj.onPress.connect(listener);
obj.onPress.disconnect(listener);

obj.onPress.emit()
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
			assert.is listeners[index], listener
			assert.is listeners[index + 1], ctx

			listeners[index] = null
			listeners[index + 1] = null

			return

Signal.disconnectAll()
----------------------

This function disconnects all connected listeners from a handler.

		disconnectAll: ->
			assert.isFunction @

			{listeners} = @
			for _, i in listeners
				listeners[i] = null

			return

	exports.Emitter = require('./emitter')
		create: exports.create
		createSignalFunction: createSignalFunction
		callSignal: callSignal
