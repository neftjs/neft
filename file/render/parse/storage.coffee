'use strict'

tmp = []

module.exports = (File) -> (file, opts) ->

	storage = opts?.storage
	sourceStorage = opts?.source?.storage
	node = opts?.source?.node

	for input in file.inputs when input.node.visible
		tmp[0] = node
		tmp[1] = sourceStorage
		tmp[2] = storage
		input.parse tmp

	null
