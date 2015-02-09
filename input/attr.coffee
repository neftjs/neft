'use strict'

assert = require 'assert'

module.exports = (File, Input) -> class InputAttr extends Input
	@__name__ = 'InputAttr'
	@__path__ = 'File.Input.Attr'

	constructor: (node, func) ->
		@attrName = ''
		super node, func

	update: ->
		super()
		str = @toString()
		@node.attrs.set @attrName, str
		return

	clone: (original, self) ->
		clone = super original, self
		clone.attrName = @attrName
		clone