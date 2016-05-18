> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Column @class**

Column @class
=============

```nml
`Column {
`   spacing: 5
`
`   Rectangle { color: 'blue'; width: 50; height: 50; }
`   Rectangle { color: 'green'; width: 20; height: 50; }
`   Rectangle { color: 'red'; width: 50; height: 20; }
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/column.litcoffee#column-class)

## Table of contents
  * [Column.New([component, options])](#column-columnnewcomponent-component-object-options)
  * [Column() : *Renderer.Item*](#column-column--rendereritem)
  * [padding](#margin-columnpadding)
  * [spacing = 0](#float-columnspacing--0)
  * [alignment](#alignment-columnalignment)
  * [includeBorderMargins = false](#boolean-columnincludebordermargins--false)

*Column* Column.New([*Component* component, *Object* options])
--------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/column.litcoffee#column-columnnewcomponent-component-object-options)

*Column* Column() : *Renderer.Item*
-----------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/column.litcoffee#column-column--rendereritem)

*Margin* Column::padding
------------------------
## *Signal* Column::onPaddingChange(*Margin* padding)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/column.litcoffee#margin-columnpadding-signal-columnonpaddingchangemargin-padding)

*Float* Column::spacing = 0
---------------------------
## *Signal* Column::onSpacingChange(*Float* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/column.litcoffee#float-columnspacing--0-signal-columnonspacingchangefloat-oldvalue)

*Alignment* Column::alignment
-----------------------------
## *Signal* Column::onAlignmentChange(*Alignment* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/column.litcoffee#alignment-columnalignment-signal-columnonalignmentchangealignment-oldvalue)

*Boolean* Column::includeBorderMargins = false
----------------------------------------------
## *Signal* Column::onIncludeBorderMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/column.litcoffee#boolean-columnincludebordermargins--false-signal-columnonincludebordermarginschangeboolean-oldvalue)

