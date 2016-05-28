> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]]

Column
<dl><dt>Syntax</dt><dd><code>Column @class</code></dd></dl>
```nml
`Column {
`   spacing: 5
`
`   Rectangle { color: 'blue'; width: 50; height: 50; }
`   Rectangle { color: 'green'; width: 20; height: 50; }
`   Rectangle { color: 'red'; width: 50; height: 20; }
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/column.litcoffee#column)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;Column&#x2A; Column.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>Column</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Column</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/column.litcoffee#new)

Column
<dl><dt>Syntax</dt><dd><code>&#x2A;Column&#x2A; Column() : &#x2A;Renderer.Item&#x2A;</code></dd><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Column</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/column.litcoffee#column)

padding
<dl><dt>Syntax</dt><dd><code>&#x2A;Margin&#x2A; Column::padding</code></dd><dt>Prototype property of</dt><dd><i>Column</i></dd><dt>Type</dt><dd><i>Margin</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/column.litcoffee#padding)

spacing
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Column::spacing = 0</code></dd><dt>Prototype property of</dt><dd><i>Column</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/column.litcoffee#spacing)

alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Alignment&#x2A; Column::alignment</code></dd><dt>Prototype property of</dt><dd><i>Column</i></dd><dt>Type</dt><dd><i>Alignment</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/column.litcoffee#alignment)

includeBorderMargins
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Column::includeBorderMargins = false</code></dd><dt>Prototype property of</dt><dd><i>Column</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/column.litcoffee#includebordermargins)

