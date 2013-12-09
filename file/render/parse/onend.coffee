'use strict'

module.exports = (File) -> (file, opts, callback) ->

	file.render.isParsing = false
	file.render.isParsed = true

	callback null