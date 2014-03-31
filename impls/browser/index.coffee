'use strict'

performance = window.performance or Date

log = console.error # for stack

module.exports = (Log) -> class LogBrowser extends Log

	@MARKERS = do ->
		tmp = ['', '']
		marker = (color, style='normal', msg) ->
			tmp[0] = "%c#{msg}"
			tmp[1] = "color: #{color}; font-weight: #{style}"
			tmp

		white: marker.bind null, 'black', null
		green: marker.bind null, 'green', null
		gray: marker.bind null, 'gray', null
		blue: marker.bind null, 'blue', null
		yellow: marker.bind null, 'orange', null
		red: marker.bind null, 'red', null
		bold: marker.bind null, 'black', 'bold'

	@time = performance.now
	@timeDiff = (since) ->
		diff = LogBrowser.time() - since
		(diff[0] * 1e9 + diff[1]) / 1e6

	_write: (marker) ->

		prefix = ''
		for time in Log.times
			prefix += time? and '--' or ''

		marker[0] = "#{prefix}#{marker[0]}"

		log.apply console, marker