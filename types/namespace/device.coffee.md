Device @namespace
=================

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
				@_keyboard = new DeviceKeyboardEvent

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

```nml
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

```nml
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

```nml
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

ReadOnly *DeviceKeyboardEvent* Device.keyboard
----------------------------------------------

			utils.defineProperty Device::, 'keyboard', null, ->
				@_keyboard
			, null

*Signal* Device.onKeyPress(*DeviceKeyboardEvent* event)
-------------------------------------------------------

			signal.Emitter.createSignal @, 'onKeyPress'

*Signal* Device.onKeyHold(*DeviceKeyboardEvent* event)
------------------------------------------------------

			signal.Emitter.createSignal @, 'onKeyHold'

*Signal* Device.onKeyRelease(*DeviceKeyboardEvent* event)
---------------------------------------------------------

			signal.Emitter.createSignal @, 'onKeyRelease'

*Signal* Device.onKeyInput(*DeviceKeyboardEvent* event)
-------------------------------------------------------

			signal.Emitter.createSignal @, 'onKeyInput'

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

## *Signal* DevicePointerEvent::onXChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'x'
				defaultValue: 0

ReadOnly *Float* DevicePointerEvent::y
--------------------------------------

## *Signal* DevicePointerEvent::onYChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'y'
				defaultValue: 0

ReadOnly *Float* DevicePointerEvent::movementX
----------------------------------------------

## *Signal* DevicePointerEvent::onMovementXChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'movementX'
				defaultValue: 0

ReadOnly *Float* DevicePointerEvent::movementY
----------------------------------------------

## *Signal* DevicePointerEvent::onMovementYChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'movementY'
				defaultValue: 0

ReadOnly *Float* DevicePointerEvent::deltaX
----------------------------------------------

## *Signal* DevicePointerEvent::onDeltaXChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'deltaX'
				defaultValue: 0

ReadOnly *Float* DevicePointerEvent::deltaY
----------------------------------------------

## *Signal* DevicePointerEvent::onDeltaYChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'deltaY'
				defaultValue: 0

*DeviceKeyboardEvent* DeviceKeyboardEvent()
-------------------------------------------

		class DeviceKeyboardEvent extends signal.Emitter
			constructor: ->
				super()

				@_visible = false
				@_key = ''
				@_text = ''

				Object.preventExtensions @

ReadOnly *Boolean* DeviceKeyboardEvent::visible
----------------------------------------------

## *Signal* DeviceKeyboardEvent::onVisibleChange(*Boolean* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'visible'
				defaultValue: false

ReadOnly *String* DeviceKeyboardEvent::key
------------------------------------------

## *Signal* DeviceKeyboardEvent::onKeyChange(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'key'
				defaultValue: ''

ReadOnly *String* DeviceKeyboardEvent::text
-------------------------------------------

## *Signal* DeviceKeyboardEvent::onTextChange(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'text'
				defaultValue: ''

DeviceKeyboardEvent::show()
---------------------------

			show: ->
				Impl.showDeviceKeyboard.call device

DeviceKeyboardEvent::hide()
---------------------------

			hide: ->
				Impl.hideDeviceKeyboard.call device

		# create new instance
		device = new Device

		# support pointer movement
		do ->
			x = y = 0
			updateMovement = (event) ->
				event.movementX = event.x - x
				event.movementY = event.y - y
				x = event.x
				y = event.y
				return

			device.onPointerPress updateMovement
			device.onPointerRelease updateMovement
			device.onPointerMove updateMovement

		# initialize by the implementation
		Impl.initDeviceNamespace.call device
		device
