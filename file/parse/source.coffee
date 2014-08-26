'use strict'

tmp = []

module.exports = (File) -> (file) ->

	file.sourceNode = file.node.queryAll('x:source', tmp)[0]
