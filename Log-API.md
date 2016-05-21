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
    * [log.end(*Integer* id)](#logendinteger-id)
    * [log.scope([*Any* names...])](#logscopeany-names)

## **Class** Log

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#class-log)

<dl><dt>Static property of</dt><dd><i>log</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>
###LOG
> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#integer-loglog-integer-loginfo-integer-logok-integer-logwarn-integer-logerror-integer-logtime-integer-logall)

<dl><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>log.ALL</code></dd></dl>
###enabled
Bitmask of the `log.LOG`, `INFO`, `OK`, `WARN`, `ERROR` and `TIME`.

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#integer-enabled--logall)

<dl><dt>Parameters</dt><dd><ul><li><b>messages...</b> — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
###log
Prints the given messages into the console.
```javascript
log("Log me now!");
log("setName()", "db time");
// will be logged as "setName() → db time"
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logany-messages)

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li><b>messages...</b> — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
###info
Prints the given messages into the console with a blue color.

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#loginfoany-messages)

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li><b>messages...</b> — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
###ok
Prints the given messages into the console with a green color.
```javascript
log.ok("Data has been successfully sent!");
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logokany-messages)

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li><b>messages...</b> — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
###warn
Prints the given messages into the console with a yellow color.
```javascript
log.warn("Example warning with some recommendations");
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logwarnany-messages)

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li><b>messages...</b> — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
###error
Prints the given messages into the console with a red color.
```javascript
log.error("Error occurs, ... in file ...");
```

> [`Source`](/Neft-io/neft/tree/master/src/log/index.litcoffee#logerrorany-messages)

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Returns</dt><dd><i>Integer</i></dd></dl>
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

