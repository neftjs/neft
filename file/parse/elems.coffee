'use strict'

utils = require 'utils/index.coffee.md'

module.exports = (File) -> (_super) -> (file) ->

	_super arguments...

	{node} = file

	elems = file.elems = {}

	# find elems
	for name of file.units

		nodes = node.queryAll name

		unless nodes? then continue

		for node in nodes
			nameElems = elems[name] ?= []
			nameElems.push elem = new File.Elem file, name, node