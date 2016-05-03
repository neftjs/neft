Signal @library
===============

Signal is a function with listeners which can be emitted.

Access it with:
```javascript
var signal = require('signal');
```

*Integer* signal.STOP_PROPAGATION
---------------------------------

Special constant used to stop calling further listeners.

Must be returned by the listener function.

```javascrpt
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

*Signal* signal.create([*NotPrimitive* object, *String* name])
--------------------------------------------------------------

Creates a new signal in the given object under the given name property.

Returns created signal.

```javascript
var obj = {};

signal.create(obj, 'onRename');

obj.onRename.connect(function(){
  console.log(arguments);
});

obj.onRename.emit('Max', 'George');
// {0: "Max", 1: "George"}
```

*Boolean* signal.isEmpty(*Signal* signal)
-----------------------------------------

Returns `true` if the given signal has no listeners.

*Signal* Signal()
-----------------

Signal::emit([*Any* argument1, *Any* argument2])
------------------------------------------------

Call all of the signal listeners with the given arguments (2 maximally).

Signal::connect(*Function* listener, [*Any* context])
-----------------------------------------------------

Adds the given listener function into the signal listeners.

By default, the signal function works like this method.

```javascript
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

The given context will be used as a context in listener calling.
By default, the listener is called with the object on which the signal is created.

```javascript
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

Signal.disconnect(*Function* listener, [*Any* context])
-------------------------------------------------------

Returns the given listener function from the signal listeners.

```javascript
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

Signal.disconnectAll()
----------------------

Removes all the signal listeners.

