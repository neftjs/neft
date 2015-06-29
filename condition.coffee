'use strict'

log = require 'log'

log = log.scope 'View', 'Condition'

module.exports = (File) -> class Condition extends File.Input
	@__name__ = 'Condition'
	@__path__ = 'File.Condition'

	constructor: (node, @elseNode=null, func) ->
		super node, func

	update: ->
		super()
		visible = @node.visible = !!@toString()
		@elseNode?.visible = not visible
		return

	clone: (original, self) ->
		node = original.node.getCopiedElement @node, self.node
		if @elseNode
			elseNode = original.node.getCopiedElement @elseNode, self.node

		clone = new @constructor node, elseNode, @func
		clone.self = self
		clone.text = @text

		clone