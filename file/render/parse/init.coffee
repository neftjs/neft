'use strict'

assert = require 'assert'

module.exports = (File, _super) -> (file, opts, callback) ->

	assert not file.render.isParsing
	assert not file.render.isParsed

	unless callback
		callback = opts
		opts = null

	assert typeof opts is 'object'
	assert typeof callback is 'function'

	file.render.isParsing = true

	_super.call null, file, opts, callback