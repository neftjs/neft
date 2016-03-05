'use strict'

module.exports = (File, Input) -> class InputText extends Input
	@__name__ = 'InputText'
	@__path__ = 'File.Input.Text'

	JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(InputText) - 1
	{JSON_NODE, JSON_TEXT, JSON_BINDING} = Input
	JSON_ARGS_LENGTH = Input.JSON_ARGS_LENGTH

	@_fromJSON = (file, arr, obj) ->
		unless obj
			node = file.node.getChildByAccessPath arr[JSON_NODE]
			obj = new InputText file, node, arr[JSON_TEXT], arr[JSON_BINDING]
		obj

	constructor: (file, node, text, binding) ->
		Input.call this, file, node, text, binding

		if file.isClone
			@registerBinding()

		`//<development>`
		if @constructor is InputText
			Object.seal @
		`//</development>`

	getValue: ->
		@node.text

	setValue: (val) ->
		unless val?
			val = ''
		else if typeof val isnt 'string'
			val += ''
		@node.text = val

	clone: (original, file) ->
		node = original.node.getCopiedElement @node, file.node

		new InputText file, node, @text, @binding

	toJSON: (key, arr) ->
		unless arr
			arr = new Array JSON_ARGS_LENGTH
			arr[0] = JSON_CTOR_ID
		super key, arr
		arr
