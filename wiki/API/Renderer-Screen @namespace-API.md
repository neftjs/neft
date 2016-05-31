> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]]

Screen
<dl><dt>Syntax</dt><dd><code>Screen @namespace</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/screen.litcoffee#screen)

Screen
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Screen</code></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/screen.litcoffee#screen)

touch
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; Screen.touch = false</code></dd><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Read Only</dt></dl>
```nml
`Text {
`   text: Screen.touch ? "Touch" : "Mouse"
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/screen.litcoffee#touch)

width
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Screen.width = 1024</code></dd><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>1024</code></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/screen.litcoffee#width)

height
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Screen.height = 800</code></dd><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>800</code></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/screen.litcoffee#height)

orientation
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Screen.orientation = 'Portrait'</code></dd><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'Portrait'</code></dd><dt>Read Only</dt></dl>
May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape

##onOrientationChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Screen.onOrientationChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/screen.litcoffee#onorientationchange)
