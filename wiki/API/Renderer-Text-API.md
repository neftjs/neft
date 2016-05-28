> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **Text**

# Text

```javascript
Text {
    font.pixelSize: 30
    font.family: 'monospace'
    text: '<strong>Neft</strong> Renderer'
    color: 'blue'
}
```

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#text)

## Nested APIs

* [[Text.Font|Renderer-Item.Text.Font-API]]

## Table of contents
* [Text](#text)
* [**Class** Text](#class-text)
  * [New](#new)
  * [*Float* Text::width = `-1`](#float-textwidth--1)
  * [*Float* Text::height = `-1`](#float-textheight--1)
  * [text](#text)
  * [*String* Text::color = `'black'`](#string-textcolor--black)
  * [*String* Text::linkColor = `'blue'`](#string-textlinkcolor--blue)
  * [Hidden *Float* Text::lineHeight = `1`](#hidden-float-textlineheight--1)
  * [contentWidth](#contentwidth)
  * [contentHeight](#contentheight)
  * [alignment](#alignment)
  * [font](#font)
* [Glossary](#glossary)

#**Class** Text
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Text : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#class-text)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Text&#x2A; Text.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#new)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Text::width = `-1`

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#float-textwidth--1)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Text::height = `-1`

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#float-textheight--1)

##text
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Text::text</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#text)

## *String* Text::color = `'black'`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Text::onColorChange(*String* oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#string-textcolor--black-signal-textoncolorchangestring-oldvalue)

## *String* Text::linkColor = `'blue'`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Text::onLinkColorChange(*String* oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#string-textlinkcolor--blue-signal-textonlinkcolorchangestring-oldvalue)

## Hidden [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Text::lineHeight = `1`

## Hidden [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Text::onLineHeightChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#hidden-float-textlineheight--1-hidden-signal-textonlineheightchangefloat-oldvalue)

##contentWidth
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Text::contentWidth</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#contentwidth)

##contentHeight
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Text::contentHeight</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#contentheight)

##alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Alignment&#x2A; Text::alignment</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#alignment)

##font
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Text.Font&#x2A; Text::font</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Text.Font-API#class-font">Item.Text.Font</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#font)

# Glossary

- [Text](#class-text)

