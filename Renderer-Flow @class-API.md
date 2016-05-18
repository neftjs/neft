> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Flow @class**

Flow @class
===========

```nml
`Flow {
`   width: 90
`   spacing.column: 15
`   spacing.row: 5
`
`   Rectangle { color: 'blue'; width: 60; height: 50; }
`   Rectangle { color: 'green'; width: 20; height: 70; }
`   Rectangle { color: 'red'; width: 50; height: 30; }
`   Rectangle { color: 'yellow'; width: 20; height: 20; }
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#flow-class)

## Table of contents
  * [Flow.New([component, options])](#flow-flownewcomponent-component-object-options)
  * [Flow() : *Renderer.Item*](#flow-flow--rendereritem)
  * [padding](#margin-flowpadding)
  * [spacing](#spacing-flowspacing)
  * [alignment](#alignment-flowalignment)
  * [includeBorderMargins = false](#boolean-flowincludebordermargins--false)
  * [collapseMargins = false](#boolean-flowcollapsemargins--false)

*Flow* Flow.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
----------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#flow-flownewcomponent-component-object-options)

*Flow* Flow() : *Renderer.Item*
-------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#flow-flow--rendereritem)

*Margin* Flow::padding
----------------------
## *Signal* Flow::onPaddingChange(*Margin* padding)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#margin-flowpadding-signal-flowonpaddingchangemargin-padding)

*Spacing* Flow::spacing
-----------------------
## *Signal* Flow::onSpacingChange(*Spacing* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#spacing-flowspacing-signal-flowonspacingchangespacing-oldvalue)

*Alignment* Flow::alignment
---------------------------
## *Signal* Flow::onAlignmentChange(*Alignment* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#alignment-flowalignment-signal-flowonalignmentchangealignment-oldvalue)

*Boolean* Flow::includeBorderMargins = false
-------------------------------------------
## *Signal* Flow::onIncludeBorderMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#boolean-flowincludebordermargins--false-signal-flowonincludebordermarginschangeboolean-oldvalue)

*Boolean* Flow::collapseMargins = false
---------------------------------------
## *Signal* Flow::onCollapseMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#boolean-flowcollapsemargins--false-signal-flowoncollapsemarginschangeboolean-oldvalue)

