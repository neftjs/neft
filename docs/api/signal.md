# Signal

> **API Reference** ▸ **Signal**

<!-- toc -->
Signal is a function with listeners which can be emitted.

Access it with:
```javascript
const { signal } = Neft;
```


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/signal/index.litcoffee)


* * * 

### `signal.STOP_PROPAGATION`

<dl><dt>Static property of</dt><dd><i>signal</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/signal/index.litcoffee#integer-signalstoppropagation)


* * * 

### `signal.create()`

<dl><dt>Static property of</dt><dd><i>signal</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>NotPrimitive</i> — <i>optional</i></li><li>name — <i>String</i> — <i>optional</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/signal/index.litcoffee#signal-signalcreatenotprimitive-object-string-name)


* * * 

### `signal.isEmpty()`

<dl><dt>Static method of</dt><dd><i>signal</i></dd><dt>Parameters</dt><dd><ul><li>signal — <i>Signal</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

Returns `true` if the given signal has no listeners.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/signal/index.litcoffee#boolean-signalisemptysignal-signal)


* * * 

### `emit()`

<dl><dt>Parameters</dt><dd><ul><li>argument1 — <i>Any</i> — <i>optional</i></li><li>argument2 — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

Call all of the signal listeners with the given arguments (2 maximally).


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/signal/index.litcoffee#signalemitany-argument1-any-argument2)


* * * 

### `connect()`

<dl><dt>Parameters</dt><dd><ul><li>listener — <i>Function</i></li><li>context — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/signal/index.litcoffee#signalconnectfunction-listener-any-context)


* * * 

### `disconnect()`

<dl><dt>Parameters</dt><dd><ul><li>listener — <i>Function</i></li><li>context — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/signal/index.litcoffee#signaldisconnectfunction-listener-any-context)


* * * 

### `disconnectAll()`
Removes all the signal listeners.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/signal/index.litcoffee#signaldisconnectall)

