Log @library
===

**Colored console**

Simple to use and good looking logger used to log informations, warnings, 
error messages and functions processing times.

All logs are removed for the *release* mode.

Access it with:
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
		@LOGS_METHODS = ['info', 'warn', 'error', 'time', 'ok']

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

		for _, i in @times
			@times[i] = [0, '']

		constructor: (prefixes) ->
			@prefixes = prefixes
			if prefixes
				assert.isArray prefixes

				# bind all logs methods by prefixes
				args = utils.clone(prefixes)
				args.unshift @

				for name in LogImpl.LOGS_METHODS
					@[name] = bind.apply @[name], args

			@[key] = value for key, value of @
			if typeof @['lo'+'g'] is 'function'
				func = =>
					@log.apply func, arguments
				return utils.merge func, @

		_write: console?['lo'+'g'].bind(console) or (->)

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

		i = 0
		LOG: 1<<i++
		INFO: 1<<i++
		OK: 1<<i++
		WARN: 1<<i++
		ERROR: 1<<i++
		TIME: 1<<i++
		ALL: (1<<i++)-1

*Integer* enabled = log.ALL
---------------------------

		enabled: @::ALL

log([*Any* messages...])
------------------------

This is the most basic function used to write logs.

All passed arguments are concatenated using right arrow (`→`).

Logged text is white.

```
log("Log me now!");

log("setName()", "db time");
// will be logged as "setName() → db time"
```

		@::['log'] = ->
			if @enabled & @LOG
				@_write LogImpl.MARKERS.white fromArgs arguments
			return

log.info([*Any* messages...])
-----------------------------

This function is used to log debugging informations or to mark progress.

Logged text is blue.

		info: ->
			if @enabled & @INFO
				@_write LogImpl.MARKERS.blue fromArgs arguments
			return

log.ok([*Any* messages...])
---------------------------

This function is used to mark successful operations.

Logged text is green.

```
log.ok("Data has been successfully sent!");
```

		ok: ->
			if @enabled & @OK
				@_write LogImpl.MARKERS.green fromArgs arguments
			return

log.warn([*Any* messages...])
-----------------------------

This function is used to log warnings.

Logged text is yellow.

```
log.warn("Example warning with some recommendations");
```

		warn: ->
			if @enabled & @WARN
				@_write LogImpl.MARKERS.yellow fromArgs arguments
			return

log.error([*Any* messages...])
------------------------------

This function is used to log errors.

Logged text is red.

```
log.error("Error occurs, ... in file ...");
```

		error: ->
			if @enabled & @ERROR
				@_write LogImpl.MARKERS.red fromArgs arguments
			return

*Integer* log.time()
--------------------

This method is used to log how long some operation takes.

All logs logged after this method and before *log.end()* will be indented.

Use it only for the synchronous operations.

It's a good practice to always name variable which keeps returning *time id* as *logtime*.

```
function findPath(){
  var logtime = log.time('findPath()');

  // ... some complex algorithm ...

  log.end(logtime);
}

findPath();
```

		time: ->
			unless @enabled & @TIME
				return -1

			{times} = LogImpl

			# get time id and set current time
			for v, i in times when not v[0]
				id = i
				times[i][0] = LogImpl.time()
				times[i][1] = fromArgs arguments
				break

			assert id?, "Log times out of range"

			id

log.end(*Integer* id)
---------------------

This method is used to mark when counting time ends.

See *log.time()* method for more informations and example.

		end: (id) ->
			if id is -1
				return

			time = LogImpl.times[id]
			diff = LogImpl.timeDiff time[0]
			diff = diff.toFixed 2

			str = "#{time[1]}: #{diff} ms"
			@_write LogImpl.MARKERS.gray str

			time[0] = 0
			return

log.scope([*Any* names...])
---------------------------

This method returns a new logger with bound functions.

Use this function to always log with a special prefix (e.g. module name).

```
var log = log.scope("Example file");

log("hello");
// "Example file → hello"
```

		scope: (args...) ->
			if @prefixes
				unshift.apply args, @prefixes

			new LogImpl args

	# implementation
	impl = switch true
		when utils.isNode
			require './impls/node/index.coffee'
		when utils.isBrowser, utils.isIOS
			require './impls/browser/index.coffee'

	LogImpl = if typeof impl is 'function' then impl Log else Log
	module.exports = new LogImpl
