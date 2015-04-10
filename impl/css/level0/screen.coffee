'use strict'

module.exports = (impl) ->
	initScreenNamespace: ->
		@_width = screen.width
		@_height = screen.height
		@_isTouch = 'ontouchstart' of window
