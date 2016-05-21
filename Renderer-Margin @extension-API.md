> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Margin
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#margin-extension)

<dl><dt>Returns</dt><dd><i>Margin</i></dd></dl>
Margin
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

<dl><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
left
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginleft--0-signal-marginonleftchangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
top
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-margintop--0-signal-marginontopchangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
right
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginright--0-signal-marginonrightchangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
bottom
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginbottom--0-signal-marginonbottomchangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
horizontal
Sum of the left and right margin.

<dl><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Float</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
## Table of contents
    * [Margin](#margin)
    * [Margin](#margin)
    * [left](#left)
    * [top](#top)
    * [right](#right)
    * [bottom](#bottom)
    * [horizontal](#horizontal)
  * [onHorizontalChange](#onhorizontalchange)
  * [*Float* Margin::vertical = 0](#float-marginvertical--0)
  * [*Signal* Margin::onVerticalChange(*Float* oldValue)](#signal-marginonverticalchangefloat-oldvalue)
  * [*Float* Margin::valueOf()](#float-marginvalueof)

##onHorizontalChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#signal-marginonhorizontalchangefloat-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::vertical = 0
----------------------------

Sum of the top and bottom margin.

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Margin::onVerticalChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#signal-marginonverticalchangefloat-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::valueOf()
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginvalueof)

