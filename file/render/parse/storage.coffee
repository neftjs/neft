'use strict'

[Emitter] = ['emitter'].map require

module.exports = (File) -> (file, opts, input) ->

	unless input.node.visible then return

	sourceNode = input.sourceNode = opts.source?.node
	input.sourceStorage = opts.source?.storage
	storage = input.storage = opts.storage

	input.parse()

	# listen on source node attrs changes
	if sourceNode?.attrsNames
		sourceNode.onAttrChanged.connect listener = (node, name, old) ->
			input.parse()
			file._tmp.attrChanges.push node, name, old
		file._tmp.listeners.push sourceNode, 'onAttrChanged', listener

	# listen on storage changes
	if storage instanceof Emitter
		storage.on 'change', listener = (name, value) ->
			input.parse()
		file._tmp.listeners.push storage, 'change', listener