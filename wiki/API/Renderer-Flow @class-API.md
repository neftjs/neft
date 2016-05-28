> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]]

Flow
<dl><dt>Syntax</dt><dd><code>Flow @class</code></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/flow.litcoffee#flow)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;Flow&#x2A; Flow.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>Flow</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API.md#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Flow</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/flow.litcoffee#new)

Flow
<dl><dt>Syntax</dt><dd><code>&#x2A;Flow&#x2A; Flow() : &#x2A;Renderer.Item&#x2A;</code></dd><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Flow</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/flow.litcoffee#flow)

padding
<dl><dt>Syntax</dt><dd><code>&#x2A;Margin&#x2A; Flow::padding</code></dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Margin</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/flow.litcoffee#padding)

spacing
<dl><dt>Syntax</dt><dd><code>&#x2A;Spacing&#x2A; Flow::spacing</code></dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Spacing</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/flow.litcoffee#spacing)

alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Alignment&#x2A; Flow::alignment</code></dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Alignment</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/flow.litcoffee#alignment)

includeBorderMargins
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Flow::includeBorderMargins = false</code></dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/flow.litcoffee#includebordermargins)

collapseMargins
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Flow::collapseMargins = false</code></dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/layout/flow.litcoffee#collapsemargins)

