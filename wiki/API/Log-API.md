> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Log**

# Log

Access it with:
```javascript
const { log } = Neft;
```

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#log)

## Table of contents
* [Log](#log)
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

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#class-log)

###LOG
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; log.LOG</code></dd><dt>Static property of</dt><dd><i>log</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#isinteger">Integer</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#log)

###enabled
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; enabled = log.ALL</code></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#isinteger">Integer</a></dd><dt>Default</dt><dd><code>log.ALL</code></dd></dl>
Bitmask of the `log.LOG`, `INFO`, `OK`, `WARN`, `ERROR` and `TIME`.

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#enabled)

###log
<dl><dt>Syntax</dt><dd><code>log([&#x2A;Any&#x2A; messages...])</code></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Prints the given messages into the console.

```javascript
log("Log me now!");

log("setName()", "db time");
// will be logged as "setName() → db time"
```

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#log)

###info
<dl><dt>Syntax</dt><dd><code>log.info([&#x2A;Any&#x2A; messages...])</code></dd><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Prints the given messages into the console with a blue color.

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#info)

###ok
<dl><dt>Syntax</dt><dd><code>log.ok([&#x2A;Any&#x2A; messages...])</code></dd><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Prints the given messages into the console with a green color.

```javascript
log.ok("Data has been successfully sent!");
```

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#ok)

###warn
<dl><dt>Syntax</dt><dd><code>log.warn([&#x2A;Any&#x2A; messages...])</code></dd><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Prints the given messages into the console with a yellow color.

```javascript
log.warn("Example warning with some recommendations");
```

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#warn)

###error
<dl><dt>Syntax</dt><dd><code>log.error([&#x2A;Any&#x2A; messages...])</code></dd><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Prints the given messages into the console with a red color.

```javascript
log.error("Error occurs, ... in file ...");
```

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#error)

###time
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; log.time()</code></dd><dt>Static method of</dt><dd><i>log</i></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#isinteger">Integer</a></dd></dl>
Returns an id used to measure execution time by the `log.end()` function.

```javascript
function findPath(){
  var logtime = log.time('findPath()');

  // ... some complex algorithm ...

  log.end(logtime);
}

findPath();
```

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#time)

###end
<dl><dt>Syntax</dt><dd><code>log.end(&#x2A;Integer&#x2A; id)</code></dd><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>id — <a href="/Neft-io/neft/wiki/Utils-API.md#isinteger">Integer</a></li></ul></dd></dl>
Prints an information about the execution time for the given timer id.

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#end)

###scope
<dl><dt>Syntax</dt><dd><code>log.scope([&#x2A;Any&#x2A; names...])</code></dd><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>names... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Returns a new `log` function.

All prints will be prefixed by the given names.

```javascript
var log = log.scope("Example file");

log("hello");
// "Example file → hello"
```

> [`Source`](/Neft-io/neft/blob/8a7d1218650a3ad43d88cdbda24dae5a72a732ea/src/log/index.litcoffee#scope)

