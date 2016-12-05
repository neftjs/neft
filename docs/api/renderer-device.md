# Device

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Device**

<!-- toc -->

> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee)


* * * 

### `Device.platform`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>&#39;Unix&#39;</code></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#boolean-deviceplatform--39unix39)


* * * 

### `Device.desktop`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#boolean-devicedesktop--true)


* * * 

### `Device.tablet`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#boolean-devicetablet--false)


* * * 

### `Device.phone`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#boolean-devicephone--false)


* * * 

### `Device.mobile`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>

Tablet or a phone.

```javascript
Text {
    text: Device.mobile ? 'Mobile' : 'Desktop'
    font.pixelSize: 30
}
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#boolean-devicemobile--false)


* * * 

### `Device.pixelRatio`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>

```javascript
Text {
    text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
    font.pixelSize: 30
}
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#boolean-devicepixelratio--1)


* * * 

### `Device.log()`

<dl><dt>Static method of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>message... — <i>String</i></li></ul></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#devicelogstring-message)


* * * 

### `Device.pointer`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Device.PointerEvent</i></dd><dt>Read Only</dt></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#readonly-devicepointerevent-devicepointer)


* * * 

### `Device.onPointerPress()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>Device.PointerEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerpressdevicepointerevent-event)


* * * 

### `Device.onPointerRelease()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>Device.PointerEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerreleasedevicepointerevent-event)


* * * 

### `Device.onPointerMove()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>Device.PointerEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointermovedevicepointerevent-event)


* * * 

### `Device.onPointerWheel()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>Device.PointerEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerwheeldevicepointerevent-event)


* * * 

### `Device.keyboard`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Device.KeyboardEvent</i></dd><dt>Read Only</dt></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#readonly-devicekeyboardevent-devicekeyboard)


* * * 

### `Device.onKeyPress()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>Device.KeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeypressdevicekeyboardevent-event)


* * * 

### `Device.onKeyHold()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>Device.KeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyholddevicekeyboardevent-event)


* * * 

### `Device.onKeyRelease()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>Device.KeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyreleasedevicekeyboardevent-event)


* * * 

### `Device.onKeyInput()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>Device.KeyboardEvent</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyinputdevicekeyboardevent-event)

# **Class** Device.PointerEvent


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee)


* * * 

### `Device.x`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read Only</dt></dl>


* * * 

### `Device.onXChange()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventonxchangefloat-oldvalue)


* * * 

### `Device.y`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read Only</dt></dl>


* * * 

### `Device.onYChange()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventonychangefloat-oldvalue)


* * * 

### `Device.movementX`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read Only</dt></dl>


* * * 

### `Device.onMovementXChange()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventonmovementxchangefloat-oldvalue)


* * * 

### `Device.movementY`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read Only</dt></dl>


* * * 

### `Device.onMovementYChange()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventonmovementychangefloat-oldvalue)


* * * 

### `Device.deltaX`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read Only</dt></dl>


* * * 

### `Device.onDeltaXChange()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventondeltaxchangefloat-oldvalue)


* * * 

### `Device.deltaY`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read Only</dt></dl>


* * * 

### `Device.onDeltaYChange()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-devicepointereventondeltaychangefloat-oldvalue)

# **Class** Device.KeyboardEvent()


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee)


* * * 

### `Device.visible`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>


* * * 

### `Device.onVisibleChange()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-devicekeyboardeventonvisiblechangeboolean-oldvalue)


* * * 

### `Device.key`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>


* * * 

### `Device.onKeyChange()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-devicekeyboardeventonkeychangestring-oldvalue)


* * * 

### `Device.text`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>


* * * 

### `Device.onTextChange()`

<dl><dt>Static property of</dt><dd><i>Device</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#signal-devicekeyboardeventontextchangestring-oldvalue)


* * * 

### `Device.show()`

<dl><dt>Static method of</dt><dd><i>Device</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventshow)


* * * 

### `Device.hide()`

<dl><dt>Static method of</dt><dd><i>Device</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventhide)

