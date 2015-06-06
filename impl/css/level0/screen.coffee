'use strict'

module.exports = (impl) ->
	initScreenNamespace: ->
		@_width = screen.width
		@_height = screen.height
		@_touch = 'ontouchstart' of window

		getOrientation = =>
			oldVal = @_orientation
			@_orientation = switch window.orientation
				when 0
					'Portrait'
				when 180
					'InvertedPortrait'
				when -90
					'Landscape'
				when 90
					'InvertedLandscape'
			@onOrientationChange.emit oldVal
			return

		window.addEventListener 'orientationchange', getOrientation
		window.addEventListener 'load', ->
			getOrientation()
			setTimeout getOrientation, 1000


