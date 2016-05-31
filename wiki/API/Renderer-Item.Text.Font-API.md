> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ [[Text|Renderer-Text-API]] ▸ **Text.Font**

#Text.Font
<dl><dt>Syntax</dt><dd><code>Item.Text.Font</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#textfont)

## Table of contents
* [Text.Font](#textfont)
* [**Class** Font](#class-font)
  * [family](#family)
  * [pixelSize](#pixelsize)
  * [weight](#weight)
  * [onWeightChange](#onweightchange)
  * [wordSpacing](#wordspacing)
  * [letterSpacing](#letterspacing)
  * [italic](#italic)
* [Glossary](#glossary)

# **Class** Font

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#class-font)

##family
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Font.family = `'sans-serif'`</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'sans-serif'</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#family)

##pixelSize
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Font.pixelSize = `14`</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>14</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#pixelsize)

##weight
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Font.weight = `0.4`</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0.4</code></dd></dl>
In range from 0 to 1.

##onWeightChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Font.onWeightChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#onweightchange)

##wordSpacing
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Font.wordSpacing = `0`</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#wordspacing)

##letterSpacing
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Font.letterSpacing = `0`</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#letterspacing)

##italic
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Font.italic = `false`</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#italic)

# Glossary

- [Item.Text.Font](#class-font)

