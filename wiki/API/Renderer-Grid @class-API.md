> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]]

Grid
<dl><dt>Syntax</dt><dd><code>Grid @class</code></dd></dl>
```nml
`Grid {
`   spacing.column: 15
`   spacing.row: 5
`   columns: 2
`
`   Rectangle { color: 'blue'; width: 60; height: 50; }
`   Rectangle { color: 'green'; width: 20; height: 70; }
`   Rectangle { color: 'red'; width: 50; height: 30; }
`   Rectangle { color: 'yellow'; width: 20; height: 20; }
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/grid.litcoffee#grid)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;Grid&#x2A; Grid.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>Grid</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/API/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Grid</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/grid.litcoffee#new)

Grid
<dl><dt>Syntax</dt><dd><code>&#x2A;Grid&#x2A; Grid() : &#x2A;Renderer.Item&#x2A;</code></dd><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Grid</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/grid.litcoffee#grid)

padding
<dl><dt>Syntax</dt><dd><code>&#x2A;Margin&#x2A; Grid::padding</code></dd><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Margin</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/grid.litcoffee#padding)

columns
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; Grid::columns = 2</code></dd><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/API/Utils-API#isinteger">Integer</a></dd><dt>Default</dt><dd><code>2</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/grid.litcoffee#columns)

rows
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; Grid::rows = Infinity</code></dd><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/API/Utils-API#isinteger">Integer</a></dd><dt>Default</dt><dd><code>Infinity</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/grid.litcoffee#rows)

spacing
<dl><dt>Syntax</dt><dd><code>&#x2A;Spacing&#x2A; Grid::spacing</code></dd><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Spacing</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/grid.litcoffee#spacing)

alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Alignment&#x2A; Grid::alignment</code></dd><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Alignment</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/grid.litcoffee#alignment)

includeBorderMargins
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Grid::includeBorderMargins = false</code></dd><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/grid.litcoffee#includebordermargins)

