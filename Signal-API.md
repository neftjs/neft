> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Signal**

# Signal

Signal is a function with listeners which can be emitted.
Access it with:
```javascript
const { signal } = Neft;
```

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#signal)

## Table of contents
* [Signal](#signal)
  * [STOP_PROPAGATION](#integer-stoppropagation)
  * [create([object, name])](#signal-createnotprimitive-object-string-name)
  * [isEmpty(signal)](#boolean-isemptysignal-signal)
  * [**Class** Signal](#class-signal)
    * [emit([argument1, argument2])](#signalemitany-argument1-any-argument2)
    * [connect(listener, [context])](#signalconnectfunction-listener-any-context)
    * [disconnect(listener, [context])](#signaldisconnectfunction-listener-any-context)
    * [disconnectAll()](#signaldisconnectall)
* [Glossary](#glossary)

## [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) STOP_PROPAGATION

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

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#integer-stoppropagation)

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) create([*NotPrimitive* object, *String* name])

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

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#signal-createnotprimitive-object-string-name)

## *Boolean* isEmpty([*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) signal)

Returns `true` if the given signal has no listeners.

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#boolean-isemptysignal-signal)

## **Class** Signal

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#class-signal)

### Signal::emit([*Any* argument1, *Any* argument2])

Call all of the signal listeners with the given arguments (2 maximally).

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#signalemitany-argument1-any-argument2)

### Signal::connect(*Function* listener, [*Any* context])

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

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#signalconnectfunction-listener-any-context)

### Signal::disconnect(*Function* listener, [*Any* context])

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

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#signaldisconnectfunction-listener-any-context)

### Signal::disconnectAll()

Removes all the signal listeners.

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#signaldisconnectall)

# Glossary

 - [Signal](#class-signal)

