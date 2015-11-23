'use strict'

TOUCH_OS =
	android: true
	blackberry: true
	ios: true
	wince: true

PLATFORMS =
	android: 'Android'
	ios: 'iOS'
	blackberry: 'BlackBerry'
	wince: 'WindowsCE'
	winrt: 'WindowsRT'
	winphone: 'WindowsPhone'
	linux: 'Linux'
	windows: 'Windows'
	unix: 'Unix'
	osx: 'OSX'

module.exports = (impl) ->
	initDeviceNamespace: ->
		{screen} = __stylesWindow
		@_platform = PLATFORMS[Qt.platform.os] or 'Unix'
		@_pixelRatio = screen.devicePixelRatio
		isTouch = !!TOUCH_OS[Qt.platform.os]
		@_desktop = not isTouch
		@_phone = isTouch and Math.min(@_width, @_height)/Math.max(@_width, @_height) < 0.75

		return