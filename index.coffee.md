Log
===

**Colored console**

Simply to use and good looking logger used to log `info`, `warn`,
`error` messages and functions processing times.

Built to be easily implemented for the standard console output and for browsers.

All loggs are removing for the *release* mode.

```
var log = require('log');
```

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'

	{bind} = Function
	{isArray} = Array
	{unshift} = Array::

	fromArgs = (args) ->

		str = ''
		str += "#{arg} → " for arg in args
		str.substring 0, str.length - 3

	class Log

		@LOGS_METHODS = ['info', 'warn', 'error', 'time']

		@TIMES_LEN = 50

		@MARKERS =
			white: (str) -> "LOG: #{str}"
			green: (str) -> "OK: #{str}"
			gray: (str) -> "#{str}"
			blue: (str) -> "INFO: #{str}"
			yellow: (str) -> "WARN: #{str}"
			red: (str) -> "ERROR: #{str}"
			bold: (str) -> "**#{str}**"

		@time = Date.now
		@timeDiff = (since) -> Log.time() - since
		@times = new Array Log.TIMES_LEN

		prefixes: null

		constructor: (@prefixes) ->

			if prefixes
				assert.isArray prefixes

				# bind all logs methods by prefixes
				args = utils.clone(prefixes)
				args.unshift @

				for name in LogImpl.LOGS_METHODS
					@[name] = bind.apply @[name], args

			@[key] = value for key, value of @
			return utils.merge @log.bind(@), @

		_write: console?.log or (->)

log([*Any* messages...])
------------------------

The most basic function used to write into console.

All passed arguments are concatenated with right arrow (`→`).

Logged text is white.

```coffeescript
log("Log me now!");

log("setName()", "db time");
// will be logged as "setName() → db time"
```

		log: -> @_write LogImpl.MARKERS.white fromArgs arguments

log.info([*Any* messages...])
-----------------------------

Method used to log some useful informations for debugging, to mark progress.

Logged text is blue.

		info: -> @_write LogImpl.MARKERS.blue fromArgs arguments

log.ok([*Any* messages...])
---------------------------

Use this method to mark successful operations.

Logged text is green.

```
log.ok("Data has been successfully sent!");
```

		ok: -> @_write LogImpl.MARKERS.green fromArgs arguments

log.warn([*Any* messages...])
-----------------------------

For warnings, use this method.

Logged text if yellow.

```
log.warn("Example warning with some recommendations");
```

		warn: -> @_write LogImpl.MARKERS.yellow fromArgs arguments

log.error([*Any* messages...])
------------------------------

If during processing, some errors occurs, use thid method to log them.

Logged text is red.

```
log.error("Error occurs, ... in file ...");
```

		error: -> @_write LogImpl.MARKERS.red fromArgs arguments

log.time()
----------

This method and `end()` are used to debug how long the operation takes.

All logs logged after this method and before `end()` will be indented.

Use it only for the synchronous operations.

It's a good practice to always name variable which keeps returned *time id* as `logtime`.

```
function findPath(){
  var logtime = log.time('findPath()');

  // ... some complex algorithm ...

  log.end(logtime);
}

findPath();
```

		time: ->
			{times} = LogImpl

			# write
			@_write LogImpl.MARKERS.bold fromArgs arguments

			# get time id and set current time
			for v, i in times when not v
				id = i
				times[i] = LogImpl.time()
				break

			assert id?, "Log times out of range"

			id

log.end(*Integer* id)
---------------------

This method is used to mark when counting time ends.

See `time()` method for more informations and example.

		end: (id) ->
			time = LogImpl.times[id]
			diff = LogImpl.timeDiff time
			LogImpl.times[id] = null

			str = "#{diff} ms"
			@_write LogImpl.MARKERS.gray str

log.scope([*Any* names...])
---------------------------

This methods returns new logger with binded functions.

Use this function to always log with some special prefix (e.g. module name).

```
var log = log.scope("Example file");

log("hello");
// "Example file → hello"

log.info("Let's go!");
// "Example file → Let's go"
```

		scope: (args...) ->
			if @prefixes
				unshift.apply args, @prefixes

			new LogImpl args

	# implementation
	impl = switch true
		when utils.isNode
			require './impls/node/index.coffee'
		when utils.isBrowser
			require './impls/browser/index.coffee'

	LogImpl = if impl then impl Log else Log
	module.exports = new LogImpl
