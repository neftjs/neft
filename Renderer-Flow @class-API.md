> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Flow
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

<dl><dt>Static method of</dt><dd><i>Flow</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Flow</i></dd></dl>
New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#flow-flownewcomponent-component-object-options)

<dl><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Flow</i></dd></dl>
Flow
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#flow-flow--rendereritem)

<dl><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Margin</i></dd></dl>
padding
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#margin-flowpadding-signal-flowonpaddingchangemargin-padding)

<dl><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Spacing</i></dd></dl>
spacing
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#spacing-flowspacing-signal-flowonspacingchangespacing-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Alignment</i></dd></dl>
alignment
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#alignment-flowalignment-signal-flowonalignmentchangealignment-oldvalue)

## Table of contents
    * [Flow](#flow)
    * [New](#new)
    * [Flow](#flow)
    * [padding](#padding)
    * [spacing](#spacing)
    * [alignment](#alignment)
  * [*Boolean* Flow::includeBorderMargins = false](#boolean-flowincludebordermargins--false)
  * [*Boolean* Flow::collapseMargins = false](#boolean-flowcollapsemargins--false)

*Boolean* Flow::includeBorderMargins = false
-------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Flow::onIncludeBorderMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#boolean-flowincludebordermargins--false-signal-flowonincludebordermarginschangeboolean-oldvalue)

*Boolean* Flow::collapseMargins = false
---------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Flow::onCollapseMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#boolean-flowcollapsemargins--false-signal-flowoncollapsemarginschangeboolean-oldvalue)

