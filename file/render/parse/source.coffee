'use strict'

module.exports = (File) -> (_super) -> (file, opts) ->

	if file.sourceNode and opts?.source and file.sourceNode.visible

		oldChild = file.sourceNode
		newChild = opts.source.bodyNode

		file._tmp.changes.push oldChild.parent, oldChild, newChild
		oldChild.parent.replace oldChild, newChild

	_super arguments...