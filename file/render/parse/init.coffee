'use strict'

assert = require 'assert'

module.exports = (File, _super) -> (file, opts, callback) ->

	assert not file.isParsing
	assert not file.isParsed

	unless callback
		callback = opts
		opts = null

	assert typeof opts is 'object'
	assert typeof callback is 'function'

	file.isParsing = true

	_super.call null, file, opts, callback