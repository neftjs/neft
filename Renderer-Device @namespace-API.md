Device @namespace
=================

*Object* Device
---------------

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
`Text {
`   text: "You are using: " + Device.platform
`   font.pixelSize: 30
`}
```

*Boolean* Device.desktop = true
-------------------------------

*Boolean* Device.tablet = false
-------------------------------

*Boolean* Device.phone = false
------------------------------

*Boolean* Device.mobile = false
-------------------------------

Tablet or a phone.

```nml
`Text {
`   text: Device.mobile ? 'Mobile' : 'Desktop'
`   font.pixelSize: 30
`}
```

*Boolean* Device.pixelRatio = 1
-------------------------------

```nml
`Text {
`   text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
`   font.pixelSize: 30
`}
```

ReadOnly *DevicePointerEvent* Device.pointer
--------------------------------------------

*Signal* Device.onPointerPress(*DevicePointerEvent* event)
----------------------------------------------------------

*Signal* Device.onPointerRelease(*DevicePointerEvent* event)
------------------------------------------------------------

*Signal* Device.onPointerMove(*DevicePointerEvent* event)
---------------------------------------------------------

*Signal* Device.onPointerWheel(*DevicePointerEvent* event)
----------------------------------------------------------

ReadOnly *DeviceKeyboardEvent* Device.keyboard
----------------------------------------------

*Signal* Device.onKeyPress(*DeviceKeyboardEvent* event)
-------------------------------------------------------

*Signal* Device.onKeyHold(*DeviceKeyboardEvent* event)
------------------------------------------------------

*Signal* Device.onKeyRelease(*DeviceKeyboardEvent* event)
---------------------------------------------------------

*Signal* Device.onKeyInput(*DeviceKeyboardEvent* event)
-------------------------------------------------------

*DevicePointerEvent* DevicePointerEvent()
-----------------------------------------

ReadOnly *Float* DevicePointerEvent::x
--------------------------------------

## *Signal* DevicePointerEvent::onXChange(*Float* oldValue)

ReadOnly *Float* DevicePointerEvent::y
--------------------------------------

## *Signal* DevicePointerEvent::onYChange(*Float* oldValue)

ReadOnly *Float* DevicePointerEvent::movementX
----------------------------------------------

## *Signal* DevicePointerEvent::onMovementXChange(*Float* oldValue)

ReadOnly *Float* DevicePointerEvent::movementY
----------------------------------------------

## *Signal* DevicePointerEvent::onMovementYChange(*Float* oldValue)

ReadOnly *Float* DevicePointerEvent::deltaX
----------------------------------------------

## *Signal* DevicePointerEvent::onDeltaXChange(*Float* oldValue)

ReadOnly *Float* DevicePointerEvent::deltaY
----------------------------------------------

## *Signal* DevicePointerEvent::onDeltaYChange(*Float* oldValue)

*DeviceKeyboardEvent* DeviceKeyboardEvent()
-------------------------------------------

ReadOnly *Boolean* DeviceKeyboardEvent::visible
----------------------------------------------

## *Signal* DeviceKeyboardEvent::onVisibleChange(*Boolean* oldValue)

ReadOnly *String* DeviceKeyboardEvent::key
------------------------------------------

## *Signal* DeviceKeyboardEvent::onKeyChange(*String* oldValue)

ReadOnly *String* DeviceKeyboardEvent::text
-------------------------------------------

## *Signal* DeviceKeyboardEvent::onTextChange(*String* oldValue)

DeviceKeyboardEvent::show()
---------------------------

DeviceKeyboardEvent::hide()
---------------------------

