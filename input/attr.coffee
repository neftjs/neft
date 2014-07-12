'use strict'

{assert} = console

module.exports = (File, Input) -> class InputAttr extends Input

	@__name__ = 'InputAttr'
	@__path__ = 'File.Input.Attr'

	constructor: (node, @attrName) ->

		assert attrName and typeof attrName is 'string'

		super node, node.attrs.get(attrName)

	attrName: ''

	parse: ->
		str = @toString()
		@node.attrs.set @attrName, str