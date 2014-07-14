'use strict'

module.exports = (File) -> (file, source) ->

	if file.sourceNode and source

		oldChild = file.sourceNode
		newChild = source.bodyNode

		file._tmp.parentChanges.push oldChild.parent, oldChild, newChild
		oldChild.parent.replace oldChild, newChild

	null