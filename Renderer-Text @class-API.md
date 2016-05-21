> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Text
```nml
`Text {
`   font.pixelSize: 30
`   font.family: 'monospace'
`   text: '<strong>Neft</strong> Renderer'
`   color: 'blue'
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#text-class)

<dl><dt>Static method of</dt><dd><i>Text</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Text</i></dd></dl>
New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#text-textnewcomponent-component-object-options)

<dl><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Text</i></dd></dl>
Text
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#text-text--rendereritem)

<dl><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
width
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#float-textwidth--1)

<dl><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
height
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#float-textheight--1)

<dl><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
text
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#string-texttext-signal-textontextchangestring-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'black'</code></dd></dl>
color
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#string-textcolor--black-signal-textoncolorchangestring-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'blue'</code></dd></dl>
linkColor
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#string-textlinkcolor--blue-signal-textonlinkcolorchangestring-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd><dt>hidden</dt></dl>
lineHeight
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#hidden-float-textlineheight--1-hidden-signal-textonlineheightchangefloat-oldvalue)

## Table of contents
    * [Text](#text)
    * [New](#new)
    * [Text](#text)
    * [width](#width)
    * [height](#height)
    * [text](#text)
    * [color](#color)
    * [linkColor](#linkcolor)
    * [lineHeight](#lineheight)
  * [ReadOnly *Float* Text::contentWidth](#readonly-float-textcontentwidth)
  * [ReadOnly *Float* Text::contentHeight](#readonly-float-textcontentheight)
  * [*Alignment* Text::alignment](#alignment-textalignment)
  * [*Font* Text::font](#font-textfont)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Text::contentWidth
-----------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Text::onContentWidthChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#readonly-float-textcontentwidth-signal-textoncontentwidthchangefloat-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Text::contentHeight
------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Text::onContentHeightChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#readonly-float-textcontentheight-signal-textoncontentheightchangefloat-oldvalue)

*Alignment* Text::alignment
---------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Text::onAlignmentChange(*Alignment* alignment)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#alignment-textalignment-signal-textonalignmentchangealignment-alignment)

*Font* Text::font
-----------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Text::onFontChange(*String* property, *Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#font-textfont-signal-textonfontchangestring-property-any-oldvalue)

