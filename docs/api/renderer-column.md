# Column

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Column**

<!-- toc -->
```javascript
Column {
    spacing: 5
    Rectangle { color: 'blue'; width: 50; height: 50; }
    Rectangle { color: 'green'; width: 20; height: 50; }
    Rectangle { color: 'red'; width: 50; height: 20; }
}
```


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/column.litcoffee)


* * * 

### `Column.New()`

<dl><dt>Static method of</dt><dd><i>Column</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Column</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/column.litcoffee#column-columnnewcomponent-component-object-options)


* * * 

### `constructor()`

<dl><dt>Extends</dt><dd><i>Item</i></dd><dt>Returns</dt><dd><i>Column</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/column.litcoffee#column-columnconstructor--item)


* * * 

### `padding`

<dl><dt>Type</dt><dd><i>Item.Margin</i></dd></dl>


* * * 

### `onPaddingChange()`

<dl><dt>Parameters</dt><dd><ul><li>padding — <i>Item.Margin</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/column.litcoffee#signal-columnonpaddingchangeitemmargin-padding)


* * * 

### `spacing`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onSpacingChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/column.litcoffee#signal-columnonspacingchangefloat-oldvalue)


* * * 

### `alignment`

<dl><dt>Type</dt><dd><i>Item.Alignment</i></dd></dl>


* * * 

### `onAlignmentChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item.Alignment</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/column.litcoffee#signal-columnonalignmentchangeitemalignment-oldvalue)


* * * 

### `includeBorderMargins`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>


* * * 

### `onIncludeBorderMarginsChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/column.litcoffee#signal-columnonincludebordermarginschangeboolean-oldvalue)

