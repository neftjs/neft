> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Signal**

# Signal

Signal is a function with listeners which can be emitted.
Access it with:
```javascript
const { signal } = Neft;
```

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#signal)

## Table of contents
  * [STOP_PROPAGATION](#stoppropagation)
  * [create](#create)
  * [isEmpty](#isempty)
  * [**Class** Signal](#class-signal)
    * [emit](#emit)
    * [connect](#connect)
    * [disconnect](#disconnect)
    * [disconnectAll](#disconnectall)
  * [Glossary](#glossary)

##STOP_PROPAGATION
Special constant used to stop calling further listeners.
Must be returned by the listener function.
```javascript
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

##create
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

##isEmpty
Returns `true` if the given signal has no listeners.

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#boolean-isemptysignal-signal)

## **Class** Signal

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#class-signal)

###emit
Call all of the signal listeners with the given arguments (2 maximally).

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#signalemitany-argument1-any-argument2)

###connect
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

###disconnect
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

###disconnectAll
Removes all the signal listeners.

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#signaldisconnectall)

## Glossary

 - [Signal](#class-signal)

