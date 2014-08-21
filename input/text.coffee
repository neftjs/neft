'use strict'

module.exports = (File, Input) -> class InputText extends Input

	@__name__ = 'InputText'
	@__path__ = 'File.Input.Text'

	constructor: (node) ->

		super node, node.text

	parse: (file) ->
		str = @toString file
		str += '' if typeof str isnt 'string'
		@node.text = str