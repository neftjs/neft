RotationSensor
==============

	'use strict'

	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) ->

*Object* RotationSensor
-----------------------

		RotationSensor = new itemUtils.Object

*Float* RotationSensor::active = false
--------------------------------------

		RotationSensor._active = false
		utils.defineProperty RotationSensor, 'active', null, ->
			@_active
		, (val) ->
			@_active = val
			if val
				Impl.enableRotationSensor.call RotationSensor
			else
				Impl.disableRotationSensor.call RotationSensor
			return

*Float* RotationSensor::x = 0
-----------------------------

		RotationSensor.x = 0

*Float* RotationSensor::y = 0
-----------------------------

		RotationSensor.y = 0

*Float* RotationSensor::z = 0
-----------------------------

		RotationSensor.z = 0

		Object.preventExtensions RotationSensor

		RotationSensor
