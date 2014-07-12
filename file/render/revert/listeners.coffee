'use strict'

[Emitter] = ['emitter'].map require

module.exports = (File) -> (file) ->
	
	{listeners} = file._tmp

	# disconnect listeners
	while listeners.length
		listener = listeners.pop()
		eventName = listeners.pop()
		node = listeners.pop()

		if node instanceof Emitter
			node.off eventName, listener
		else
			node[eventName].disconnect listener

	null