'use strict'

TOUCH_OS =
	android: true
	blackberry: true
	ios: true
	wince: true

module.exports = (impl) ->
	initDeviceNamespace: ->
		{screen} = __stylesWindow
		@_platform = Qt.platform.os
		@_pixelRatio = screen.devicePixelRatio
		isTouch = !!TOUCH_OS[Qt.platform.os]
		@_isDesktop = not isTouch
		@_isPhone = isTouch and Math.min(@_width, @_height)/Math.max(@_width, @_height) < 0.75

		return