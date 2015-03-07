'use strict'

TOUCH_OS =
	android: true
	blackberry: true
	ios: true
	wince: true

module.exports = (impl) ->
	initScreenNamespace: ->
		setTimeout =>
			{screen} = __stylesWindow
			@_width = screen.width
			@_height = screen.height
			@_pixelRatio = screen.devicePixelRatio
			@_isTouch = !!TOUCH_OS[Qt.platform.os]
			@_isPhone = @_isTouch and Math.min(@_width, @_height)/Math.max(@_width, @_height) < 0.75