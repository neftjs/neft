> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Log**

# Log

Access it with:
```javascript
const { log } = Neft;
```

> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee)

## Table of contents
* [Log](#log)
  * [**Class** Log](#class-log)
    * [LOG](#log)
    * [INFO](#info)
    * [OK](#ok)
    * [WARN](#warn)
    * [ERROR](#error)
    * [TIME](#time)
    * [ALL](#all)
    * [*Integer* enabled = log.ALL](#integer-enabled--logall)
    * [log](#log)
    * [info](#info)
    * [ok](#ok)
    * [warn](#warn)
    * [error](#error)
    * [time](#time)
    * [end](#end)
    * [scope](#scope)

## **Class** Log

> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee)

###LOG
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; log.LOG</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
###INFO
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; log.INFO</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
###OK
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; log.OK</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
###WARN
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; log.WARN</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
###ERROR
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; log.ERROR</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
###TIME
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; log.TIME</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
###ALL
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; log.ALL</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee#integer-logall)

### [Integer](/Neft-io/neft/wiki/Utils-API#isinteger) enabled = log.ALL

Bitmask of the `log.LOG`, `INFO`, `OK`, `WARN`, `ERROR` and `TIME`.

> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee)

###log
<dl><dt>Syntax</dt><dd><code>log([&#x2A;Any&#x2A; messages...])</code></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Prints the given messages into the console.

```javascript
log("Log me now!");

log("setName()", "db time");
// will be logged as "setName() → db time"
```

> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee#logany-messages)

###info
<dl><dt>Syntax</dt><dd><code>log.info([&#x2A;Any&#x2A; messages...])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Prints the given messages into the console with a blue color.

> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee#loginfoany-messages)

###ok
<dl><dt>Syntax</dt><dd><code>log.ok([&#x2A;Any&#x2A; messages...])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Prints the given messages into the console with a green color.

```javascript
log.ok("Data has been successfully sent!");
```

> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee#logokany-messages)

###warn
<dl><dt>Syntax</dt><dd><code>log.warn([&#x2A;Any&#x2A; messages...])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Prints the given messages into the console with a yellow color.

```javascript
log.warn("Example warning with some recommendations");
```

> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee#logwarnany-messages)

###error
<dl><dt>Syntax</dt><dd><code>log.error([&#x2A;Any&#x2A; messages...])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Prints the given messages into the console with a red color.

```javascript
log.error("Error occurs, ... in file ...");
```

> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee#logerrorany-messages)

###time
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; log.time()</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
Returns an id used to measure execution time by the `log.end()` function.

```javascript
function findPath(){
  var logtime = log.time('findPath()');

  // ... some complex algorithm ...

  log.end(logtime);
}

findPath();
```

> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee#integer-logtime)

###end
<dl><dt>Syntax</dt><dd><code>log.end(&#x2A;Integer&#x2A; id)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Parameters</dt><dd><ul><li>id — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li></ul></dd></dl>
Prints an information about the execution time for the given timer id.

> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee#logendinteger-id)

###scope
<dl><dt>Syntax</dt><dd><code>log.scope([&#x2A;Any&#x2A; names...])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-log-API#log">log</a></dd><dt>Parameters</dt><dd><ul><li>names... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
Returns a new `log` function.

All prints will be prefixed by the given names.

```javascript
var log = log.scope("Example file");

log("hello");
// "Example file → hello"
```

> [`Source`](/Neft-io/neft/blob/a9c5823f7bf402f93daae77e4b9be80ae5634137/src/log/index.litcoffee#logscopeany-names)

