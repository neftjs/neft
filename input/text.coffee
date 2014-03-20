'use strict'

module.exports = (File, Input) -> class InputText extends Input

	constructor: (node) ->

		super node, node.text

	parse: ->

		@node.text = @toString arguments