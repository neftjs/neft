'use strict'

module.exports = (impl) ->
	initScreenNamespace: ->
		@_width = screen.width
		@_height = screen.height
		@_pixelRatio = window.devicePixelRatio or 1
		@_isTouch = 'ontouchstart' of window
		@_isPhone = @_isTouch and Math.min(@_width, @_height)/Math.max(@_width, @_height) < 0.75