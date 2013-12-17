'use strict'

tmp = []

module.exports = (File) -> (_super) -> (file) ->

	_super arguments...

	file.sourceNode = file.node.queryAll('source', tmp)[0]
