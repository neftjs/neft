> [Wiki](Home) ▸ [API Reference](API-Reference)

Margin
<dl><dt>Syntax</dt><dd>Margin @extension</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#margin-extension)

Margin
<dl><dt>Syntax</dt><dd>*Margin* Margin()</dd><dt>Returns</dt><dd><i>Margin</i></dd></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#margin-margin)

left
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::left = 0</dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginleft--0-signal-marginonleftchangefloat-oldvalue)

top
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::top = 0</dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-margintop--0-signal-marginontopchangefloat-oldvalue)

right
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::right = 0</dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginright--0-signal-marginonrightchangefloat-oldvalue)

bottom
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::bottom = 0</dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginbottom--0-signal-marginonbottomchangefloat-oldvalue)

horizontal
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::horizontal = 0</dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
Sum of the left and right margin.

##onHorizontalChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Margin::onHorizontalChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)</dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#signal-marginonhorizontalchangefloat-oldvalue)

vertical
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::vertical = 0</dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
Sum of the top and bottom margin.

##onVerticalChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Margin::onVerticalChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)</dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#signal-marginonverticalchangefloat-oldvalue)

valueOf
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::valueOf()</dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Returns</dt><dd><i>Float</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginvalueof)

