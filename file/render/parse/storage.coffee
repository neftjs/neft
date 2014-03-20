'use strict'

module.exports = (File) -> (file, opts) ->

	storage = opts?.storage
	attrs = opts?.source?.node.attrs

	for input in file.inputs when input.node.visible
		input.parse storage, attrs

	null
