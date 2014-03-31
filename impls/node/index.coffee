'use strict'

[cli] = ['cli-color'].map require

writeStdout = process.stdout.write.bind process.stdout

module.exports = (Log) -> class LogNode extends Log

	@MARKERS =
		white: cli.white
		green: cli.green
		gray: cli.blackBright
		blue: cli.blue
		yellow: cli.yellow
		red: cli.red
		bold: cli.bold

	@time = process.hrtime
	@timeDiff = (since) ->
		diff = process.hrtime since
		(diff[0] * 1e9 + diff[1]) / 1e6

	_write: (msg) ->

		prefix = ''
		for time in Log.times
			prefix += time? and '  ' or ''

		writeStdout "#{prefix}#{msg}\n"