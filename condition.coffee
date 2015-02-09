'use strict'

assert = require 'assert'
utils = require 'utils'
log = require 'log'

assert = assert.scope 'View.Condition'
log = log.scope 'View', 'Condition'

module.exports = (File) -> class Condition extends File.Input
	@__name__ = 'Condition'
	@__path__ = 'File.Condition'

	@HTML_ATTR = "#{File.HTML_NS}:if"

	constructor: (node, text) ->
		if text.indexOf '#{' is -1
			text = '#{'+text+'}'

		`//<development>`
		if text.indexOf '#{' isnt -1
			log.warn "neft:if `#{text}` contains string interpolation, but neft:if always is a string interpolation"
		`//</development>`

		super node, text

	update: ->
		super
		@node.visible = !!@toString()
