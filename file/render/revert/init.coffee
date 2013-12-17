'use strict'

assert = require 'assert'

module.exports = (File) -> (_super) -> (file) ->

	assert file.isParsed

	_super arguments...