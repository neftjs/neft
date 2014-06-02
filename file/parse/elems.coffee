'use strict'

[utils] = ['utils'].map require

module.exports = (File) -> (file) ->

	elems = file.elems = {}

	# find elems
	for name of file.units

		nodes = file.node.queryAll name
		unless nodes? then continue

		for node in nodes
			nameElems = elems[name] ?= []
			nameElems.push new File.Elem file, name, node

	null