'use strict'

utils = require 'utils/index.coffee.md'

module.exports = (File) -> (_super) -> (file) ->

	_super arguments...

	elems = file.elems = {}

	# find elems
	for name of file.units

		nodes = file.node.queryAll name

		unless nodes? then continue

		for node in nodes
			nameElems = elems[name] ?= []
			nameElems.push elem = new File.Elem file, name, node
