'use strict'

module.exports = (impl) ->
	{bridge} = impl

	device = null

	bridge.listen bridge.inActions.DEVICE_PIXEL_RATIO, (reader) ->
		device._pixelRatio = reader.getFloat()
		return

	bridge.listen bridge.inActions.DEVICE_IS_PHONE, (reader) ->
		device._phone = reader.getBoolean()
		return

	initDeviceNamespace: ->
		device = this

		@_desktop = false
		@_platform = 'Android'