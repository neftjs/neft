'use strict'

module.exports = (impl) ->
	{bridge} = impl

	callback = screen = pointer = null

	bridge.listen bridge.inActions.SCREEN_SIZE, (reader) ->
		screen._width = reader.getFloat()
		screen._height = reader.getFloat()

		callback()
		return

	# bridge.listen bridge.inActions.SCREEN_ORIENTATION, (reader) ->
	# 	return

	bridge.listen bridge.inActions.POINTER_PRESS, (reader) ->
		pointer.x = reader.getFloat()
		pointer.y = reader.getFloat()
		screen.onPointerPress.emit pointer
		return

	bridge.listen bridge.inActions.POINTER_RELEASE, (reader) ->
		pointer.x = reader.getFloat()
		pointer.y = reader.getFloat()
		screen.onPointerRelease.emit pointer
		return

	bridge.listen bridge.inActions.POINTER_MOVE, (reader) ->
		pointer.x = reader.getFloat()
		pointer.y = reader.getFloat()
		screen.onPointerMove.emit pointer
		return

	initScreenNamespace: (_callback) ->
		callback = _callback
		screen = this
		pointer = @pointer

		@_touch = true
		# @_orientation TODO
