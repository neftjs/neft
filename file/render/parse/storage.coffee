'use strict'

[Emitter] = ['emitter'].map require

module.exports = (File) -> (file, opts, input) ->

	unless input.node.visible then return

	sourceNode = input.sourceNode = opts.source?.node
	input.sourceStorage = opts.source?.storage
	storage = input.storage = opts.storage

	input.parse()

	# TODO: check whether input must be parsed on any change

	# listen on source node attrs changes
	if sourceNode?.attrsNames
		sourceNode.onAttrChanged.connect listener = (name, old) ->
			input.parse()
			input.onChanged() # TODO: move it into input class
			file._tmp.attrChanges.push @, name, old
		file._tmp.listeners.push sourceNode, 'onAttrChanged', listener

	# listen on storage changes
	if storage?.hasOwnProperty 'onChanged'
		storage.onChanged.connect listener = (name, value) ->
			input.parse()
			input.onChanged() # TODO: move it into input class
		file._tmp.listeners.push storage, 'onChanged', listener