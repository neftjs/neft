> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Asynchronous**

# Asynchronous

Access it with:
```javascript
var utils = require('utils');
var async = utils.async;
```

> [`Source`](/Neft-io/neft/tree/master/src/utils/async.litcoffee#asynchronous)

## Table of contents
  * [forEach](#foreach)
  * [**Class** Stack()](#class-stack)
    * [add](#add)
    * [callNext](#callnext)
    * [runAll](#runall)
    * [runAllSimultaneously](#runallsimultaneously)

##forEach
<dl><dt>Parameters</dt><dd><ul><li><b>array</b> — <i>NotPrimitive</i></li><li><b>callback</b> — <i>Function</i></li><li><b>onEnd</b> — <i>Function</i> — <i>optional</i></li><li><b>context</b> — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/async.litcoffee#foreachnotprimitive-array-function-callback-function-onend-any-context)

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

> [`Source`](/Neft-io/neft/tree/master/src/utils/async.litcoffee#class-stack)

###add
<dl><dt>Prototype method of</dt><dd><i>Stack</i></dd><dt>Parameters</dt><dd><ul><li><b>function</b> — <i>Function</i></li><li><b>context</b> — <i>Any</i> — <i>optional</i></li><li><b>arguments</b> — <i>NotPrimitive</i> — <i>optional</i></li></ul></dd></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/utils/async.litcoffee#stackaddfunction-function-any-context-notprimitive-arguments)

###callNext
<dl><dt>Prototype method of</dt><dd><i>Stack</i></dd><dt>Parameters</dt><dd><ul><li><b>arguments</b> — <i>Array</i> — <i>optional</i></li><li><b>callback</b> — <i>Function</i></li></ul></dd></dl>
Calls the first function from the stack and remove it.

> [`Source`](/Neft-io/neft/tree/master/src/utils/async.litcoffee#stackcallnextarray-arguments-function-callback)

###runAll
<dl><dt>Prototype method of</dt><dd><i>Stack</i></dd><dt>Parameters</dt><dd><ul><li><b>callback</b> — <i>Function</i> — <i>optional</i></li><li><b>callbackContext</b> — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Calls all functions from the stack one by one.
When an error occurs, processing stops and the callback function is called with the got error.

> [`Source`](/Neft-io/neft/tree/master/src/utils/async.litcoffee#stackrunallfunction-callback-any-callbackcontext)

###runAllSimultaneously
<dl><dt>Prototype method of</dt><dd><i>Stack</i></dd><dt>Parameters</dt><dd><ul><li><b>callback</b> — <i>Function</i> — <i>optional</i></li><li><b>callbackContext</b> — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Calls all functions from the stack simultaneously (all at the same time).
When an error occurs, processing stops and the callback function is called with the got error.

> [`Source`](/Neft-io/neft/tree/master/src/utils/async.litcoffee#stackrunallsimultaneouslyfunction-callback-any-callbackcontext)

