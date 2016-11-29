# Asynchronous

> **API Reference** ▸ [Utils](/api/utils.md) ▸ **Asynchronous**

<!-- toc -->
Access it with:
```javascript
var utils = require('utils');
var async = utils.async;
```


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/utils/async.litcoffee)


* * * 

### `utils.async.forEach()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>array — <i>NotPrimitive</i></li><li>callback — <i>Function</i></li><li>onEnd — <i>Function</i> — <i>optional</i></li><li>context — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/utils/async.litcoffee#utilsasyncforeachnotprimitive-array-function-callback-function-onend-any-context)

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


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/utils/async.litcoffee)


* * * 

### `add()`

<dl><dt>Parameters</dt><dd><ul><li>function — <i>Function</i></li><li>context — <i>Any</i> — <i>optional</i></li><li>arguments — <i>NotPrimitive</i> — <i>optional</i></li></ul></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/utils/async.litcoffee#stackaddfunction-function-any-context-notprimitive-arguments)


* * * 

### `callNext()`

<dl><dt>Parameters</dt><dd><ul><li>arguments — <i>Array</i> — <i>optional</i></li><li>callback — <i>Function</i></li></ul></dd></dl>

Calls the first function from the stack and remove it.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/utils/async.litcoffee#stackcallnextarray-arguments-function-callback)


* * * 

### `runAll()`

<dl><dt>Parameters</dt><dd><ul><li>callback — <i>Function</i> — <i>optional</i></li><li>callbackContext — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

Calls all functions from the stack one by one.

When an error occurs, processing stops and the callback function is called with the got error.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/utils/async.litcoffee#stackrunallfunction-callback-any-callbackcontext)


* * * 

### `runAllSimultaneously()`

<dl><dt>Parameters</dt><dd><ul><li>callback — <i>Function</i> — <i>optional</i></li><li>callbackContext — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

Calls all functions from the stack simultaneously (all at the same time).

When an error occurs, processing stops and the callback function is called with the got error.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/utils/async.litcoffee#stackrunallsimultaneouslyfunction-callback-any-callbackcontext)

