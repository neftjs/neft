'use strict'

module.exports = (File, Input) -> class InputText extends Input
	@__name__ = 'InputText'
	@__path__ = 'File.Input.Text'

	update: ->
		super()
		str = @toString()
		str += '' if typeof str isnt 'string'
		@node.text = str
		return