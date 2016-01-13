'use strict'

assert = require 'neft-assert'
utils = require 'utils'

module.exports = (File, Input) -> class InputAttr extends Input
	@__name__ = 'InputAttr'
	@__path__ = 'File.Input.Attr'

	JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(InputAttr) - 1

	i = Input.JSON_ARGS_LENGTH
	{JSON_NODE, JSON_TEXT, JSON_FUNC_BODY} = Input
	JSON_ATTR_NAME = i++
	JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

	@_fromJSON = (file, arr, obj) ->
		unless obj
			node = file.node.getChildByAccessPath arr[JSON_NODE]
			obj = new InputAttr file, node, arr[JSON_TEXT], arr[JSON_FUNC_BODY], arr[JSON_ATTR_NAME]
		obj

	isHandler = (name) ->
		/^on[A-Z]|\:on[A-Z][A-Za-z0-9_$]*$/.test name

	constructor: (file, node, text, funcBody, @attrName) ->
		assert.isString attrName
		assert.notLengthOf attrName, 0

		Input.call this, file, node, text, funcBody

		@lastValue = NaN

		if isHandler(attrName)
			@traceChanges = false
			@handlerFunc = createHandlerFunc clone
		else
			@handlerFunc = null

		`//<development>`
		if @constructor is InputAttr
			Object.preventExtensions @
		`//</development>`

	update: ->
		super()
		str = @handlerFunc or @toString()
		if str isnt @lastValue
			@lastValue = str
			@node.setAttr @attrName, str
		return

	createHandlerFunc = (input) ->
		(arg1, arg2) ->
			r = input.toString()
			if typeof r is 'function'
				r.call @, arg1, arg2
			return

	clone: (original, file) ->
		node = original.node.getCopiedElement @node, file.node

		new InputAttr file, node, @text, @funcBody, @attrName

	toJSON: (key, arr) ->
		unless arr
			arr = new Array JSON_ARGS_LENGTH
			arr[0] = JSON_CTOR_ID
		super key, arr
		arr[JSON_ATTR_NAME] = @attrName
		arr
