# Grid

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Grid**

<!-- toc -->
```javascript
Grid {
    spacing.column: 15
    spacing.row: 5
    columns: 2
    Rectangle { color: 'blue'; width: 60; height: 50; }
    Rectangle { color: 'green'; width: 20; height: 70; }
    Rectangle { color: 'red'; width: 50; height: 30; }
    Rectangle { color: 'yellow'; width: 20; height: 20; }
}
```


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/grid.litcoffee)


* * * 

### `Grid.New()`

<dl><dt>Static method of</dt><dd><i>Grid</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Grid</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/grid.litcoffee#grid-gridnewcomponent-component-object-options)


* * * 

### `constructor()`

<dl><dt>Extends</dt><dd><i>Item</i></dd><dt>Returns</dt><dd><i>Grid</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/grid.litcoffee#grid-gridconstructor--item)


* * * 

### `padding`

<dl><dt>Type</dt><dd><i>Item.Margin</i></dd></dl>


* * * 

### `onPaddingChange()`

<dl><dt>Parameters</dt><dd><ul><li>padding — <i>Item.Margin</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/grid.litcoffee#signal-gridonpaddingchangeitemmargin-padding)


* * * 

### `columns`

<dl><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>2</code></dd></dl>


* * * 

### `onColumnsChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Integer</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/grid.litcoffee#signal-gridoncolumnschangeinteger-oldvalue)


* * * 

### `rows`

<dl><dt>Type</dt><dd><i>Number</i></dd><dt>Default</dt><dd><code>Infinity</code></dd></dl>


* * * 

### `onRowsChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Number</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/grid.litcoffee#signal-gridonrowschangenumber-oldvalue)


* * * 

### `spacing`

<dl><dt>Type</dt><dd><i>Item.Spacing</i></dd></dl>


* * * 

### `onSpacingChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item.Spacing</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/grid.litcoffee#signal-gridonspacingchangeitemspacing-oldvalue)


* * * 

### `alignment`

<dl><dt>Type</dt><dd><i>Item.Alignment</i></dd></dl>


* * * 

### `onAlignmentChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item.Alignment</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/grid.litcoffee#signal-gridonalignmentchangeitemalignment-oldvalue)


* * * 

### `includeBorderMargins`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>


* * * 

### `onIncludeBorderMarginsChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/layout/grid.litcoffee#signal-gridonincludebordermarginschangeboolean-oldvalue)

