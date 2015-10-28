'use strict'

module.exports = (File, Input) -> class InputText extends Input
	@__name__ = 'InputText'
	@__path__ = 'File.Input.Text'

	update: ->
		super()
		str = @toString()
		unless str?
			str = ''
		else if typeof str isnt 'string'
			str += ''
		@node.text = str
		return