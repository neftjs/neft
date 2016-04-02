'use strict'

performance = do ->
	if window.performance?.now
		window.performance
	else
		Date

logFunc = window['cons'+'ole']['lo'+'g']

module.exports = do ->
	if ///chrome|safari///i.test(navigator.userAgent) or webkit?
		(Log) -> class LogBrowser extends Log
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

			@time = performance.now.bind performance
			@timeDiff = (since) ->
				LogBrowser.time() - since

			_write: (marker) ->
				logFunc.apply window['cons'+'ole'], marker

			_writeError: (marker) ->
				@_write marker
	else
		{}
