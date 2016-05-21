> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Screen
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#screen-namespace)

<dl><dt>Type</dt><dd><i>Object</i></dd></dl>
Screen
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#object-screen)

<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>read only</dt></dl>
touch
```nml
`Text {
`   text: Screen.touch ? "Touch" : "Mouse"
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#readonly-boolean-screentouch--false)

<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1024</code></dd><dt>read only</dt></dl>
width
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#readonly-float-screenwidth--1024)

<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>800</code></dd><dt>read only</dt></dl>
height
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#readonly-float-screenheight--800)

## Table of contents
    * [Screen](#screen)
    * [Screen](#screen)
    * [touch](#touch)
    * [width](#width)
    * [height](#height)
  * [ReadOnly *String* Screen.orientation = 'Portrait'](#readonly-string-screenorientation--portrait)
  * [*Signal* Screen.onOrientationChange(*String* oldValue)](#signal-screenonorientationchangestring-oldvalue)

ReadOnly *String* Screen.orientation = 'Portrait'
-------------------------------------------------

May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Screen.onOrientationChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#signal-screenonorientationchangestring-oldvalue)

