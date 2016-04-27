'use strict'

module.exports = (impl) ->
	{degToRad} = impl.utils

	if __stylesHatchery?
		sensor = null
		qmlStr = "import QtSensors 5.0; RotationSensor { }"
		elem = Qt.createQmlObject qmlStr, __stylesHatchery
		{reading} = elem

	sync = ->
		if not sensor or not reading
			return

		requestAnimationFrame sync

		sensor.x = degToRad reading.x
		sensor.y = degToRad reading.y
		sensor.z = degToRad reading.z
		return

	enableRotationSensor: ->
		sensor = @
		elem.active = true
		requestAnimationFrame sync

	disableRotationSensor: ->
		sensor = null
		elem.active = false
