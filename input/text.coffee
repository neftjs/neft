'use strict'

module.exports = (File, Input) -> class InputText extends Input
	@__name__ = 'InputText'
	@__path__ = 'File.Input.Text'

	constructor: (node, func) ->
		@lastValue = NaN
		super node, func

	update: ->
		super()
		str = @toString()
		unless str?
			str = ''
		else if typeof str isnt 'string'
			str += ''
		if str isnt @lastValue
			@lastValue = str
			@node.text = str
		return