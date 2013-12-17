'use strict'

module.exports = (File) -> -> (file, opts, callback) ->

	file.isParsing = false
	file.isParsed = true

	callback null