> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Device**

# Device

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#device)

## Table of contents
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
* [**Class** Device.PointerEvent](#class-devicepointerevent)
  * [x](#x)
  * [y](#y)
  * [movementX](#movementx)
  * [movementY](#movementy)
  * [deltaX](#deltax)
  * [deltaY](#deltay)
* [**Class** Device.KeyboardEvent](#class-devicekeyboardevent)
  * [visible](#visible)
  * [key](#key)
  * [text](#text)
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

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#platform)

##desktop
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.desktop = `true`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#desktop)

##tablet
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.tablet = `false`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#tablet)

##phone
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.phone = `false`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#phone)

##mobile
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.mobile = `false`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Tablet or a phone.

```javascript
Text {
    text: Device.mobile ? 'Mobile' : 'Desktop'
    font.pixelSize: 30
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#mobile)

##pixelRatio
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Device.pixelRatio = `1`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>
```javascript
Text {
    text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
    font.pixelSize: 30
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#pixelratio)

##pointer
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Device.PointerEvent&#x2A; Device.pointer</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicepointerevent">Device.PointerEvent</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#pointer)

##onPointerPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerPress(&#x2A;Device.PointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicepointerevent">Device.PointerEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#onpointerpress)

##onPointerRelease
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerRelease(&#x2A;Device.PointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicepointerevent">Device.PointerEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#onpointerrelease)

##onPointerMove
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerMove(&#x2A;Device.PointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicepointerevent">Device.PointerEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#onpointermove)

##onPointerWheel
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onPointerWheel(&#x2A;Device.PointerEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicepointerevent">Device.PointerEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#onpointerwheel)

##keyboard
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Device.KeyboardEvent&#x2A; Device.keyboard</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicekeyboardevent">Device.KeyboardEvent</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#keyboard)

##onKeyPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyPress(&#x2A;Device.KeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicekeyboardevent">Device.KeyboardEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#onkeypress)

##onKeyHold
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyHold(&#x2A;Device.KeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicekeyboardevent">Device.KeyboardEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#onkeyhold)

##onKeyRelease
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyRelease(&#x2A;Device.KeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicekeyboardevent">Device.KeyboardEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#onkeyrelease)

##onKeyInput
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Device.onKeyInput(&#x2A;Device.KeyboardEvent&#x2A; event)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicekeyboardevent">Device.KeyboardEvent</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#onkeyinput)

# **Class** Device.PointerEvent

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#class-devicepointerevent)

##x
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::x</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#x)

##y
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::y</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#y)

##movementX
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::movementX</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#movementx)

##movementY
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::movementY</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#movementy)

##deltaX
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::deltaX</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#deltax)

##deltaY
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Device.PointerEvent::deltaY</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#deltay)

#**Class** Device.KeyboardEvent
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Device.KeyboardEvent()</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#class-devicekeyboardevent)

##visible
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; Device.KeyboardEvent::visible</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>KeyboardEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#visible)

##key
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Device.KeyboardEvent::key</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>KeyboardEvent</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#key)

##text
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Device.KeyboardEvent::text</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype property of</dt><dd><i>KeyboardEvent</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#text)

##show
<dl><dt>Syntax</dt><dd><code>Device.KeyboardEvent::show()</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>KeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#show)

##hide
<dl><dt>Syntax</dt><dd><code>Device.KeyboardEvent::hide()</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#device">Device</a></dd><dt>Prototype method of</dt><dd><i>KeyboardEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/device.litcoffee#hide)

# Glossary

- [Device](#device)
- [Device.PointerEvent](#class-devicepointerevent)
- [Device.KeyboardEvent](#class-devicekeyboardevent)

