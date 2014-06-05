'use strict'

module.exports = (File) -> (file, opts) ->

	storage = opts?.storage
	sourceStorage = opts?.source?.storage
	node = opts?.source?.node

	for input in file.inputs when input.node.visible
		input.parse node, sourceStorage, storage

	null
