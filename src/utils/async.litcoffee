# Asynchronous

Access it with:
```javascript
var utils = require('utils');
var async = utils.async;
```

    'use strict'

    utils = null

    assert = console.assert.bind console
    {exports} = module

    {shift} = Array::
    {isArray} = Array

    NOP = ->

## forEach(*NotPrimitive* array, *Function* callback, [*Function* onEnd, *Any* context])

This is an asynchronous version of the standard `Array.prototype.forEach()` function
which works with arrays and objects.

The given callback function is called with parameters:
 - if an array given: element value, index, array, next callback
 - if an object given: key, value, object, next callback

```javascript
var toLoadInOrder = ['users.json', 'families.js', 'relationships.js'];

utils.async.forEach(toLoadInOrder, function(elem, i, array, next){
  console.log("Load " + elem + " file");
  // on load end ...
  next();
}, function(){
  console.log("All files are loaded!");
});

// Load users.json
// Load families.json
// load relationships.json
// All files are loaded!
```

    forEach = do ->

        forArray = (arr, callback, onEnd, thisArg) ->
            i = 0
            n = arr.length

            next = ->
                # return and call onEnd if there is no elements to check
                if i is n then return onEnd.call thisArg

                # increase counter
                i++

                # call callback func
                callback.call thisArg, arr[i - 1], i - 1, arr, next

            # start
            next()

        forObject = (obj, callback, onEnd, thisArg) ->
            keys = Object.keys obj

            i = 0
            n = keys.length

            next = ->
                # return and call onEnd if there is no pairs to check
                if i is n
                    return onEnd.call thisArg

                # call callback func
                key = keys[i]
                callback.call thisArg, key, obj[key], obj, next

                # increase counter
                i++

            # start
            next()

        (list, callback, onEnd, thisArg) ->
            assert not utils.isPrimitive list
            assert typeof callback is 'function'
            assert typeof onEnd is 'function' if onEnd?

            method = if isArray list then forArray else forObject
            method list, callback, onEnd, thisArg

            null

## **Class** Stack()

Stores functions and runs them synchronously or asynchronously.

```javascript
var stack = new utils.async.Stack;

function load(src, callback){
  console.log("Load " + src + " file");
  // load file async ...
  // first callback parameter is an error ...
  callback(null, "fiel data");
};

stack.add(load, null, ['items.json']);
stack.add(load, null, ['users.json']);

stack.runAllSimultaneously(function(){
  console.log("All files have been loaded!");
});

// Load items.json file
// Load users.json file
// All files have been loaded!

// or ... (simultaneous call has no order)

// Load users.json file
// Load items.json file
// All files have been loaded!
```

    class Stack

        constructor: ->
            # One-deep array of added functions
            # in schema [function, context, args, ...]
            @_arr = []
            @length = 0
            @pending = false

            Object.preventExtensions @

### Stack::add(*Function* function, [*Any* context, *NotPrimitive* arguments])

Adds the given function to the stack.

The function must provide a callback argument as the last argument.
The first argument of the callback function is always an error.

```javascript
var stack = new utils.async.Stack;

function add(a, b, callback){
  if (isFinite(a) && isFinite(b)){
    callback(null, a+b);
  } else {
    throw "Finite numbers are required!";
  }
}

stack.add(add, null, [1, 2]);

stack.runAll(function(err, result){
  console.log(err, result);
});
// null 3

stack.add(add, null, [1, NaN]);

stack.runAll(function(err, result){
  console.log(err, result);
});
// "Finite numbers are required!"  undefined
```

        add: (func, context, args) ->
            assert utils.isObject args if args?

            @_arr.push func, context, args
            @length++
            @

### Stack::callNext([*Array* arguments], *Function* callback)

Calls the first function from the stack and remove it.

        callNext: (args, callback) ->
            if typeof args is 'function' and not callback?
                callback = args
                args = null

            assert typeof callback is 'function'

            # on empty
            unless @_arr.length
                return callback()

            # get next
            @length--
            func = @_arr.shift()
            context = @_arr.shift()
            funcArgs = @_arr.shift()

            if typeof func is 'string'
                func = utils.get context, func

            if typeof func isnt 'function'
                throw new TypeError 'ASync Stack::callNext(): ' +
                    'function to call is not a function'

            funcLength = func.length or Math.max(
                args?.length or 0,
                funcArgs?.length or 0
            ) + 1
            syncError = null
            called = false

            callbackWrapper = ->
                assert not called or not syncError
                , "Callback can't be called if function throws an error;\n" +
                  "Function: `#{func}`\nSynchronous error: `#{syncError?.stack or syncError}`"

                assert not called
                , "Callback can't be called twice;\nFunction: `#{func}`"

                called = true
                callback.apply @, arguments

            # add callback into funcArgs
            # To avoid got funcArgs array modification and to minimise memory usage,
            # we create a new object with the `funcArgs` as a prototype.
            # `Function::apply` expects an object and iterate by it to the `length`.
            funcArgs = Object.create(funcArgs or null)
            funcArgs[funcLength - 1] = callbackWrapper
            if funcArgs.length is undefined or funcArgs.length < funcLength
                funcArgs.length = funcLength
            if args
                for arg, i in args
                    if i isnt funcLength - 1 and funcArgs[i] is undefined
                        funcArgs[i] = arg

            # call; support sync errors
            syncError = utils.catchError func, context, funcArgs
            if syncError
                callbackWrapper syncError

            null

### Stack::runAll([*Function* callback, *Any* callbackContext])

Calls all functions from the stack one by one.

When an error occurs, processing stops and the callback function is called with the got error.

        runAll: (callback = NOP, ctx = null) ->
            assert @pending is false
            if typeof callback isnt 'function'
                throw new TypeError 'ASync runAll(): ' +
                    'passed callback is not a function'

            unless @_arr.length
                return callback.call ctx, null

            onNextCalled = (err, args...) =>
                # on err
                if err?
                    @pending = false
                    return callback.call ctx, err

                # call next
                if @_arr.length
                    return callNext args

                @pending = false
                callback.apply ctx, arguments

            callNext = (args) => @callNext args, onNextCalled

            @pending = true
            callNext()

            null

### Stack::runAllSimultaneously([*Function* callback, *Any* callbackContext])

Calls all functions from the stack simultaneously (all at the same time).

When an error occurs, processing stops and the callback function is called with the got error.

        runAllSimultaneously: (callback = NOP, ctx = null) ->
            assert @pending is false
            assert typeof callback is 'function'

            length = n = @_arr.length / 3
            done = 0

            unless length
                return callback.call(ctx)

            onDone = (err) =>
                ++done

                if done > length
                    return

                if err
                    done = length
                    @pending = false
                    return callback.call ctx, err

                if done is length
                    @pending = false
                    callback.call(ctx)

            # run all functions
            @pending = true
            while n--
                @callNext onDone

            null

    ###
    Exports
    ###
    module.exports = ->
        [utils] = arguments
        utils.async =
            forEach: forEach
            Stack: Stack
