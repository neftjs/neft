> [Wiki](Home) ▸ [API Reference](API-Reference)

Font
<dl><dt>Syntax</dt><dd>Font @extension</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text/font.litcoffee#font-extension)

Font
<dl><dt>Syntax</dt><dd>*Font* Font()</dd><dt>Returns</dt><dd><i>Font</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text/font.litcoffee#font-font)

family
<dl><dt>Syntax</dt><dd>*String* Font.family = 'sans-serif'</dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'sans-serif'</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text/font.litcoffee#string-fontfamily--sansserif-signal-fontonfamilychangestring-oldvalue)

pixelSize
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Font.pixelSize = 14</dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>14</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text/font.litcoffee#float-fontpixelsize--14-signal-fontonpixelsizechangestring-oldvalue)

weight
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Font.weight = 0.4</dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0.4</code></dd></dl>
In range from 0 to 1.

##onWeightChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Font.onWeightChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)</dd><dt>Static method of</dt><dd><i>Font</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text/font.litcoffee#signal-fontonweightchangefloat-oldvalue)

wordSpacing
<dl><dt>Syntax</dt><dd>Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Font.wordSpacing = 0</dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text/font.litcoffee#hidden-float-fontwordspacing--0-hidden-signal-fontonwordspacingchangefloat-oldvalue)

letterSpacing
<dl><dt>Syntax</dt><dd>Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Font.letterSpacing = 0</dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text/font.litcoffee#hidden-float-fontletterspacing--0-hidden-signal-fontonletterspacingchangefloat-oldvalue)

italic
<dl><dt>Syntax</dt><dd>*Boolean* Font.italic = false</dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text/font.litcoffee#boolean-fontitalic--false-signal-fontonitalicchangeboolean-oldvalue)

