# Log

> **API Reference** ▸ **Log**

<!-- toc -->
Access it with:
```javascript
const { log } = Neft;
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/log/index.litcoffee)


* * * 

### `log.LOG`

<dl><dt>Static property of</dt><dd><i>log</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>


* * * 

### `log.INFO`

<dl><dt>Static property of</dt><dd><i>log</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>


* * * 

### `log.OK`

<dl><dt>Static property of</dt><dd><i>log</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>


* * * 

### `log.WARN`

<dl><dt>Static property of</dt><dd><i>log</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>


* * * 

### `log.ERROR`

<dl><dt>Static property of</dt><dd><i>log</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>


* * * 

### `log.TIME`

<dl><dt>Static property of</dt><dd><i>log</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>


* * * 

### `log.ALL`

<dl><dt>Static property of</dt><dd><i>log</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/log/index.litcoffee#integer-logall)


* * * 

### `enabled`

<dl><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>log.ALL</code></dd></dl>

Bitmask of the `log.LOG`, `INFO`, `OK`, `WARN`, `ERROR` and `TIME`.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/log/index.litcoffee#integer-enabled--logall)


* * * 

### `log()`

<dl><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

Prints the given messages into the console.

```javascript
log("Log me now!");

log("setName()", "db time");
// will be logged as "setName() → db time"
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/log/index.litcoffee#logany-messages)


* * * 

### `log.info()`

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

Prints the given messages into the console with a blue color.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/log/index.litcoffee#loginfoany-messages)


* * * 

### `log.ok()`

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

Prints the given messages into the console with a green color.

```javascript
log.ok("Data has been successfully sent!");
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/log/index.litcoffee#logokany-messages)


* * * 

### `log.warn()`

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

Prints the given messages into the console with a yellow color.

```javascript
log.warn("Example warning with some recommendations");
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/log/index.litcoffee#logwarnany-messages)


* * * 

### `log.error()`

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>messages... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

Prints the given messages into the console with a red color.

```javascript
log.error("Error occurs, ... in file ...");
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/log/index.litcoffee#logerrorany-messages)


* * * 

### `log.time()`

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>

Returns an id used to measure execution time by the `log.end()` function.

```javascript
function findPath(){
  var logtime = log.time('findPath()');

  // ... some complex algorithm ...

  log.end(logtime);
}

findPath();
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/log/index.litcoffee#array-logtime)


* * * 

### `log.end()`

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>logTime — <i>Array</i></li></ul></dd></dl>

Prints an information about the execution time for the given timer id.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/log/index.litcoffee#logendarray-logtime)


* * * 

### `log.scope()`

<dl><dt>Static method of</dt><dd><i>log</i></dd><dt>Parameters</dt><dd><ul><li>names... — <i>Any</i> — <i>optional</i></li></ul></dd></dl>

Returns a new `log` function.

All prints will be prefixed by the given names.

```javascript
var log = log.scope("Example file");

log("hello");
// "Example file → hello"
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/log/index.litcoffee#logscopeany-names)

