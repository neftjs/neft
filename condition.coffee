'use strict'

log = require 'log'

log = log.scope 'View', 'Condition'

module.exports = (File) -> class Condition extends File.Input
	@__name__ = 'Condition'
	@__path__ = 'File.Condition'

	update: ->
		super()
		@node.visible = !!@toString()
		return