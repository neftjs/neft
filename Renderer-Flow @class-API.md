> [Wiki](Home) ▸ [API Reference](API-Reference)

Flow
<dl><dt>Syntax</dt><dd>Flow @class</dd></dl>
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

New
<dl><dt>Syntax</dt><dd>*Flow* Flow.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])</dd><dt>Static method of</dt><dd><i>Flow</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Flow</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#flow-flownewcomponent-component-object-options)

Flow
<dl><dt>Syntax</dt><dd>*Flow* Flow() : *Renderer.Item*</dd><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Flow</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#flow-flow--rendereritem)

padding
<dl><dt>Syntax</dt><dd>*Margin* Flow::padding</dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Margin</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#margin-flowpadding-signal-flowonpaddingchangemargin-padding)

spacing
<dl><dt>Syntax</dt><dd>*Spacing* Flow::spacing</dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Spacing</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#spacing-flowspacing-signal-flowonspacingchangespacing-oldvalue)

alignment
<dl><dt>Syntax</dt><dd>*Alignment* Flow::alignment</dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Alignment</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#alignment-flowalignment-signal-flowonalignmentchangealignment-oldvalue)

includeBorderMargins
<dl><dt>Syntax</dt><dd>*Boolean* Flow::includeBorderMargins = false</dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#boolean-flowincludebordermargins--false-signal-flowonincludebordermarginschangeboolean-oldvalue)

collapseMargins
<dl><dt>Syntax</dt><dd>*Boolean* Flow::collapseMargins = false</dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#boolean-flowcollapsemargins--false-signal-flowoncollapsemarginschangeboolean-oldvalue)

