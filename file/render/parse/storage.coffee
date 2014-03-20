'use strict'

module.exports = (File) -> (file, opts) ->

	storage = opts?.storage
	sourceStorage = opts?.source?.storage
	attrs = opts?.source?.node.attrs

	for input in file.inputs when input.node.visible
		input.parse storage, sourceStorage, attrs

	null
