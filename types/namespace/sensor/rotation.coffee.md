RotationSensor
==============

#### @todo

Browser implementation

	'use strict'

	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) -> class RotationSensor extends itemUtils.Object

*Object* RotationSensor
-----------------------

#### Read RotationSensor data @snippet

```
RotationSensor.active = true;

Text {
  font.pixelSize: 30
  onUpdate: function(){
    this.text = "x: " + RotationSensor.x + "; " +
                "y: " + RotationSensor.y + "; " +
                "z: " + RotationSensor.z;
  }
}
```

		constructor: ->
			@_active = false
			@x = 0
			@y = 0
			@z = 0
			super()

*Float* RotationSensor::active = false
--------------------------------------

		utils.defineProperty @::, 'active', null, ->
			@_active
		, (val) ->
			@_active = val
			if val
				Impl.enableRotationSensor.call rotationSensor
			else
				Impl.disableRotationSensor.call rotationSensor
			return

*Float* RotationSensor::x = 0
-----------------------------

		x: 0

*Float* RotationSensor::y = 0
-----------------------------

		y: 0

*Float* RotationSensor::z = 0
-----------------------------

		z: 0

		rotationSensor = new RotationSensor
