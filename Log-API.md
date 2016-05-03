Log @library
============

Access it with:
```javascript
var log = require('log');
```

*Integer* log.LOG
-----------------

*Integer* log.INFO
------------------

*Integer* log.OK
----------------

*Integer* log.WARN
------------------

*Integer* log.ERROR
-------------------

*Integer* log.TIME
------------------

*Integer* log.ALL
-----------------

*Integer* enabled = log.ALL
---------------------------

Bitmask of the `log.LOG`, `INFO`, `OK`, `WARN`, `ERROR` and `TIME`.

log([*Any* messages...])
------------------------

Prints the given messages into the console.

```javascript
log("Log me now!");

log("setName()", "db time");
// will be logged as "setName() → db time"
```

log.info([*Any* messages...])
-----------------------------

Prints the given messages into the console with a blue color.

log.ok([*Any* messages...])
---------------------------

Prints the given messages into the console with a green color.

```javascript
log.ok("Data has been successfully sent!");
```

log.warn([*Any* messages...])
-----------------------------

Prints the given messages into the console with a yellow color.

```javascript
log.warn("Example warning with some recommendations");
```

log.error([*Any* messages...])
------------------------------

Prints the given messages into the console with a red color.

```javascript
log.error("Error occurs, ... in file ...");
```

*Integer* log.time()
--------------------

Returns an id used to measure execution time by the `log.end()` function.

```javascript
function findPath(){
  var logtime = log.time('findPath()');

  // ... some complex algorithm ...

  log.end(logtime);
}

findPath();
```

log.end(*Integer* id)
---------------------

Prints an information about the execution time for the given timer id.

log.scope([*Any* names...])
---------------------------

Returns a new `log` function.

All prints will be prefixed by the given names.

```javascript
var log = log.scope("Example file");

log("hello");
// "Example file → hello"
```

