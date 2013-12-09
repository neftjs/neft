'use strict'

utils = require 'utils/index.coffee.md'

module.exports = (File, _super) ->

	File::clone = do (_super = File::clone) -> ->

		copy = _super.call @

		# copy elems
		elems = copy.elems = utils.clone @elems

		for name, unitElems of elems

			unitElems = elems[name] = utils.clone unitElems
			for elem, i in unitElems
				unitElems[i] = elem.clone copy

		copy

	(file) ->

		_super.call null, file

		node = file.node

		elems = file.elems = {}

		# find elems
		for name of file.units

			nodes = node.queryAll name

			unless nodes? then continue

			for node in nodes
				nameElems = elems[name] ?= []
				nameElems.push elem = new File.Elem file, name, node