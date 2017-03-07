# Text

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Text**

<!-- toc -->
```javascript
Text {
    font.pixelSize: 30
    font.family: 'monospace'
    text: '<strong>Neft</strong> Renderer'
    color: 'blue'
}
```


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee)


* * * 

### `Text.New()`

<dl><dt>Static method of</dt><dd><i>Text</i></dd><dt>Parameters</dt><dd><ul><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Text</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#text-textnewobject-options)


* * * 

### `constructor()`

<dl><dt>Extends</dt><dd><i>Item</i></dd><dt>Returns</dt><dd><i>Text</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#text-textconstructor--item)


* * * 

### `width`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#float-textwidth--1)


* * * 

### `height`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#float-textheight--1)


* * * 

### `text`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


* * * 

### `onTextChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#signal-textontextchangestring-oldvalue)


* * * 

### `color`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>&#39;black&#39;</code></dd></dl>


* * * 

### `onColorChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#signal-textoncolorchangestring-oldvalue)


* * * 

### `linkColor`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>&#39;blue&#39;</code></dd></dl>


* * * 

### `onLinkColorChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#signal-textonlinkcolorchangestring-oldvalue)


* * * 

### `lineHeight`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd><dt>Not Implemented</dt></dl>


* * * 

### `onLineHeightChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd><dt>Not Implemented</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#hidden-signal-textonlineheightchangefloat-oldvalue)


* * * 

### `contentWidth`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Read Only</dt></dl>


* * * 

### `onContentWidthChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#signal-textoncontentwidthchangefloat-oldvalue)


* * * 

### `contentHeight`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Read Only</dt></dl>


* * * 

### `onContentHeightChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#signal-textoncontentheightchangefloat-oldvalue)


* * * 

### `alignment`

<dl><dt>Type</dt><dd><i>Item.Alignment</i></dd></dl>


* * * 

### `onAlignmentChange()`

<dl><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#signal-textonalignmentchangestring-property-any-oldvalue)


* * * 

### `font`

<dl><dt>Type</dt><dd><i>Item.Text.Font</i></dd></dl>


* * * 

### `onFontChange()`

<dl><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/text.litcoffee#signal-textonfontchangestring-property-any-oldvalue)

