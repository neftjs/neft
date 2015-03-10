'use strict'

TOUCH_OS =
	android: true
	blackberry: true
	ios: true
	wince: true

module.exports = (impl) ->
	initScreenNamespace: ->
		{screen} = __stylesWindow
		@_width = screen.width
		@_height = screen.height
		@_pixelRatio = screen.devicePixelRatio
		@_isTouch = !!TOUCH_OS[Qt.platform.os]
		@_isPhone = @_isTouch and Math.min(@_width, @_height)/Math.max(@_width, @_height) < 0.75

		# orientation
		getOrientation = ->
			if screen.orientation & Qt.InvertedLandscapeOrientation
				'InvertedLandscape'
			else if screen.orientation & Qt.InvertedPortraitOrientation
				'InvertedPortrait'
			else if screen.orientation & Qt.LandscapeOrientation
				'Landscape'
			else
				'Portrait'

		updateOrientation = ->
			oldVal = @_orientation
			@_orientation = getOrientation()
			@orientationChanged oldVal
			return

		screen.orientationUpdateMask = Qt.LandscapeOrientation | Qt.PortraitOrientation |
		                               Qt.InvertedLandscapeOrientation |
		                               Qt.InvertedPortraitOrientation;

		@_orientation = getOrientation()
		screen.orientationChanged.connect @, updateOrientation

		return