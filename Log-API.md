> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Log**

# Log

Access it with:
```javascript
const { log } = Neft;
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#log)

## Table of contents
  * [**Class** Log](#class-log)
    * [LOG](#log)
    * [enabled](#enabled)
    * [log](#log)
    * [info](#info)
    * [ok](#ok)
    * [warn](#warn)
    * [error](#error)
    * [time](#time)
    * [end](#end)
    * [scope](#scope)

## **Class** Log

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#class-log)

###LOG
> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#integer-loglog-integer-loginfo-integer-logok-integer-logwarn-integer-logerror-integer-logtime-integer-logall)

###enabled
Bitmask of the `log.LOG`, `INFO`, `OK`, `WARN`, `ERROR` and `TIME`.

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#integer-enabled--logall)

###log
Prints the given messages into the console.
```javascript
log("Log me now!");
log("setName()", "db time");
// will be logged as "setName() → db time"
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logany-messages)

###info
Prints the given messages into the console with a blue color.

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#loginfoany-messages)

###ok
Prints the given messages into the console with a green color.
```javascript
log.ok("Data has been successfully sent!");
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logokany-messages)

###warn
Prints the given messages into the console with a yellow color.
```javascript
log.warn("Example warning with some recommendations");
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logwarnany-messages)

###error
Prints the given messages into the console with a red color.
```javascript
log.error("Error occurs, ... in file ...");
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logerrorany-messages)

###time
Returns an id used to measure execution time by the `log.end()` function.
```javascript
function findPath(){
  var logtime = log.time('findPath()');
  // ... some complex algorithm ...
  log.end(logtime);
}
findPath();
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#integer-logtime)

###end
Prints an information about the execution time for the given timer id.

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logendinteger-id)

###scope
Returns a new `log` function.
All prints will be prefixed by the given names.
```javascript
var log = log.scope("Example file");
log("hello");
// "Example file → hello"
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logscopeany-names)

