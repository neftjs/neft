# Flow

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Flow**

<!-- toc -->
```javascript
Flow {
    width: 90
    spacing.column: 15
    spacing.row: 5
    Rectangle { color: 'blue'; width: 60; height: 50; }
    Rectangle { color: 'green'; width: 20; height: 70; }
    Rectangle { color: 'red'; width: 50; height: 30; }
    Rectangle { color: 'yellow'; width: 20; height: 20; }
}
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/flow.litcoffee)


* * * 

### `Flow.New()`

<dl><dt>Static method of</dt><dd><i>Flow</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Flow</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/flow.litcoffee#flow-flownewcomponent-component-object-options)


* * * 

### `constructor()`

<dl><dt>Extends</dt><dd><i>Item</i></dd><dt>Returns</dt><dd><i>Flow</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/flow.litcoffee#flow-flowconstructor--item)


* * * 

### `padding`

<dl><dt>Type</dt><dd><i>Item.Margin</i></dd></dl>


* * * 

### `onPaddingChange()`

<dl><dt>Parameters</dt><dd><ul><li>padding — <i>Item.Margin</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/flow.litcoffee#signal-flowonpaddingchangeitemmargin-padding)


* * * 

### `spacing`

<dl><dt>Type</dt><dd><i>Item.Spacing</i></dd></dl>


* * * 

### `onSpacingChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item.Spacing</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/flow.litcoffee#signal-flowonspacingchangeitemspacing-oldvalue)


* * * 

### `alignment`

<dl><dt>Type</dt><dd><i>Item.Alignment</i></dd></dl>


* * * 

### `onAlignmentChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item.Alignment</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/flow.litcoffee#signal-flowonalignmentchangeitemalignment-oldvalue)


* * * 

### `includeBorderMargins`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>


* * * 

### `onIncludeBorderMarginsChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/flow.litcoffee#signal-flowonincludebordermarginschangeboolean-oldvalue)


* * * 

### `collapseMargins`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>


* * * 

### `onCollapseMarginsChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/layout/flow.litcoffee#signal-flowoncollapsemarginschangeboolean-oldvalue)

