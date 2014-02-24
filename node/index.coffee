'use strict'

[cli] = ['cli-color'].map require

writeStdout = process.stdout.write.bind process.stdout

module.exports = (Log) -> class LogNode extends Log

	@MARKERS =
		white: cli.white
		gray: cli.blackBright
		blue: cli.blue
		yellow: cli.yellow
		red: cli.red
		bold: cli.bold

	@time = process.hrtime
	@timeDiff = (since) ->
		diff = process.hrtime since
		(diff[0] * 1e9 + diff[1]) / 1e6

	_write: writeStdout

###
	colors = clc

	write = (msg) ->

		assert msg and typeof msg is 'string'

		prefix = colors.blackBright getTimesLines()
		writeStdout prefix + msg

	newline = -> writeStdout '\n'

	getTimesLines = ->

		str = ''

		for time in times
			str += if time then '│ ' else '  '

		str

	


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
		writeStdout colors.blackBright(str) + clc.bold fromArgs arguments

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
		writeStdout colors.blackBright str
###