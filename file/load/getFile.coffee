'use strict'

if window?

	module.exports = (uri, callback) ->

		xhr = new XMLHttpRequest()

		xhr.onerror = callback

		xhr.onreadystatechange = ->

			if xhr.readyState isnt 4 then return
			if @status isnt 200 then return callback true

			callback null, xhr.response

		xhr.open('GET', uri, true)

		xhr.send()

else

	fs = require 'fs'

	module.exports = (uri, callback) ->

		fs.readFile uri, 'utf-8', callback
