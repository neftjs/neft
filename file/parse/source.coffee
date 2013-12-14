'use strict'

tmp = []

module.exports = (File, _super) ->

	File::clone = do (_super = File::clone) -> ->

		clone = _super.call @

		if @sourceNode
			clone.sourceNode = @node.getCopiedElement @sourceNode, clone.node

		clone

	(file) ->

		_super arguments...

		file.sourceNode = file.node.queryAll('source', tmp)[0]
