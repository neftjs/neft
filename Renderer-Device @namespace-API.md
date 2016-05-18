> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Device @namespace**

Device @namespace
=================

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#device-namespace)

## Table of contents
  * [Device](#object-device)
  * [Device.platform = 'Unix'](#boolean-deviceplatform--unix)
  * [Device.desktop = true](#boolean-devicedesktop--true)
  * [Device.tablet = false](#boolean-devicetablet--false)
  * [Device.phone = false](#boolean-devicephone--false)
  * [Device.mobile = false](#boolean-devicemobile--false)
  * [Device.pixelRatio = 1](#boolean-devicepixelratio--1)
  * [Device.pointer](#readonly-devicepointerevent-devicepointer)
  * [Device.onPointerPress(event)](#signal-deviceonpointerpressdevicepointerevent-event)
  * [Device.onPointerRelease(event)](#signal-deviceonpointerreleasedevicepointerevent-event)
  * [Device.onPointerMove(event)](#signal-deviceonpointermovedevicepointerevent-event)
  * [Device.onPointerWheel(event)](#signal-deviceonpointerwheeldevicepointerevent-event)
  * [Device.keyboard](#readonly-devicekeyboardevent-devicekeyboard)
  * [Device.onKeyPress(event)](#signal-deviceonkeypressdevicekeyboardevent-event)
  * [Device.onKeyHold(event)](#signal-deviceonkeyholddevicekeyboardevent-event)
  * [Device.onKeyRelease(event)](#signal-deviceonkeyreleasedevicekeyboardevent-event)
  * [Device.onKeyInput(event)](#signal-deviceonkeyinputdevicekeyboardevent-event)
  * [DevicePointerEvent()](#devicepointerevent-devicepointerevent)
  * [x](#readonly-float-devicepointereventx)
  * [y](#readonly-float-devicepointereventy)
  * [movementX](#readonly-float-devicepointereventmovementx)
  * [movementY](#readonly-float-devicepointereventmovementy)
  * [deltaX](#readonly-float-devicepointereventdeltax)
  * [deltaY](#readonly-float-devicepointereventdeltay)
  * [DeviceKeyboardEvent()](#devicekeyboardevent-devicekeyboardevent)
  * [visible](#readonly-boolean-devicekeyboardeventvisible)
  * [key](#readonly-string-devicekeyboardeventkey)
  * [text](#readonly-string-devicekeyboardeventtext)
  * [show()](#devicekeyboardeventshow)
  * [hide()](#devicekeyboardeventhide)

[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Device
---------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#object-device)

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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-deviceplatform--unix)

*Boolean* Device.desktop = true
-------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicedesktop--true)

*Boolean* Device.tablet = false
-------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicetablet--false)

*Boolean* Device.phone = false
------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicephone--false)

*Boolean* Device.mobile = false
-------------------------------

Tablet or a phone.
```nml
`Text {
`   text: Device.mobile ? 'Mobile' : 'Desktop'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicemobile--false)

*Boolean* Device.pixelRatio = 1
-------------------------------

```nml
`Text {
`   text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicepixelratio--1)

ReadOnly *DevicePointerEvent* Device.pointer
--------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-devicepointerevent-devicepointer)

*Signal* Device.onPointerPress(*DevicePointerEvent* event)
----------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerpressdevicepointerevent-event)

*Signal* Device.onPointerRelease(*DevicePointerEvent* event)
------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerreleasedevicepointerevent-event)

*Signal* Device.onPointerMove(*DevicePointerEvent* event)
---------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointermovedevicepointerevent-event)

*Signal* Device.onPointerWheel(*DevicePointerEvent* event)
----------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerwheeldevicepointerevent-event)

ReadOnly *DeviceKeyboardEvent* Device.keyboard
----------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-devicekeyboardevent-devicekeyboard)

*Signal* Device.onKeyPress(*DeviceKeyboardEvent* event)
-------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeypressdevicekeyboardevent-event)

*Signal* Device.onKeyHold(*DeviceKeyboardEvent* event)
------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyholddevicekeyboardevent-event)

*Signal* Device.onKeyRelease(*DeviceKeyboardEvent* event)
---------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyreleasedevicekeyboardevent-event)

*Signal* Device.onKeyInput(*DeviceKeyboardEvent* event)
-------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyinputdevicekeyboardevent-event)

*DevicePointerEvent* DevicePointerEvent()
-----------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicepointerevent-devicepointerevent)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::x
--------------------------------------
## *Signal* DevicePointerEvent::onXChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventx-signal-devicepointereventonxchangefloat-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::y
--------------------------------------
## *Signal* DevicePointerEvent::onYChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventy-signal-devicepointereventonychangefloat-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::movementX
----------------------------------------------
## *Signal* DevicePointerEvent::onMovementXChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventmovementx-signal-devicepointereventonmovementxchangefloat-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::movementY
----------------------------------------------
## *Signal* DevicePointerEvent::onMovementYChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventmovementy-signal-devicepointereventonmovementychangefloat-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::deltaX
----------------------------------------------
## *Signal* DevicePointerEvent::onDeltaXChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventdeltax-signal-devicepointereventondeltaxchangefloat-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::deltaY
----------------------------------------------
## *Signal* DevicePointerEvent::onDeltaYChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventdeltay-signal-devicepointereventondeltaychangefloat-oldvalue)

*DeviceKeyboardEvent* DeviceKeyboardEvent()
-------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardevent-devicekeyboardevent)

ReadOnly *Boolean* DeviceKeyboardEvent::visible
----------------------------------------------
## *Signal* DeviceKeyboardEvent::onVisibleChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-boolean-devicekeyboardeventvisible-signal-devicekeyboardeventonvisiblechangeboolean-oldvalue)

ReadOnly *String* DeviceKeyboardEvent::key
------------------------------------------
## *Signal* DeviceKeyboardEvent::onKeyChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-string-devicekeyboardeventkey-signal-devicekeyboardeventonkeychangestring-oldvalue)

ReadOnly *String* DeviceKeyboardEvent::text
-------------------------------------------
## *Signal* DeviceKeyboardEvent::onTextChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-string-devicekeyboardeventtext-signal-devicekeyboardeventontextchangestring-oldvalue)

DeviceKeyboardEvent::show()
---------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventshow)

DeviceKeyboardEvent::hide()
---------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventhide)

