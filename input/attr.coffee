'use strict'

assert = require 'assert'
utils = require 'utils'

module.exports = (File, Input) -> class InputAttr extends Input
	@__name__ = 'InputAttr'
	@__path__ = 'File.Input.Attr'

	constructor: (node, func) ->
		@attrName = ''
		@handlerFunc = null
		super node, func

	isHandler = (name) ->
		/^on[A-Z]|\:on[A-Z][A-Za-z0-9_$]*$/.test(name)

	update: ->
		super()
		str = @handlerFunc or @toString()
		@node.attrs.set @attrName, str
		return

	clone: (original, self) ->
		clone = super original, self
		clone.attrName = @attrName
		if isHandler(@attrName)
			clone.traceChanges = false
			clone.handlerFunc = utils.bindFunctionContext @toString, clone
		clone