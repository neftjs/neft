'use strict'

[Emitter] = ['emitter'].map require

module.exports = (File) -> (file, source, input) ->

	unless input.node.visible then return

	{storage} = file

	sourceNode = input.sourceNode = source?.node
	input.sourceStorage = source?.storage
	input.storage = storage

	input.parse()

	# TODO: check whether input must be parsed on any change

	# listen on source node attrs changes
	if sourceNode?.attrsNames
		sourceNode.onAttrChanged.connect listener = (name, old) ->
			input.parse()
			input.onChanged() # TODO: move it into input class
		file._tmp.listeners.push sourceNode, 'onAttrChanged', listener

	# listen on storage changes
	if storage instanceof File.ObservableObject
		storage.onChanged.connect listener = (name, value) ->
			input.parse()
			input.onChanged() # TODO: move it into input class
		file._tmp.listeners.push storage, 'onChanged', listener