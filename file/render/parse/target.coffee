'use strict'

module.exports = (File) -> (file, source) ->
	if file.targetNode and source
		oldChild = file.targetNode
		newChild = source.bodyNode

		newChild?.parent = oldChild

	return