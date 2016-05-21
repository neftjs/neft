> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Grid
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

<dl><dt>Static method of</dt><dd><i>Grid</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Grid</i></dd></dl>
New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#grid-gridnewcomponent-component-object-options)

<dl><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Grid</i></dd></dl>
Grid
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#grid-grid--rendereritem)

<dl><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Margin</i></dd></dl>
padding
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#margin-gridpadding-signal-gridonpaddingchangemargin-padding)

<dl><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>2</code></dd></dl>
columns
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#integer-gridcolumns--2-signal-gridoncolumnschangeinteger-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Grid</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>Infinity</code></dd></dl>
rows
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#integer-gridrows--infinity-signal-gridonrowschangeinteger-oldvalue)

## Table of contents
    * [Grid](#grid)
    * [New](#new)
    * [Grid](#grid)
    * [padding](#padding)
    * [columns](#columns)
    * [rows](#rows)
  * [*Spacing* Grid::spacing](#spacing-gridspacing)
  * [*Alignment* Grid::alignment](#alignment-gridalignment)
  * [*Boolean* Grid::includeBorderMargins = false](#boolean-gridincludebordermargins--false)

*Spacing* Grid::spacing
-----------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Grid::onSpacingChange(*Spacing* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#spacing-gridspacing-signal-gridonspacingchangespacing-oldvalue)

*Alignment* Grid::alignment
---------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Grid::onAlignmentChange(*Alignment* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#alignment-gridalignment-signal-gridonalignmentchangealignment-oldvalue)

*Boolean* Grid::includeBorderMargins = false
--------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Grid::onIncludeBorderMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#boolean-gridincludebordermargins--false-signal-gridonincludebordermarginschangeboolean-oldvalue)

