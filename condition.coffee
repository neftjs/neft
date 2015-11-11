'use strict'

log = require 'log'

log = log.scope 'View', 'Condition'

module.exports = (File) -> class Condition
	@__name__ = 'Condition'
	@__path__ = 'File.Condition'

	constructor: (@node, @elseNode=null) ->
		Object.preventExtensions @

	update: ->
		visible = @node.visible = !!@node.attrs.get('neft:if')
		@elseNode?.visible = not visible
		return

	render: ->
		@update()

	onAttrsChange = (name) ->
		if name is 'neft:if'
			@update()
		return

	clone: (original, self) ->
		node = original.node.getCopiedElement @node, self.node
		if @elseNode
			elseNode = original.node.getCopiedElement @elseNode, self.node

		clone = new @constructor node, elseNode

		node.onAttrsChange onAttrsChange, clone

		clone