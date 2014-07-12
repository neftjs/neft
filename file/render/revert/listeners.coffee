'use strict'

[Emitter] = ['emitter'].map require

module.exports = (File) -> (file) ->
	
	{listeners} = file._tmp

	# disconnect listeners
	while listeners.length
		listener = listeners.pop()
		signalName = listeners.pop()
		node = listeners.pop()

		node[signalName].disconnect listener

	null