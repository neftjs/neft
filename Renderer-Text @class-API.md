> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Text @class**

Text @class
===========

```nml
`Text {
`   font.pixelSize: 30
`   font.family: 'monospace'
`   text: '<strong>Neft</strong> Renderer'
`   color: 'blue'
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#text-class)

## Table of contents
  * [Text.New([component, options])](#text-textnewcomponent-component-object-options)
  * [Text() : *Renderer.Item*](#text-text--rendereritem)
  * [width = -1](#float-textwidth--1)
  * [height = -1](#float-textheight--1)
  * [text](#string-texttext)
  * [color = 'black'](#string-textcolor--black)
  * [linkColor = 'blue'](#string-textlinkcolor--blue)
  * [Hidden lineHeight = 1](#hidden-float-textlineheight--1)
  * [contentWidth](#readonly-float-textcontentwidth)
  * [contentHeight](#readonly-float-textcontentheight)
  * [alignment](#alignment-textalignment)
  * [font](#font-textfont)

*Text* Text.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
----------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#text-textnewcomponent-component-object-options)

*Text* Text() : *Renderer.Item*
-------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#text-text--rendereritem)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Text::width = -1
------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#float-textwidth--1)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Text::height = -1
-------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#float-textheight--1)

*String* Text::text
-------------------
## *Signal* Text::onTextChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#string-texttext-signal-textontextchangestring-oldvalue)

*String* Text::color = 'black'
------------------------------
## *Signal* Text::onColorChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#string-textcolor--black-signal-textoncolorchangestring-oldvalue)

*String* Text::linkColor = 'blue'
---------------------------------
## *Signal* Text::onLinkColorChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#string-textlinkcolor--blue-signal-textonlinkcolorchangestring-oldvalue)

Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Text::lineHeight = 1
-----------------------------------
## Hidden *Signal* Text::onLineHeightChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#hidden-float-textlineheight--1-hidden-signal-textonlineheightchangefloat-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Text::contentWidth
-----------------------------------
## *Signal* Text::onContentWidthChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#readonly-float-textcontentwidth-signal-textoncontentwidthchangefloat-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Text::contentHeight
------------------------------------
## *Signal* Text::onContentHeightChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#readonly-float-textcontentheight-signal-textoncontentheightchangefloat-oldvalue)

*Alignment* Text::alignment
---------------------------
## *Signal* Text::onAlignmentChange(*Alignment* alignment)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#alignment-textalignment-signal-textonalignmentchangealignment-alignment)

*Font* Text::font
-----------------
## *Signal* Text::onFontChange(*String* property, *Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#font-textfont-signal-textonfontchangestring-property-any-oldvalue)

