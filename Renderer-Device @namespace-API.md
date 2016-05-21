> [Wiki](Home) ▸ [API Reference](API-Reference)

Device
<dl><dt>Syntax</dt><dd>Device @namespace</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#device-namespace)

Device
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Device</dd><dt>Type</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#object-device)

platform
<dl><dt>Syntax</dt><dd>*Boolean* Device.platform = 'Unix'</dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>'Unix'</code></dd></dl>
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

desktop
<dl><dt>Syntax</dt><dd>*Boolean* Device.desktop = true</dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicedesktop--true)

tablet
<dl><dt>Syntax</dt><dd>*Boolean* Device.tablet = false</dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicetablet--false)

phone
<dl><dt>Syntax</dt><dd>*Boolean* Device.phone = false</dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicephone--false)

mobile
<dl><dt>Syntax</dt><dd>*Boolean* Device.mobile = false</dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Tablet or a phone.
```nml
`Text {
`   text: Device.mobile ? 'Mobile' : 'Desktop'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicemobile--false)

pixelRatio
<dl><dt>Syntax</dt><dd>*Boolean* Device.pixelRatio = 1</dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>
```nml
`Text {
`   text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicepixelratio--1)

pointer
<dl><dt>Syntax</dt><dd>ReadOnly *DevicePointerEvent* Device.pointer</dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>DevicePointerEvent</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-devicepointerevent-devicepointer)

onPointerPress
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Device.onPointerPress(*DevicePointerEvent* event)</dd><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerpressdevicepointerevent-event)

onPointerRelease
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Device.onPointerRelease(*DevicePointerEvent* event)</dd><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerreleasedevicepointerevent-event)

onPointerMove
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Device.onPointerMove(*DevicePointerEvent* event)</dd><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointermovedevicepointerevent-event)

onPointerWheel
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Device.onPointerWheel(*DevicePointerEvent* event)</dd><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerwheeldevicepointerevent-event)

keyboard
<dl><dt>Syntax</dt><dd>ReadOnly *DeviceKeyboardEvent* Device.keyboard</dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-devicekeyboardevent-devicekeyboard)

onKeyPress
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Device.onKeyPress(*DeviceKeyboardEvent* event)</dd><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeypressdevicekeyboardevent-event)

onKeyHold
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Device.onKeyHold(*DeviceKeyboardEvent* event)</dd><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyholddevicekeyboardevent-event)

onKeyRelease
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Device.onKeyRelease(*DeviceKeyboardEvent* event)</dd><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyreleasedevicekeyboardevent-event)

onKeyInput
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Device.onKeyInput(*DeviceKeyboardEvent* event)</dd><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyinputdevicekeyboardevent-event)

DevicePointerEvent
<dl><dt>Syntax</dt><dd>*DevicePointerEvent* DevicePointerEvent()</dd><dt>Returns</dt><dd><i>DevicePointerEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicepointerevent-devicepointerevent)

x
<dl><dt>Syntax</dt><dd>ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::x</dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventx-signal-devicepointereventonxchangefloat-oldvalue)

y
<dl><dt>Syntax</dt><dd>ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::y</dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventy-signal-devicepointereventonychangefloat-oldvalue)

movementX
<dl><dt>Syntax</dt><dd>ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::movementX</dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventmovementx-signal-devicepointereventonmovementxchangefloat-oldvalue)

movementY
<dl><dt>Syntax</dt><dd>ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::movementY</dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventmovementy-signal-devicepointereventonmovementychangefloat-oldvalue)

deltaX
<dl><dt>Syntax</dt><dd>ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::deltaX</dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventdeltax-signal-devicepointereventondeltaxchangefloat-oldvalue)

deltaY
<dl><dt>Syntax</dt><dd>ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) DevicePointerEvent::deltaY</dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventdeltay-signal-devicepointereventondeltaychangefloat-oldvalue)

DeviceKeyboardEvent
<dl><dt>Syntax</dt><dd>*DeviceKeyboardEvent* DeviceKeyboardEvent()</dd><dt>Returns</dt><dd><i>DeviceKeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardevent-devicekeyboardevent)

visible
<dl><dt>Syntax</dt><dd>ReadOnly *Boolean* DeviceKeyboardEvent::visible</dd><dt>Prototype property of</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-boolean-devicekeyboardeventvisible-signal-devicekeyboardeventonvisiblechangeboolean-oldvalue)

key
<dl><dt>Syntax</dt><dd>ReadOnly *String* DeviceKeyboardEvent::key</dd><dt>Prototype property of</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-string-devicekeyboardeventkey-signal-devicekeyboardeventonkeychangestring-oldvalue)

text
<dl><dt>Syntax</dt><dd>ReadOnly *String* DeviceKeyboardEvent::text</dd><dt>Prototype property of</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-string-devicekeyboardeventtext-signal-devicekeyboardeventontextchangestring-oldvalue)

show
<dl><dt>Syntax</dt><dd>DeviceKeyboardEvent::show()</dd><dt>Prototype method of</dt><dd><i>DeviceKeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventshow)

hide
<dl><dt>Syntax</dt><dd>DeviceKeyboardEvent::hide()</dd><dt>Prototype method of</dt><dd><i>DeviceKeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventhide)

