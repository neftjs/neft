'use strict'

assert = require 'assert'

module.exports = (File, _super) -> (file) ->

	assert file.render.isParsed

	_super arguments...