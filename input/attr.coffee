'use strict'

{assert} = console

module.exports = (File, Input) -> class InputAttr extends Input

	constructor: (node, @attrName) ->

		assert attrName and typeof attrName is 'string'

		super node, node.attrs.get(attrName)

	attrName: ''

	parse: ->

		@node.attrs.set @attrName, @toString arguments