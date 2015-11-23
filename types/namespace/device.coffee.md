Device @namespace
======

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) ->
		class Device extends signal.Emitter

*Object* Device
---------------

			constructor: ->
				super()
				@_platform = 'Unix'
				@_desktop = true
				@_phone = false
				@_pixelRatio = 1
				@_pointer = new DevicePointerEvent

				Object.preventExtensions @

*Boolean* Device.platform = 'Unix'
----------------------------------

Possible values are:
 - Android,
 - iOS,
 - BlackBerry,
 - WindowsCE,
 - WindowsRT,
 - WindowsPhone,
 - Linux,
 - Windows,
 - Unix,
 - OSX.

#### Detect client device platform @snippet

```style
Text {
  text: "You are using: " + Device.platform
  font.pixelSize: 30
}
```

			utils.defineProperty @::, 'platform', null, ->
				@_platform
			, null

*Boolean* Device.desktop = true
-------------------------------

			utils.defineProperty @::, 'desktop', null, ->
				@_desktop
			, null

*Boolean* Device.tablet = false
-------------------------------

			utils.defineProperty @::, 'tablet', null, ->
				not @desktop and not @phone
			, null

*Boolean* Device.phone = false
------------------------------

			utils.defineProperty @::, 'phone', null, ->
				@_phone
			, null

*Boolean* Device.mobile = false
-------------------------------

Tablet or a phone.

#### Detect mobile device @snippet

```style
Text {
  text: Device.mobile ? 'Mobile' : 'Desktop'
  font.pixelSize: 30
}
```

			utils.defineProperty @::, 'mobile', null, ->
				@tablet or @phone
			, null

*Boolean* Device.pixelRatio = 1
-------------------------------

#### Detect retina display @snippet

```style
Text {
  text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
  font.pixelSize: 30
}
```

			utils.defineProperty @::, 'pixelRatio', null, ->
				@_pixelRatio
			, null

ReadOnly *DevicePointerEvent* Device.pointer
--------------------------------------------

			utils.defineProperty Device::, 'pointer', null, ->
				@_pointer
			, null

*Signal* Device.onPointerPress(*DevicePointerEvent* event)
----------------------------------------------------------

			signal.Emitter.createSignal @, 'onPointerPress'

*Signal* Device.onPointerRelease(*DevicePointerEvent* event)
------------------------------------------------------------

			signal.Emitter.createSignal @, 'onPointerRelease'

*Signal* Device.onPointerMove(*DevicePointerEvent* event)
---------------------------------------------------------

			signal.Emitter.createSignal @, 'onPointerMove'

*Signal* Device.onPointerWheel(*DevicePointerEvent* event)
----------------------------------------------------------

			signal.Emitter.createSignal @, 'onPointerWheel'

*DevicePointerEvent* DevicePointerEvent()
-----------------------------------------

		class DevicePointerEvent extends signal.Emitter
			constructor: ->
				super()

				@_x = 0
				@_y = 0
				@_movementX = 0
				@_movementY = 0
				@_deltaX = 0
				@_deltaY = 0

				Object.preventExtensions @

ReadOnly *Float* DevicePointerEvent::x
--------------------------------------

### *Signal* DevicePointerEvent::onXChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'x'
				defaultValue: 0
				setter: (_super) -> (val) ->
					oldVal = @_x
					if oldVal isnt val
						_super.call @, val
						@movementX = val - oldVal
					return

ReadOnly *Float* DevicePointerEvent::y
--------------------------------------

### *Signal* DevicePointerEvent::onXChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'y'
				defaultValue: 0
				setter: (_super) -> (val) ->
					oldVal = @_y
					if oldVal isnt val
						_super.call @, val
						@movementY = val - oldVal
					return

ReadOnly *Float* DevicePointerEvent::movementX
----------------------------------------------

### *Signal* DevicePointerEvent::onMovementXChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'movementX'
				defaultValue: 0

ReadOnly *Float* DevicePointerEvent::movementY
----------------------------------------------

### *Signal* DevicePointerEvent::onMovementYChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'movementY'
				defaultValue: 0

ReadOnly *Float* DevicePointerEvent::deltaX
----------------------------------------------

### *Signal* DevicePointerEvent::onDeltaXChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'deltaX'
				defaultValue: 0

ReadOnly *Float* DevicePointerEvent::deltaY
----------------------------------------------

### *Signal* DevicePointerEvent::onDeltaYChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'deltaY'
				defaultValue: 0

		device = new Device
		Impl.initDeviceNamespace?.call device
		device
