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

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee)

## Nested APIs

* [[Text.Font|Renderer-Item.Text.Font-API]]

## Table of contents
* [Text](#text)
* [**Class** Text](#class-text)
  * [New](#new)
  * [width](#width)
  * [height](#height)
  * [text](#text)
  * [onTextChange](#ontextchange)
  * [color](#color)
  * [onColorChange](#oncolorchange)
  * [linkColor](#linkcolor)
  * [onLinkColorChange](#onlinkcolorchange)
  * [lineHeight](#lineheight)
  * [onLineHeightChange](#onlineheightchange)
  * [contentWidth](#contentwidth)
  * [onContentWidthChange](#oncontentwidthchange)
  * [contentHeight](#contentheight)
  * [onContentHeightChange](#oncontentheightchange)
  * [alignment](#alignment)
  * [onAlignmentChange](#onalignmentchange)
  * [font](#font)
  * [onFontChange](#onfontchange)
* [Glossary](#glossary)

#**Class** Text
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Text : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#class-text--item)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Text&#x2A; Text.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#text-textnewcomponent-component-object-options)

##width
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Text::width = `-1`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#float-textwidth--1)

##height
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Text::height = `-1`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#float-textheight--1)

##text
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Text::text</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
##onTextChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Text::onTextChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#signal-textontextchangestring-oldvalue)

##color
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Text::color = `'black'`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'black'</code></dd></dl>
##onColorChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Text::onColorChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#signal-textoncolorchangestring-oldvalue)

##linkColor
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Text::linkColor = `'blue'`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'blue'</code></dd></dl>
##onLinkColorChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Text::onLinkColorChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#signal-textonlinkcolorchangestring-oldvalue)

##lineHeight
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Text::lineHeight = `1`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>1</code></dd><dt>Not Implemented</dt></dl>
##onLineHeightChange
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Signal&#x2A; Text::onLineHeightChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#hidden-signal-textonlineheightchangefloat-oldvalue)

##contentWidth
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Text::contentWidth</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
##onContentWidthChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Text::onContentWidthChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#signal-textoncontentwidthchangefloat-oldvalue)

##contentHeight
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Text::contentHeight</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Read Only</dt></dl>
##onContentHeightChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Text::onContentHeightChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#signal-textoncontentheightchangefloat-oldvalue)

##alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Alignment&#x2A; Text::alignment</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></dd></dl>
##onAlignmentChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Text::onAlignmentChange(&#x2A;String&#x2A; property, &#x2A;Any&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#signal-textonalignmentchangestring-property-any-oldvalue)

##font
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Text.Font&#x2A; Text::font</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Text.Font-API#class-font">Item.Text.Font</a></dd></dl>
##onFontChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Text::onFontChange(&#x2A;String&#x2A; property, &#x2A;Any&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Text-API#class-text">Text</a></dd><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/text.litcoffee#signal-textonfontchangestring-property-any-oldvalue)

# Glossary

- [Text](#class-text)

