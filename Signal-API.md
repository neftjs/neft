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
<dl><dt>Type</dt><dd><i>Integer</i></dd></dl>
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
<dl><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>NotPrimitive</i> — <i>optional</i></li><li><b>name</b> — <i>String</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
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
<dl><dt>Parameters</dt><dd><ul><li><b>signal</b> — <i>Signal</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the given signal has no listeners.

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#boolean-isemptysignal-signal)

## **Class** Signal

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#class-signal)

###emit
<dl><dt>Prototype method of</dt><dd><i>Signal</i></dd><dt>Parameters</dt><dd><ul><li><b>argument1</b> — <i>Any</i> — <i>optional</i></li><li><b>argument2</b> — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Call all of the signal listeners with the given arguments (2 maximally).

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#signalemitany-argument1-any-argument2)

###connect
<dl><dt>Prototype method of</dt><dd><i>Signal</i></dd><dt>Parameters</dt><dd><ul><li><b>listener</b> — <i>Function</i></li><li><b>context</b> — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
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
<dl><dt>Prototype method of</dt><dd><i>Signal</i></dd><dt>Parameters</dt><dd><ul><li><b>listener</b> — <i>Function</i></li><li><b>context</b> — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
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
<dl><dt>Prototype method of</dt><dd><i>Signal</i></dd></dl>
Removes all the signal listeners.

> [`Source`](/Neft-io/neft/tree/master/src/signal/index.litcoffee#signaldisconnectall)

## Glossary

 - [Signal](#class-signal)

