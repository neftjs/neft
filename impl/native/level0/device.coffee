'use strict'

module.exports = (impl) ->
	{bridge} = impl

	device = pointer = null

	bridge.listen bridge.inActions.DEVICE_PIXEL_RATIO, (reader) ->
		device._pixelRatio = reader.getFloat()
		return

	bridge.listen bridge.inActions.DEVICE_IS_PHONE, (reader) ->
		device._phone = reader.getBoolean()
		return

	bridge.listen bridge.inActions.POINTER_PRESS, (reader) ->
		pointer.x = reader.getFloat()
		pointer.y = reader.getFloat()
		device.onPointerPress.emit pointer
		return

	bridge.listen bridge.inActions.POINTER_RELEASE, (reader) ->
		pointer.x = reader.getFloat()
		pointer.y = reader.getFloat()
		device.onPointerRelease.emit pointer
		return

	bridge.listen bridge.inActions.POINTER_MOVE, (reader) ->
		pointer.x = reader.getFloat()
		pointer.y = reader.getFloat()
		device.onPointerMove.emit pointer
		return

	initDeviceNamespace: ->
		device = this
		pointer = @pointer

		@_desktop = false
		@_platform = 'Android'