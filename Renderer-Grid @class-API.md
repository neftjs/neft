> [Wiki](Home) ▸ [API Reference](API-Reference)

Grid
<dl></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#grid-class)

New
<dl><dt>Static method of</dt><dd><i>Grid</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Grid</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#grid-gridnewcomponent-component-object-options)

Grid
<dl><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Grid</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#grid-grid--rendereritem)

padding
<dl><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Margin</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#margin-gridpadding-signal-gridonpaddingchangemargin-padding)

columns
<dl><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>2</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#integer-gridcolumns--2-signal-gridoncolumnschangeinteger-oldvalue)

rows
<dl><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>Infinity</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#integer-gridrows--infinity-signal-gridonrowschangeinteger-oldvalue)

spacing
<dl><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Spacing</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#spacing-gridspacing-signal-gridonspacingchangespacing-oldvalue)

alignment
<dl><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Alignment</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#alignment-gridalignment-signal-gridonalignmentchangealignment-oldvalue)

includeBorderMargins
<dl><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#boolean-gridincludebordermargins--false-signal-gridonincludebordermarginschangeboolean-oldvalue)

