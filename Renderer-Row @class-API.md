> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Row @class**

Row @class
==========

```nml
`Row {
`   spacing: 5
`
`   Rectangle { color: 'blue'; width: 50; height: 50; }
`   Rectangle { color: 'green'; width: 20; height: 50; }
`   Rectangle { color: 'red'; width: 50; height: 20; }
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/row.litcoffee#row-class)

## Table of contents
  * [Row.New([component, options])](#row-rownewcomponent-component-object-options)
  * [Row() : *Renderer.Item*](#row-row--rendereritem)
  * [padding](#margin-rowpadding)
  * [spacing = 0](#float-rowspacing--0)
  * [alignment](#alignment-rowalignment)
  * [includeBorderMargins = false](#boolean-rowincludebordermargins--false)

*Row* Row.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
--------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/row.litcoffee#row-rownewcomponent-component-object-options)

*Row* Row() : *Renderer.Item*
-----------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/row.litcoffee#row-row--rendereritem)

*Margin* Row::padding
---------------------
## *Signal* Row::onPaddingChange(*Margin* padding)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/row.litcoffee#margin-rowpadding-signal-rowonpaddingchangemargin-padding)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Row::spacing = 0
------------------------
## *Signal* Row::onSpacingChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/row.litcoffee#float-rowspacing--0-signal-rowonspacingchangefloat-oldvalue)

*Alignment* Row::alignment
--------------------------
## *Signal* Row::onAlignmentChange(*Alignment* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/row.litcoffee#alignment-rowalignment-signal-rowonalignmentchangealignment-oldvalue)

*Boolean* Row::includeBorderMargins = false
-------------------------------------------
## *Signal* Row::onIncludeBorderMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/row.litcoffee#boolean-rowincludebordermargins--false-signal-rowonincludebordermarginschangeboolean-oldvalue)

