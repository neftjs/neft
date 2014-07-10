'use strict'

tmp = []

module.exports = (File) -> (file, opts, input) ->

	unless input.node.visible then return

	tmp[0] = opts.source?.node
	tmp[1] = opts.source?.storage
	tmp[2] = opts.storage

	input.parse tmp
