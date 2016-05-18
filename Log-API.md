> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Log**

# Log

Access it with:
```javascript
const { log } = Neft;
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#log)

## Table of contents
  * [**Class** Log](#class-log)
    * [log.LOG](#integer-loglog)
    * [enabled = log.ALL](#integer-enabled--logall)
    * [log([messages...])](#logany-messages)
    * [log.info([messages...])](#loginfoany-messages)
    * [log.ok([messages...])](#logokany-messages)
    * [log.warn([messages...])](#logwarnany-messages)
    * [log.error([messages...])](#logerrorany-messages)
    * [log.time()](#integer-logtime)
    * [log.end(id)](#logendinteger-id)
    * [log.scope([names...])](#logscopeany-names)

## **Class** Log

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#class-log)

### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) log.LOG
### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) log.INFO
### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) log.OK
### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) log.WARN
### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) log.ERROR
### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) log.TIME
### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) log.ALL

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#integer-loglog-integer-loginfo-integer-logok-integer-logwarn-integer-logerror-integer-logtime-integer-logall)

### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) enabled = log.ALL

Bitmask of the `log.LOG`, `INFO`, `OK`, `WARN`, `ERROR` and `TIME`.

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#integer-enabled--logall)

### log([*Any* messages...])

Prints the given messages into the console.
```javascript
log("Log me now!");
log("setName()", "db time");
// will be logged as "setName() → db time"
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logany-messages)

### log.info([*Any* messages...])

Prints the given messages into the console with a blue color.

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#loginfoany-messages)

### log.ok([*Any* messages...])

Prints the given messages into the console with a green color.
```javascript
log.ok("Data has been successfully sent!");
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logokany-messages)

### log.warn([*Any* messages...])

Prints the given messages into the console with a yellow color.
```javascript
log.warn("Example warning with some recommendations");
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logwarnany-messages)

### log.error([*Any* messages...])

Prints the given messages into the console with a red color.
```javascript
log.error("Error occurs, ... in file ...");
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logerrorany-messages)

### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) log.time()

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

### log.end([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) id)

Prints an information about the execution time for the given timer id.

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logendinteger-id)

### log.scope([*Any* names...])

Returns a new `log` function.
All prints will be prefixed by the given names.
```javascript
var log = log.scope("Example file");
log("hello");
// "Example file → hello"
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logscopeany-names)

