> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Device**

# Device

> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee)

## Table of contents
* [Device](#device)
  * [platform](#platform)
  * [desktop](#desktop)
  * [tablet](#tablet)
  * [phone](#phone)
  * [mobile](#mobile)
  * [pixelRatio](#pixelratio)
  * [Device.log(*String* message, ...)](#devicelogstring-message-)
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
* [**Class** Device.PointerEvent](#class-devicepointerevent)
  * [x](#x)
  * [onXChange](#onxchange)
  * [y](#y)
  * [onYChange](#onychange)
  * [movementX](#movementx)
  * [onMovementXChange](#onmovementxchange)
  * [movementY](#movementy)
  * [onMovementYChange](#onmovementychange)
  * [deltaX](#deltax)
  * [onDeltaXChange](#ondeltaxchange)
  * [deltaY](#deltay)
  * [onDeltaYChange](#ondeltaychange)
* [**Class** Device.KeyboardEvent](#class-devicekeyboardevent)
  * [visible](#visible)
  * [onVisibleChange](#onvisiblechange)
  * [key](#key)
  * [onKeyChange](#onkeychange)
  * [text](#text)
  * [onTextChange](#ontextchange)
  * [show](#show)
  * [hide](#hide)
* [Glossary](#glossary)

##platform
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.platform = `'Unix'`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>'Unix'</code></dd></dl>
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

```javascript
Text {
    text: 'You are using: ' + Device.platform
    font.pixelSize: 30
}
```

> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#boolean-deviceplatform--unix)

##desktop
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.desktop = `true`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#boolean-devicedesktop--true)

##tablet
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.tablet = `false`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#boolean-devicetablet--false)

##phone
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.phone = `false`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#boolean-devicephone--false)

##mobile
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.mobile = `false`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Tablet or a phone.

```javascript
Text {
    text: Device.mobile ? 'Mobile' : 'Desktop'
    font.pixelSize: 30
}
```

> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#boolean-devicemobile--false)

##pixelRatio
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.pixelRatio = `1`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>
```javascript
Text {
    text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
    font.pixelSize: 30
}
```

> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#boolean-devicepixelratio--1)

## Device.log(*String* message, ...)

> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee)

##pointer
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Device.PointerEvent&#x2A; Device.pointer</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicepointerevent">Device.PointerEvent</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#readonly-devicepointerevent-devicepointer)

##onPointerPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerPress(&#x2A;Device.PointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicepointerevent">Device.PointerEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerpressdevicepointerevent-event)

##onPointerRelease
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerRelease(&#x2A;Device.PointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicepointerevent">Device.PointerEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerreleasedevicepointerevent-event)

##onPointerMove
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerMove(&#x2A;Device.PointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicepointerevent">Device.PointerEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointermovedevicepointerevent-event)

##onPointerWheel
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerWheel(&#x2A;Device.PointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicepointerevent">Device.PointerEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerwheeldevicepointerevent-event)

##keyboard
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Device.KeyboardEvent&#x2A; Device.keyboard</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicekeyboardevent">Device.KeyboardEvent</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#readonly-devicekeyboardevent-devicekeyboard)

##onKeyPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyPress(&#x2A;Device.KeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicekeyboardevent">Device.KeyboardEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeypressdevicekeyboardevent-event)

##onKeyHold
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyHold(&#x2A;Device.KeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicekeyboardevent">Device.KeyboardEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyholddevicekeyboardevent-event)

##onKeyRelease
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyRelease(&#x2A;Device.KeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicekeyboardevent">Device.KeyboardEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyreleasedevicekeyboardevent-event)

##onKeyInput
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyInput(&#x2A;Device.KeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicekeyboardevent">Device.KeyboardEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyinputdevicekeyboardevent-event)

# **Class** Device.PointerEvent

> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee)

##x
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::x</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
##onXChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.PointerEvent::onXChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>PointerEvent</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventonxchangefloat-oldvalue)

##y
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::y</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
##onYChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.PointerEvent::onYChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>PointerEvent</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventonychangefloat-oldvalue)

##movementX
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::movementX</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
##onMovementXChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.PointerEvent::onMovementXChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>PointerEvent</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventonmovementxchangefloat-oldvalue)

##movementY
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::movementY</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
##onMovementYChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.PointerEvent::onMovementYChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>PointerEvent</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventonmovementychangefloat-oldvalue)

##deltaX
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::deltaX</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
##onDeltaXChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.PointerEvent::onDeltaXChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>PointerEvent</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventondeltaxchangefloat-oldvalue)

##deltaY
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::deltaY</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
##onDeltaYChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.PointerEvent::onDeltaYChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>PointerEvent</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventondeltaychangefloat-oldvalue)

#**Class** Device.KeyboardEvent
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Device.KeyboardEvent()</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#class-devicekeyboardevent)

##visible
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; Device.KeyboardEvent::visible</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>KeyboardEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
##onVisibleChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.KeyboardEvent::onVisibleChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>KeyboardEvent</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-devicekeyboardeventonvisiblechangeboolean-oldvalue)

##key
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Device.KeyboardEvent::key</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>KeyboardEvent</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
##onKeyChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.KeyboardEvent::onKeyChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>KeyboardEvent</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-devicekeyboardeventonkeychangestring-oldvalue)

##text
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Device.KeyboardEvent::text</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>KeyboardEvent</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
##onTextChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.KeyboardEvent::onTextChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>KeyboardEvent</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#signal-devicekeyboardeventontextchangestring-oldvalue)

##show
<dl><dt>Syntax</dt><dd><code>Device.KeyboardEvent::show()</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>KeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventshow)

##hide
<dl><dt>Syntax</dt><dd><code>Device.KeyboardEvent::hide()</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>KeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/657bcb2abd7e3d8556869fcbe2075d2d2163b9cb/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventhide)

# Glossary

- [Device](#device)
- [Device.PointerEvent](#class-devicepointerevent)
- [Device.KeyboardEvent](#class-devicekeyboardevent)

