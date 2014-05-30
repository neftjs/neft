Log
===

Logger used to log `info`, `warn`, `error` messages and functions processing times.

	'use strict'

	[utils] = ['utils'].map require

	{assert} = console
	{bind} = Function
	{isArray} = Array
	{unshift} = Array::

	fromArgs = (args) ->

		str = ''
		str += "#{arg} → " for arg in args
		str.substring 0, str.length - 3

*class* Log
-----------

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

				assert isArray prefixes

				# bind all logs methods by prefixes
				args = utils.clone(prefixes)
				args.unshift @

				for name in LogImpl.LOGS_METHODS
					@[name] = bind.apply @[name], args

			@[key] = value for key, value of @
			return utils.merge @log.bind(@), @

		_write: console?.log or (->)

		scope: (args...) ->

			if @prefixes
				unshift.apply args, @prefixes

			new LogImpl args

		log: -> @_write LogImpl.MARKERS.white fromArgs arguments

		info: -> @_write LogImpl.MARKERS.blue fromArgs arguments

		ok: -> @_write LogImpl.MARKERS.green fromArgs arguments

		warn: -> @_write LogImpl.MARKERS.yellow fromArgs arguments

		error: -> @_write LogImpl.MARKERS.red fromArgs arguments

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

		end: (id) ->

			time = LogImpl.times[id]
			diff = LogImpl.timeDiff time
			LogImpl.times[id] = null

			str = "#{diff} ms"
			@_write LogImpl.MARKERS.gray str

Implementation
--------------

	impl = switch true
		when utils.isNode
			require './impls/node/index.coffee'
		when utils.isBrowser
			require './impls/browser/index.coffee'

	LogImpl = if impl then impl Log else Log
	module.exports = new LogImpl
