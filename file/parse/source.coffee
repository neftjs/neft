'use strict'

tmp = []

module.exports = (File) -> (file) ->

	file.sourceNode = file.node.queryAll('source', tmp)[0]
