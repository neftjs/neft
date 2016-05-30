> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Signal**

# Signal

> events-like

Signal is a function with listeners which can be emitted.

Access it with:
```javascript
const { signal } = Neft;
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/signal/index.litcoffee#signal)

## Table of contents
* [Signal](#signal)
* [STOP_PROPAGATION](#stoppropagation)
* [create](#create)
* [isEmpty](#isempty)
* [**Class** Signal](#class-signal)
  * [emit](#emit)
  * [connect](#connect)
  * [disconnect](#disconnect)
  * [disconnectAll](#disconnectall)
* [Glossary](#glossary)

#STOP_PROPAGATION
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; STOP_PROPAGATION</code></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/signal/index.litcoffee#stoppropagation)

#create
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; create([&#x2A;NotPrimitive&#x2A; object, &#x2A;String&#x2A; name])</code></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isprimitive">NotPrimitive</a> — <i>optional</i></li><li>name — <i>String</i> — <i>optional</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/signal/index.litcoffee#create)

#isEmpty
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; isEmpty(&#x2A;Signal&#x2A; signal)</code></dd><dt>Parameters</dt><dd><ul><li>signal — <a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the given signal has no listeners.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/signal/index.litcoffee#isempty)

# *[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Signal

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/signal/index.litcoffee#class-signal)

##emit
<dl><dt>Syntax</dt><dd><code>Signal::emit([&#x2A;Any&#x2A; argument1, &#x2A;Any&#x2A; argument2])</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd><dt>Parameters</dt><dd><ul><li>argument1 — <i>Any</i> — <i>optional</i></li><li>argument2 — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Call all of the signal listeners with the given arguments (2 maximally).

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/signal/index.litcoffee#emit)

##connect
<dl><dt>Syntax</dt><dd><code>Signal::connect(&#x2A;Function&#x2A; listener, [&#x2A;Any&#x2A; context])</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd><dt>Parameters</dt><dd><ul><li>listener — <i>Function</i></li><li>context — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/signal/index.litcoffee#connect)

##disconnect
<dl><dt>Syntax</dt><dd><code>Signal::disconnect(&#x2A;Function&#x2A; listener, [&#x2A;Any&#x2A; context])</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd><dt>Parameters</dt><dd><ul><li>listener — <i>Function</i></li><li>context — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/signal/index.litcoffee#disconnect)

##disconnectAll
<dl><dt>Syntax</dt><dd><code>Signal::disconnectAll()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Removes all the signal listeners.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/signal/index.litcoffee#disconnectall)

# Glossary

- [Signal](#class-signal)

