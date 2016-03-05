'use strict'

assert = require 'neft-assert'
utils = require 'neft-utils'

module.exports = (File, Input) -> class InputAttr extends Input
	@__name__ = 'InputAttr'
	@__path__ = 'File.Input.Attr'

	JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(InputAttr) - 1

	i = Input.JSON_ARGS_LENGTH
	{JSON_NODE, JSON_TEXT, JSON_BINDING} = Input
	JSON_ATTR_NAME = i++
	JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

	@_fromJSON = (file, arr, obj) ->
		unless obj
			node = file.node.getChildByAccessPath arr[JSON_NODE]
			obj = new InputAttr file, node, arr[JSON_TEXT], arr[JSON_BINDING], arr[JSON_ATTR_NAME]
		obj

	isHandler = (name) ->
		/^on[A-Z]|\:on[A-Z][A-Za-z0-9_$]*$/.test name

	constructor: (file, node, text, binding, @attrName) ->
		assert.isString @attrName
		assert.notLengthOf @attrName, 0

		Input.call this, file, node, text, binding

		if isHandler(@attrName)
			@handlerFunc = createHandlerFunc @
			node.attrs.set @attrName, @handlerFunc
		else
			@handlerFunc = null
			if file.isClone
				@registerBinding()

		`//<development>`
		if @constructor is InputAttr
			Object.seal @
		`//</development>`

	getValue: ->
		@node.attrs[@attrName]

	setValue: (val) ->
		@node.attrs.set @attrName, val

	createHandlerFunc = (input) ->
		(arg1, arg2) ->
			r = input.binding.func.apply input, input.file.inputArgs
			if typeof r is 'function'
				r.call @, arg1, arg2
			return

	clone: (original, file) ->
		node = original.node.getCopiedElement @node, file.node

		new InputAttr file, node, @text, @binding, @attrName

	toJSON: (key, arr) ->
		unless arr
			arr = new Array JSON_ARGS_LENGTH
			arr[0] = JSON_CTOR_ID
		super key, arr
		arr[JSON_ATTR_NAME] = @attrName
		arr
