> [Wiki](Home) ▸ [API Reference](API-Reference)

Device
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#device-namespace)

Device
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#object-device)

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

desktop
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicedesktop--true)

tablet
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicetablet--false)

phone
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicephone--false)

mobile
Tablet or a phone.
```nml
`Text {
`   text: Device.mobile ? 'Mobile' : 'Desktop'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicemobile--false)

pixelRatio
```nml
`Text {
`   text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#boolean-devicepixelratio--1)

pointer
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-devicepointerevent-devicepointer)

onPointerPress
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerpressdevicepointerevent-event)

onPointerRelease
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerreleasedevicepointerevent-event)

onPointerMove
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointermovedevicepointerevent-event)

onPointerWheel
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonpointerwheeldevicepointerevent-event)

keyboard
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-devicekeyboardevent-devicekeyboard)

onKeyPress
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeypressdevicekeyboardevent-event)

onKeyHold
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyholddevicekeyboardevent-event)

onKeyRelease
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyreleasedevicekeyboardevent-event)

onKeyInput
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#signal-deviceonkeyinputdevicekeyboardevent-event)

DevicePointerEvent
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicepointerevent-devicepointerevent)

x
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventx-signal-devicepointereventonxchangefloat-oldvalue)

y
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventy-signal-devicepointereventonychangefloat-oldvalue)

movementX
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventmovementx-signal-devicepointereventonmovementxchangefloat-oldvalue)

movementY
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventmovementy-signal-devicepointereventonmovementychangefloat-oldvalue)

deltaX
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventdeltax-signal-devicepointereventondeltaxchangefloat-oldvalue)

deltaY
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-float-devicepointereventdeltay-signal-devicepointereventondeltaychangefloat-oldvalue)

DeviceKeyboardEvent
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardevent-devicekeyboardevent)

visible
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-boolean-devicekeyboardeventvisible-signal-devicekeyboardeventonvisiblechangeboolean-oldvalue)

key
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-string-devicekeyboardeventkey-signal-devicekeyboardeventonkeychangestring-oldvalue)

text
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#readonly-string-devicekeyboardeventtext-signal-devicekeyboardeventontextchangestring-oldvalue)

show
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventshow)

hide
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/device.litcoffee#devicekeyboardeventhide)

