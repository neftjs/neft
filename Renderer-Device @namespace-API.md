> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Device
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#device-namespace)

<dl><dt>Type</dt><dd><i>Object</i></dd></dl>
Device
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#object-device)

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>'Unix'</code></dd></dl>
platform
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

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
desktop
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicedesktop--true)

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
tablet
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicetablet--false)

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
phone
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicephone--false)

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
mobile
Tablet or a phone.
```nml
`Text {
`   text: Device.mobile ? 'Mobile' : 'Desktop'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicemobile--false)

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>
pixelRatio
```nml
`Text {
`   text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicepixelratio--1)

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>DevicePointerEvent</i></dd><dt>read only</dt></dl>
pointer
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-devicepointerevent-devicepointer)

<dl><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li><b>event</b> — <i>DevicePointerEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onPointerPress
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerpressdevicepointerevent-event)

<dl><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li><b>event</b> — <i>DevicePointerEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onPointerRelease
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerreleasedevicepointerevent-event)

<dl><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li><b>event</b> — <i>DevicePointerEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onPointerMove
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointermovedevicepointerevent-event)

<dl><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li><b>event</b> — <i>DevicePointerEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onPointerWheel
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerwheeldevicepointerevent-event)

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>read only</dt></dl>
keyboard
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-devicekeyboardevent-devicekeyboard)

<dl><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li><b>event</b> — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onKeyPress
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeypressdevicekeyboardevent-event)

<dl><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li><b>event</b> — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onKeyHold
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyholddevicekeyboardevent-event)

<dl><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li><b>event</b> — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onKeyRelease
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyreleasedevicekeyboardevent-event)

<dl><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li><b>event</b> — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onKeyInput
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyinputdevicekeyboardevent-event)

<dl><dt>Returns</dt><dd><i>DevicePointerEvent</i></dd></dl>
DevicePointerEvent
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicepointerevent-devicepointerevent)

<dl><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>read only</dt></dl>
x
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventx-signal-devicepointereventonxchangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>read only</dt></dl>
y
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventy-signal-devicepointereventonychangefloat-oldvalue)

## Table of contents
    * [Device](#device)
    * [Device](#device)
    * [platform](#platform)
    * [desktop](#desktop)
    * [tablet](#tablet)
    * [phone](#phone)
    * [mobile](#mobile)
    * [pixelRatio](#pixelratio)
    * [pointer](#pointer)
    * [onPointerPress](#onpointerpress)
    * [onPointerRelease](#onpointerrelease)
    * [onPointerMove](#onpointermove)
    * [onPointerWheel](#onpointerwheel)
    * [keyboard](#keyboard)
    * [onKeyPress](#onkeypress)
    * [onKeyHold](#onkeyhold)
    * [onKeyRelease](#onkeyrelease)
    * [onKeyInput](#onkeyinput)
    * [DevicePointerEvent](#devicepointerevent)
    * [x](#x)
    * [y](#y)
  * [ReadOnly *Float* DevicePointerEvent::movementX](#readonly-float-devicepointereventmovementx)
  * [ReadOnly *Float* DevicePointerEvent::movementY](#readonly-float-devicepointereventmovementy)
  * [ReadOnly *Float* DevicePointerEvent::deltaX](#readonly-float-devicepointereventdeltax)
  * [ReadOnly *Float* DevicePointerEvent::deltaY](#readonly-float-devicepointereventdeltay)
  * [*DeviceKeyboardEvent* DeviceKeyboardEvent()](#devicekeyboardevent-devicekeyboardevent)
  * [ReadOnly *Boolean* DeviceKeyboardEvent::visible](#readonly-boolean-devicekeyboardeventvisible)
  * [ReadOnly *String* DeviceKeyboardEvent::key](#readonly-string-devicekeyboardeventkey)
  * [ReadOnly *String* DeviceKeyboardEvent::text](#readonly-string-devicekeyboardeventtext)
  * [DeviceKeyboardEvent::show()](#devicekeyboardeventshow)
  * [DeviceKeyboardEvent::hide()](#devicekeyboardeventhide)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::movementX
----------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) DevicePointerEvent::onMovementXChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventmovementx-signal-devicepointereventonmovementxchangefloat-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::movementY
----------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) DevicePointerEvent::onMovementYChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventmovementy-signal-devicepointereventonmovementychangefloat-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::deltaX
----------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) DevicePointerEvent::onDeltaXChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventdeltax-signal-devicepointereventondeltaxchangefloat-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::deltaY
----------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) DevicePointerEvent::onDeltaYChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventdeltay-signal-devicepointereventondeltaychangefloat-oldvalue)

*DeviceKeyboardEvent* DeviceKeyboardEvent()
-------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardevent-devicekeyboardevent)

ReadOnly *Boolean* DeviceKeyboardEvent::visible
----------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) DeviceKeyboardEvent::onVisibleChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-boolean-devicekeyboardeventvisible-signal-devicekeyboardeventonvisiblechangeboolean-oldvalue)

ReadOnly *String* DeviceKeyboardEvent::key
------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) DeviceKeyboardEvent::onKeyChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-string-devicekeyboardeventkey-signal-devicekeyboardeventonkeychangestring-oldvalue)

ReadOnly *String* DeviceKeyboardEvent::text
-------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) DeviceKeyboardEvent::onTextChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-string-devicekeyboardeventtext-signal-devicekeyboardeventontextchangestring-oldvalue)

DeviceKeyboardEvent::show()
---------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventshow)

DeviceKeyboardEvent::hide()
---------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventhide)

