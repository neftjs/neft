'use strict'

expect = require 'expect'

module.exports = (File, Input) -> class InputAttr extends Input

	@__name__ = 'InputAttr'
	@__path__ = 'File.Input.Attr'

	constructor: (node, @attrName) ->
		expect(attrName).toBe.truthy().string()

		super node, node.attrs.get(attrName)

	attrName: ''

	update: ->
		super
		str = @toString()
		@node.attrs.set @attrName, str