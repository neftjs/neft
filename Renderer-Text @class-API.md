> [Wiki](Home) ▸ [API Reference](API-Reference)

Text
<dl><dt>Syntax</dt><dd><code>Text @class</code></dd></dl>
```nml
`Text {
`   font.pixelSize: 30
`   font.family: 'monospace'
`   text: '<strong>Neft</strong> Renderer'
`   color: 'blue'
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#text-class)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;Text&#x2A; Text.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>Text</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Text</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#text-textnewcomponent-component-object-options)

Text
<dl><dt>Syntax</dt><dd><code>&#x2A;Text&#x2A; Text() : &#x2A;Renderer.Item&#x2A;</code></dd><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Text</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#text-text--rendereritem)

width
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Text::width = -1</code></dd><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#float-textwidth--1)

height
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Text::height = -1</code></dd><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#float-textheight--1)

text
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Text::text</code></dd><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#string-texttext-signal-textontextchangestring-oldvalue)

color
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Text::color = 'black'</code></dd><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'black'</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#string-textcolor--black-signal-textoncolorchangestring-oldvalue)

linkColor
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Text::linkColor = 'blue'</code></dd><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'blue'</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#string-textlinkcolor--blue-signal-textonlinkcolorchangestring-oldvalue)

lineHeight
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Text::lineHeight = 1</code></dd><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#hidden-float-textlineheight--1-hidden-signal-textonlineheightchangefloat-oldvalue)

contentWidth
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Text::contentWidth</code></dd><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#readonly-float-textcontentwidth-signal-textoncontentwidthchangefloat-oldvalue)

contentHeight
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Text::contentHeight</code></dd><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#readonly-float-textcontentheight-signal-textoncontentheightchangefloat-oldvalue)

alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Alignment&#x2A; Text::alignment</code></dd><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>Alignment</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#alignment-textalignment-signal-textonalignmentchangealignment-alignment)

font
<dl><dt>Syntax</dt><dd><code>&#x2A;Font&#x2A; Text::font</code></dd><dt>Prototype property of</dt><dd><i>Text</i></dd><dt>Type</dt><dd><i>Font</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/text.litcoffee#font-textfont-signal-textonfontchangestring-property-any-oldvalue)

