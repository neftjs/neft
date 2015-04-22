'use strict'

assert = require 'assert'

module.exports = (impl) ->
	{degToRad} = impl.utils
	sensor = null

	listener = (e) ->
		if sensor
			sensor.x = degToRad e.beta or 0
			assert.isFloat sensor.x

			sensor.y = degToRad e.gamma or 0
			assert.isFloat sensor.y

			sensor.z = degToRad e.alpha or 0
			assert.isFloat sensor.z
		return

	enableRotationSensor: ->
		sensor = @
		window.addEventListener 'deviceorientation', listener
		return

	disableRotationSensor: ->
		sensor = null
		window.removeEventListener 'deviceorientation', listener
		return
