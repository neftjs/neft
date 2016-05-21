> [Wiki](Home) ▸ [API Reference](API-Reference)

Margin
<dl><dt>Syntax</dt><dd><code>Margin @extension</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/margin.litcoffee#margin-extension)

Margin
<dl><dt>Syntax</dt><dd><code>&#x2A;Margin&#x2A; Margin()</code></dd><dt>Returns</dt><dd><i>Margin</i></dd></dl>
Margins are used in anchors and within layout items.
```nml
`Rectangle {
`   width: 100
`   height: 100
`   color: 'red'
`
`   Rectangle {
`       width: 100
`       height: 50
`       color: 'yellow'
`       anchors.left: parent.right
`       margin.left: 20
`   }
`}
```
```nml
`Column {
`   Rectangle { color: 'red'; width: 50; height: 50; }
`   Rectangle { color: 'yellow'; width: 50; height: 50; margin.top: 20; }
`   Rectangle { color: 'green'; width: 50; height: 50; }
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/margin.litcoffee#margin-margin)

left
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::left = 0</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/margin.litcoffee#float-marginleft--0-signal-marginonleftchangefloat-oldvalue)

top
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::top = 0</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/margin.litcoffee#float-margintop--0-signal-marginontopchangefloat-oldvalue)

right
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::right = 0</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/margin.litcoffee#float-marginright--0-signal-marginonrightchangefloat-oldvalue)

bottom
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::bottom = 0</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/margin.litcoffee#float-marginbottom--0-signal-marginonbottomchangefloat-oldvalue)

horizontal
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::horizontal = 0</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
Sum of the left and right margin.

##onHorizontalChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Margin::onHorizontalChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/margin.litcoffee#signal-marginonhorizontalchangefloat-oldvalue)

vertical
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::vertical = 0</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
Sum of the top and bottom margin.

##onVerticalChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Margin::onVerticalChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/margin.litcoffee#signal-marginonverticalchangefloat-oldvalue)

valueOf
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::valueOf()</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value">Float</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/margin.litcoffee#float-marginvalueof)

