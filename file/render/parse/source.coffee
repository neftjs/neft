'use strict'

module.exports = (File) -> (file, opts) ->

	if file.sourceNode and opts?.source

		oldChild = file.sourceNode
		newChild = opts.source.bodyNode

		file._tmp.parentChanges.push oldChild.parent, oldChild, newChild
		oldChild.parent.replace oldChild, newChild

	null