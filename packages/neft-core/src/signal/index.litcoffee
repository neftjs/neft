# Signal

Signal is a function with listeners which can be emitted.

Access it with:
```javascript
const { signal } = Neft;
```

    'use strict'

    utils = require '../util'
    assert = require '../assert'

## *Integer* signal.STOP_PROPAGATION

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

    STOP_PROPAGATION = exports.STOP_PROPAGATION = 1 << 30

## *Signal* signal.create([*NotPrimitive* object, *String* name])

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

    exports.create = (obj, name) ->
        signal = createSignalFunction obj
        if name is undefined
            return signal

        assert.isNotPrimitive obj, 'signal object cannot be primitive'
        assert.isString name, 'signal name must be a string'
        assert.notLengthOf name, 0, 'signal name cannot be an empty string'

        assert not obj.hasOwnProperty(name)
        , "signal object has already defined the '#{name}' property"

        obj[name] = signal

## *Boolean* signal.isEmpty(*Signal* signal)

Returns `true` if the given signal has no listeners.

    exports.isEmpty = (signal) ->
        for func in signal.listeners by 2
            if func isnt null
                return false
        return true

    callSignal = (obj, listeners, arg1, arg2) ->
        i = 0
        n = listeners.length
        result = 0
        containsGaps = false
        while i < n
            func = listeners[i]
            if func is null
                containsGaps = true
            else
                ctx = listeners[i + 1]
                if func.call(ctx or obj, arg1, arg2) is STOP_PROPAGATION
                    result = STOP_PROPAGATION
                    if containsGaps
                        break
            i += 2

        if containsGaps
            shift = 0
            while i < n
                func = listeners[i]
                if func is null
                    shift -= 2
                else if shift > 0
                    assert.isNotDefined listeners[i + shift]
                    assert.isNotDefined listeners[i + shift + 1]
                    listeners[i + shift] = func
                    listeners[i + shift + 1] = listeners[i + 1]
                    listeners[i] = null
                    listeners[i + 1] = null
                i += 2

        result

    createSignalFunction = (obj) ->
        handler = (listener, ctx) ->
            handler.connect listener, ctx

        handler.obj = obj
        handler.listeners = []
        utils.setPrototypeOf handler, SignalPrototype

        handler

    exports.createReference = (shallowHandler) ->
        handler = (listener, ctx) ->
            handler.connect listener, ctx

        handler.obj = shallowHandler.obj
        handler.listeners = shallowHandler.listeners
        utils.setPrototypeOf handler, SignalPrototype

        handler

    disconnectFromListeners = (listeners, listener, ctx) ->
        index = 0

        loop
            index = listeners.indexOf listener, index
            if index is -1 or listeners[index + 1] is ctx
                break
            index += 2
        assert.isNot index, -1, "listener doesn't exist in this signal"
        assert.is listeners[index], listener
        assert.is listeners[index + 1], ctx

        listeners[index] = null
        listeners[index + 1] = null

        return

    SignalPrototype =

## Signal::emit([*Any* argument1, *Any* argument2])

Call all of the signal listeners with the given arguments (2 maximally).

        emit: (arg1, arg2) ->
            assert.isFunction @, 'emit must be called on a signal function'
            assert.isArray @listeners, 'emit must be called on a signal function'
            assert.operator arguments.length, '<', 3, """
                signal accepts maximally two parameters; use object instead
            """

            callSignal @obj, @listeners, arg1, arg2

## Signal::connect(*Function* listener, [*Any* context])

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

        connect: (listener, ctx = null) ->
            assert.isFunction @, 'connect must be called on a signal function'
            assert.isFunction listener, 'listener is not a function'

            {listeners} = @

            i = n = listeners.length
            while (i -= 2) >= 0
                if listeners[i] isnt null
                    break

            if i + 2 is n
                listeners.push listener, ctx
            else
                assert.isNotDefined listeners[i + 2]
                assert.isNotDefined listeners[i + 3]
                listeners[i + 2] = listener
                listeners[i + 3] = ctx

            return

## Signal::connectOnce(*Function* listener, [*Any* context])

        connectOnce: (listener, ctx = null) ->
            assert.isFunction @, 'connectOnce must be called on a signal function'
            assert.isFunction listener, 'listener is not a function'

            {listeners} = @
            wrapper = (arg1, arg2) ->
                disconnectFromListeners listeners, wrapper, ctx
                listener.call @, arg1, arg2

            @connect wrapper, ctx


## Signal::disconnect(*Function* listener, [*Any* context])

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

        disconnect: (listener, ctx = null) ->
            assert.isFunction @, 'disconnect must be called on a signal function'
            assert.isFunction listener, 'listener is not a function'

            disconnectFromListeners @listeners, listener, ctx

            return

## Signal::disconnectAll()

Removes all the signal listeners.

        disconnectAll: ->
            assert.isFunction @, 'disconnectAll must be called on a signal function'

            {listeners} = @
            for _, i in listeners
                listeners[i] = null

            return

    exports.Emitter = require('./emitter')
        create: exports.create
        createSignalFunction: createSignalFunction
        callSignal: callSignal
