'use strict'

module.exports = (impl) ->
	{bridge} = impl

	callback = screen = null

	bridge.listen bridge.inActions.SCREEN_SIZE, (reader) ->
		screen._width = reader.getFloat()
		screen._height = reader.getFloat()

		callback()
		return

	# bridge.listen bridge.inActions.SCREEN_ORIENTATION, (reader) ->
	# 	return

	initScreenNamespace: (_callback) ->
		callback = _callback
		screen = this

		@_touch = true
		# @_orientation TODO
