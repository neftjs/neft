> [Wiki](Home) ▸ [API Reference](API-Reference)

Font
<dl><dt>Syntax</dt><dd><code>Font @extension</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/text/font.litcoffee#font-extension)

Font
<dl><dt>Syntax</dt><dd><code>&#x2A;Font&#x2A; Font()</code></dd><dt>Returns</dt><dd><i>Font</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/text/font.litcoffee#font-font)

family
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Font.family = 'sans-serif'</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'sans-serif'</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/text/font.litcoffee#string-fontfamily--sansserif-signal-fontonfamilychangestring-oldvalue)

pixelSize
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Font.pixelSize = 14</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>14</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/text/font.litcoffee#float-fontpixelsize--14-signal-fontonpixelsizechangestring-oldvalue)

weight
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Font.weight = 0.4</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0.4</code></dd></dl>
In range from 0 to 1.

##onWeightChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Font.onWeightChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/text/font.litcoffee#signal-fontonweightchangefloat-oldvalue)

wordSpacing
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Font.wordSpacing = 0</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/text/font.litcoffee#hidden-float-fontwordspacing--0-hidden-signal-fontonwordspacingchangefloat-oldvalue)

letterSpacing
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Font.letterSpacing = 0</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/text/font.litcoffee#hidden-float-fontletterspacing--0-hidden-signal-fontonletterspacingchangefloat-oldvalue)

italic
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Font.italic = false</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/text/font.litcoffee#boolean-fontitalic--false-signal-fontonitalicchangeboolean-oldvalue)

