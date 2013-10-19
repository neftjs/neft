'use strict'

HASH = ///////g

###
Find all declarations in the file and return list of it.
###
module.exports = (pathbase, file) ->

	declarations = {}
	pathbase = pathbase and pathbase.toUpperCase().replace(HASH, '-')
	nodes = file.querySelectorAll 'unit'

	for node in nodes

		name = node.getAttribute 'name'

		unless name
			throw new TypeError "View defines template without name"

		declarations[pathbase + name.toUpperCase()] = node

		# remove node from file
		file.removeChild node

	declarations