> [Wiki](Home) ▸ [API Reference](API-Reference)

Screen
<dl><dt>Syntax</dt><dd>Screen @namespace</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#screen-namespace)

Screen
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Screen</dd><dt>Type</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#object-screen)

touch
<dl><dt>Syntax</dt><dd>ReadOnly *Boolean* Screen.touch = false</dd><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Read only</dt></dl>
```nml
`Text {
`   text: Screen.touch ? "Touch" : "Mouse"
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#readonly-boolean-screentouch--false)

width
<dl><dt>Syntax</dt><dd>ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Screen.width = 1024</dd><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1024</code></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#readonly-float-screenwidth--1024)

height
<dl><dt>Syntax</dt><dd>ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Screen.height = 800</dd><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>800</code></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#readonly-float-screenheight--800)

orientation
<dl><dt>Syntax</dt><dd>ReadOnly *String* Screen.orientation = 'Portrait'</dd><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'Portrait'</code></dd><dt>Read only</dt></dl>
May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape

##onOrientationChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Screen.onOrientationChange(*String* oldValue)</dd><dt>Static method of</dt><dd><i>Screen</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/screen.litcoffee#signal-screenonorientationchangestring-oldvalue)

