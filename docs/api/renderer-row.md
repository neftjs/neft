# Row

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Row**

<!-- toc -->
```javascript
Row {
    spacing: 5
    Rectangle { color: 'blue'; width: 50; height: 50; }
    Rectangle { color: 'green'; width: 20; height: 50; }
    Rectangle { color: 'red'; width: 50; height: 20; }
}
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/row.litcoffee)


* * * 

### `Row.New()`

<dl><dt>Static method of</dt><dd><i>Row</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Row</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/row.litcoffee#row-rownewcomponent-component-object-options)


* * * 

### `constructor()`

<dl><dt>Extends</dt><dd><i>Item</i></dd><dt>Returns</dt><dd><i>Row</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/row.litcoffee#row-rowconstructor--item)


* * * 

### `padding`

<dl><dt>Type</dt><dd><i>Item.Margin</i></dd></dl>


* * * 

### `onPaddingChange()`

<dl><dt>Parameters</dt><dd><ul><li>padding — <i>Item.Margin</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/row.litcoffee#signal-rowonpaddingchangeitemmargin-padding)


* * * 

### `spacing`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onSpacingChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/row.litcoffee#signal-rowonspacingchangefloat-oldvalue)


* * * 

### `alignment`

<dl><dt>Type</dt><dd><i>Item.Alignment</i></dd></dl>


* * * 

### `onAlignmentChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item.Alignment</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/row.litcoffee#signal-rowonalignmentchangeitemalignment-oldvalue)


* * * 

### `includeBorderMargins`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>


* * * 

### `onIncludeBorderMarginsChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/row.litcoffee#signal-rowonincludebordermarginschangeboolean-oldvalue)

