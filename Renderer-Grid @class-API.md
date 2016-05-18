> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Grid @class**

Grid @class
===========

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

## Table of contents
  * [Grid.New([component, options])](#grid-gridnewcomponent-component-object-options)
  * [Grid() : *Renderer.Item*](#grid-grid--rendereritem)
  * [padding](#margin-gridpadding)
  * [columns = 2](#integer-gridcolumns--2)
  * [rows = Infinity](#integer-gridrows--infinity)
  * [spacing](#spacing-gridspacing)
  * [alignment](#alignment-gridalignment)
  * [includeBorderMargins = false](#boolean-gridincludebordermargins--false)

*Grid* Grid.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
----------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#grid-gridnewcomponent-component-object-options)

*Grid* Grid() : *Renderer.Item*
-------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#grid-grid--rendereritem)

*Margin* Grid::padding
----------------------
## *Signal* Grid::onPaddingChange(*Margin* padding)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#margin-gridpadding-signal-gridonpaddingchangemargin-padding)

[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Grid::columns = 2
---------------------------
## *Signal* Grid::onColumnsChange([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#integer-gridcolumns--2-signal-gridoncolumnschangeinteger-oldvalue)

[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Grid::rows = Infinity
-------------------------------
## *Signal* Grid::onRowsChange([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#integer-gridrows--infinity-signal-gridonrowschangeinteger-oldvalue)

*Spacing* Grid::spacing
-----------------------
## *Signal* Grid::onSpacingChange(*Spacing* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#spacing-gridspacing-signal-gridonspacingchangespacing-oldvalue)

*Alignment* Grid::alignment
---------------------------
## *Signal* Grid::onAlignmentChange(*Alignment* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#alignment-gridalignment-signal-gridonalignmentchangealignment-oldvalue)

*Boolean* Grid::includeBorderMargins = false
--------------------------------------------
## *Signal* Grid::onIncludeBorderMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/grid.litcoffee#boolean-gridincludebordermargins--false-signal-gridonincludebordermarginschangeboolean-oldvalue)

