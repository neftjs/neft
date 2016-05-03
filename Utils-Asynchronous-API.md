Asynchronous
============

Access it with:
```javascript
var utils = require('utils');
var async = utils.async;
```

forEach(*NotPrimitive* array, *Function* callback, [*Function* onEnd, *Any* context])
-------------------------------------------------------------------------------------

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

*Stack* Stack()
---------------

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

Stack::add(*Function* function, [*Any* context, *NotPrimitive* arguments])
--------------------------------------------------------------------------

Adds the given function to the stack.

The function must provide a callback argument as the last argument.
The first argument of the callback function is always an error.

```javascript
var stack = new utils.async.Stack;

function add(a, b, callback){
  if (isFinite(a) && isFinite(b)){
  } else {
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

Stack::callNext([*Array* arguments], *Function* callback)
---------------------------------------------------------

Calls the first function from the stack and remove it.

Stack::runAll([*Function* callback, *Any* callbackContext])
-----------------------------------------------------------

Calls all functions from the stack one by one.

When an error occurs, processing stops and the callback function is called with the got error.

Stack::runAllSimultaneously([*Function* callback, *Any* callbackContext])
-------------------------------------------------------------------------

Calls all functions from the stack simultaneously (all at the same time).

When an error occurs, processing stops and the callback function is called with the got error.

