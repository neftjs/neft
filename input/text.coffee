'use strict'

module.exports = (File, Input) -> class InputText extends Input
	@__name__ = 'InputText'
	@__path__ = 'File.Input.Text'

	JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(InputText) - 1
	{JSON_NODE, JSON_TEXT, JSON_FUNC_BODY} = Input
	JSON_ARGS_LENGTH = Input.JSON_ARGS_LENGTH

	@_fromJSON = (file, arr, obj) ->
		unless obj
			node = file.node.getChildByAccessPath arr[JSON_NODE]
			obj = new InputText file, node, arr[JSON_TEXT], arr[JSON_FUNC_BODY]
		obj

	constructor: (file, node, text, funcBody) ->
		Input.call this, file, node, text, funcBody

		@lastValue = NaN

		`//<development>`
		if @constructor is InputText
			Object.preventExtensions @
		`//</development>`

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

	clone: (original, file) ->
		node = original.node.getCopiedElement @node, file.node

		new InputText file, node, @text, @funcBody

	toJSON: (key, arr) ->
		unless arr
			arr = new Array JSON_ARGS_LENGTH
			arr[0] = JSON_CTOR_ID
		super key, arr
		arr
