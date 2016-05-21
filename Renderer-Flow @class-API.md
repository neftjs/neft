> [Wiki](Home) ▸ [API Reference](API-Reference)

Flow
<dl></dl>
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
<dl><dt>Static method of</dt><dd><i>Flow</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Flow</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#flow-flownewcomponent-component-object-options)

Flow
<dl><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Flow</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#flow-flow--rendereritem)

padding
<dl><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Margin</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#margin-flowpadding-signal-flowonpaddingchangemargin-padding)

spacing
<dl><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Spacing</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#spacing-flowspacing-signal-flowonspacingchangespacing-oldvalue)

alignment
<dl><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Alignment</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#alignment-flowalignment-signal-flowonalignmentchangealignment-oldvalue)

includeBorderMargins
<dl><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#boolean-flowincludebordermargins--false-signal-flowonincludebordermarginschangeboolean-oldvalue)

collapseMargins
<dl><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/flow.litcoffee#boolean-flowcollapsemargins--false-signal-flowoncollapsemarginschangeboolean-oldvalue)

