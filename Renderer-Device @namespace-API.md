> [Wiki](Home) ▸ [API Reference](API-Reference)

Device
<dl><dt>Syntax</dt><dd><code>Device @namespace</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#device-namespace)

Device
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Device</code></dd><dt>Type</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#object-device)

platform
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.platform = 'Unix'</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>'Unix'</code></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#boolean-deviceplatform--unix)

desktop
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.desktop = true</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#boolean-devicedesktop--true)

tablet
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.tablet = false</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#boolean-devicetablet--false)

phone
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.phone = false</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#boolean-devicephone--false)

mobile
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.mobile = false</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Tablet or a phone.
```nml
`Text {
`   text: Device.mobile ? 'Mobile' : 'Desktop'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#boolean-devicemobile--false)

pixelRatio
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.pixelRatio = 1</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>
```nml
`Text {
`   text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#boolean-devicepixelratio--1)

pointer
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;DevicePointerEvent&#x2A; Device.pointer</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>DevicePointerEvent</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#readonly-devicepointerevent-devicepointer)

onPointerPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerPress(&#x2A;DevicePointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerpressdevicepointerevent-event)

onPointerRelease
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerRelease(&#x2A;DevicePointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerreleasedevicepointerevent-event)

onPointerMove
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerMove(&#x2A;DevicePointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointermovedevicepointerevent-event)

onPointerWheel
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerWheel(&#x2A;DevicePointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerwheeldevicepointerevent-event)

keyboard
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;DeviceKeyboardEvent&#x2A; Device.keyboard</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#readonly-devicekeyboardevent-devicekeyboard)

onKeyPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyPress(&#x2A;DeviceKeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeypressdevicekeyboardevent-event)

onKeyHold
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyHold(&#x2A;DeviceKeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyholddevicekeyboardevent-event)

onKeyRelease
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyRelease(&#x2A;DeviceKeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyreleasedevicekeyboardevent-event)

onKeyInput
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyInput(&#x2A;DeviceKeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyinputdevicekeyboardevent-event)

DevicePointerEvent
<dl><dt>Syntax</dt><dd><code>&#x2A;DevicePointerEvent&#x2A; DevicePointerEvent()</code></dd><dt>Returns</dt><dd><i>DevicePointerEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#devicepointerevent-devicepointerevent)

x
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::x</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventx-signal-devicepointereventonxchangefloat-oldvalue)

y
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::y</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventy-signal-devicepointereventonychangefloat-oldvalue)

movementX
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::movementX</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventmovementx-signal-devicepointereventonmovementxchangefloat-oldvalue)

movementY
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::movementY</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventmovementy-signal-devicepointereventonmovementychangefloat-oldvalue)

deltaX
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::deltaX</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventdeltax-signal-devicepointereventondeltaxchangefloat-oldvalue)

deltaY
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::deltaY</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventdeltay-signal-devicepointereventondeltaychangefloat-oldvalue)

DeviceKeyboardEvent
<dl><dt>Syntax</dt><dd><code>&#x2A;DeviceKeyboardEvent&#x2A; DeviceKeyboardEvent()</code></dd><dt>Returns</dt><dd><i>DeviceKeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#devicekeyboardevent-devicekeyboardevent)

visible
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; DeviceKeyboardEvent::visible</code></dd><dt>Prototype property of</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#readonly-boolean-devicekeyboardeventvisible-signal-devicekeyboardeventonvisiblechangeboolean-oldvalue)

key
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; DeviceKeyboardEvent::key</code></dd><dt>Prototype property of</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#readonly-string-devicekeyboardeventkey-signal-devicekeyboardeventonkeychangestring-oldvalue)

text
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; DeviceKeyboardEvent::text</code></dd><dt>Prototype property of</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#readonly-string-devicekeyboardeventtext-signal-devicekeyboardeventontextchangestring-oldvalue)

show
<dl><dt>Syntax</dt><dd><code>DeviceKeyboardEvent::show()</code></dd><dt>Prototype method of</dt><dd><i>DeviceKeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventshow)

hide
<dl><dt>Syntax</dt><dd><code>DeviceKeyboardEvent::hide()</code></dd><dt>Prototype method of</dt><dd><i>DeviceKeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventhide)

