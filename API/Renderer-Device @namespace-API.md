> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]]

Device
<dl><dt>Syntax</dt><dd><code>Device @namespace</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#device)

Device
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Device</code></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#device)

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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#platform)

desktop
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.desktop = true</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#desktop)

tablet
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.tablet = false</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#tablet)

phone
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.phone = false</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#phone)

mobile
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.mobile = false</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Tablet or a phone.

```nml
`Text {
`   text: Device.mobile ? 'Mobile' : 'Desktop'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#mobile)

pixelRatio
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.pixelRatio = 1</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>
```nml
`Text {
`   text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#pixelratio)

pointer
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;DevicePointerEvent&#x2A; Device.pointer</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>DevicePointerEvent</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#pointer)

onPointerPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerPress(&#x2A;DevicePointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#onpointerpress)

onPointerRelease
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerRelease(&#x2A;DevicePointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#onpointerrelease)

onPointerMove
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerMove(&#x2A;DevicePointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#onpointermove)

onPointerWheel
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerWheel(&#x2A;DevicePointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DevicePointerEvent</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#onpointerwheel)

keyboard
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;DeviceKeyboardEvent&#x2A; Device.keyboard</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#keyboard)

onKeyPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyPress(&#x2A;DeviceKeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#onkeypress)

onKeyHold
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyHold(&#x2A;DeviceKeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#onkeyhold)

onKeyRelease
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyRelease(&#x2A;DeviceKeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#onkeyrelease)

onKeyInput
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyInput(&#x2A;DeviceKeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>DeviceKeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#onkeyinput)

DevicePointerEvent
<dl><dt>Syntax</dt><dd><code>&#x2A;DevicePointerEvent&#x2A; DevicePointerEvent()</code></dd><dt>Returns</dt><dd><i>DevicePointerEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#devicepointerevent)

x
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::x</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#x)

y
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::y</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#y)

movementX
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::movementX</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#movementx)

movementY
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::movementY</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#movementy)

deltaX
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::deltaX</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#deltax)

deltaY
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; DevicePointerEvent::deltaY</code></dd><dt>Prototype property of</dt><dd><i>DevicePointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#deltay)

DeviceKeyboardEvent
<dl><dt>Syntax</dt><dd><code>&#x2A;DeviceKeyboardEvent&#x2A; DeviceKeyboardEvent()</code></dd><dt>Returns</dt><dd><i>DeviceKeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#devicekeyboardevent)

visible
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; DeviceKeyboardEvent::visible</code></dd><dt>Prototype property of</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#visible)

key
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; DeviceKeyboardEvent::key</code></dd><dt>Prototype property of</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#key)

text
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; DeviceKeyboardEvent::text</code></dd><dt>Prototype property of</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#text)

show
<dl><dt>Syntax</dt><dd><code>DeviceKeyboardEvent::show()</code></dd><dt>Prototype method of</dt><dd><i>DeviceKeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#show)

hide
<dl><dt>Syntax</dt><dd><code>DeviceKeyboardEvent::hide()</code></dd><dt>Prototype method of</dt><dd><i>DeviceKeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/device.litcoffee#hide)

