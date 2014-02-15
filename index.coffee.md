Log
===

Logger used to log `info`, `warn`, `error` messages and functions processing times.

	'use strict'

	assert = require 'assert'
	clc = require 'cli-color'

	writeStdout = process.stdout.write.bind process.stdout
	{white, blackBright, blue, yellow, red} = clc
	{bind} = Function
	{unshift} = Array::

	write = (msg) ->

		assert msg and typeof msg is 'string'

		prefix = blackBright getTimesLines()
		writeStdout prefix + msg

	newline = -> writeStdout '\n'

	getTimesLines = ->

		str = ''

		for time in times
			str += if time then '│ ' else '  '

		str

	fromArgs = (args) ->

		str = ''

		str += "#{arg} → " for arg in args

		str.substring 0, str.length - 3

	exports = module.exports = ->

		newline()
		write white fromArgs arguments

	info = exports.info = ->

		newline()
		write blue fromArgs arguments

	warn = exports.warn = ->

		newline()
		write yellow fromArgs arguments

	error = exports.error = ->

		newline()
		write red fromArgs arguments

	scope = exports.scope = ->

		unshift.call arguments, null

		func = exports.bind null
		func.info = bind.apply info, arguments
		func.warn = bind.apply warn, arguments
		func.error = bind.apply error, arguments
		func.time = bind.apply time, arguments
		func.scope = bind.apply scope, arguments
		func.end = end

		func

	times = []

	time = exports.time = ->

		pos = -1

		for time, i in times
			unless time
				pos = i
				break

		if pos is -1
			pos = times.push(null) - 1

		times[pos] = process.hrtime()

		str = getTimesLines()
		charpos = pos * 2
		str = str.substr(0, charpos) + '┌ '

		newline()
		writeStdout blackBright(str) + clc.bold fromArgs arguments

		pos

	end = exports.end = (time) ->

		diff = process.hrtime times[time]
		diff = (diff[0] * 1e9 + diff[1]) / 1e6

		times[time] = null

		if time is times.length - 1
			i = times.length
			while i--
				if times[i] isnt null
					break
				times.pop()

		str = getTimesLines()
		charpos = time * 2
		str = str.substr(0, charpos) + "└ #{diff} ms"

		newline()
		writeStdout blackBright str