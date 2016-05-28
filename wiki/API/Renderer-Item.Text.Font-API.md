> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ [[Text|Renderer-Text-API]] ▸ **Text.Font**

#Text.Font
<dl><dt>Syntax</dt><dd><code>Item.Text.Font</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/Renderer-Item-API.md#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#textfont)

## Table of contents
* [Text.Font](#textfont)
* [**Class** Font](#class-font)
  * [*String* Font.family = `'sans-serif'`](#string-fontfamily--sansserif)
  * [*Float* Font.pixelSize = `14`](#float-fontpixelsize--14)
  * [*Float* Font.weight = `0.4`](#float-fontweight--04)
  * [onWeightChange](#onweightchange)
  * [Hidden *Float* Font.wordSpacing = `0`](#hidden-float-fontwordspacing--0)
  * [Hidden *Float* Font.letterSpacing = `0`](#hidden-float-fontletterspacing--0)
  * [*Boolean* Font.italic = `false`](#boolean-fontitalic--false)
* [Glossary](#glossary)

# **Class** Font

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#class-font)

## *String* Font.family = `'sans-serif'`

## [Signal](/Neft-io/neft/Signal-API.md#class-signal) Font.onFamilyChange(*String* oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#string-fontfamily--sansserif-signal-fontonfamilychangestring-oldvalue)

## [Float](/Neft-io/neft/Utils-API.md#isfloat) Font.pixelSize = `14`

## [Signal](/Neft-io/neft/Signal-API.md#class-signal) Font.onPixelSizeChange(*String* oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#float-fontpixelsize--14-signal-fontonpixelsizechangestring-oldvalue)

## [Float](/Neft-io/neft/Utils-API.md#isfloat) Font.weight = `0.4`

In range from 0 to 1.

##onWeightChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Font.onWeightChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><i>Font</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#onweightchange)

## Hidden [Float](/Neft-io/neft/Utils-API.md#isfloat) Font.wordSpacing = `0`

## Hidden [Signal](/Neft-io/neft/Signal-API.md#class-signal) Font.onWordSpacingChange([Float](/Neft-io/neft/Utils-API.md#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#hidden-float-fontwordspacing--0-hidden-signal-fontonwordspacingchangefloat-oldvalue)

## Hidden [Float](/Neft-io/neft/Utils-API.md#isfloat) Font.letterSpacing = `0`

## Hidden [Signal](/Neft-io/neft/Signal-API.md#class-signal) Font.onLetterSpacingChange([Float](/Neft-io/neft/Utils-API.md#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#hidden-float-fontletterspacing--0-hidden-signal-fontonletterspacingchangefloat-oldvalue)

## *Boolean* Font.italic = `false`

## [Signal](/Neft-io/neft/Signal-API.md#class-signal) Font.onItalicChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text/font.litcoffee#boolean-fontitalic--false-signal-fontonitalicchangeboolean-oldvalue)

# Glossary

- [Item.Text.Font](#class-font)

