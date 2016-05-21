> [Wiki](Home) ▸ [API Reference](API-Reference)

Screen
<dl></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#screen-namespace)

Screen
<dl><dt>Type</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#object-screen)

touch
<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>read only</dt></dl>
```nml
`Text {
`   text: Screen.touch ? "Touch" : "Mouse"
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#readonly-boolean-screentouch--false)

width
<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1024</code></dd><dt>read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#readonly-float-screenwidth--1024)

height
<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>800</code></dd><dt>read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#readonly-float-screenheight--800)

orientation
<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'Portrait'</code></dd><dt>read only</dt></dl>
May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape

## Table of contents
    * [Screen](#screen)
    * [Screen](#screen)
    * [touch](#touch)
    * [width](#width)
    * [height](#height)
    * [orientation](#orientation)
  * [onOrientationChange](#onorientationchange)

##onOrientationChange
<dl><dt>Static method of</dt><dd><i>Screen</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#signal-screenonorientationchangestring-oldvalue)

