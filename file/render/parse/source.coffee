'use strict'

module.exports = (File) -> (file, source) ->

	if file.sourceNode and source

		oldChild = file.sourceNode
		newChild = source.bodyNode

		newChild.parent = oldChild

	null