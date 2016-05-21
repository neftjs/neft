> [Wiki](Home) ▸ [API Reference](API-Reference)

Margin
<dl></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#margin-extension)

Margin
<dl><dt>Returns</dt><dd><i>Margin</i></dd></dl>
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
<dl><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginleft--0-signal-marginonleftchangefloat-oldvalue)

top
<dl><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-margintop--0-signal-marginontopchangefloat-oldvalue)

right
<dl><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginright--0-signal-marginonrightchangefloat-oldvalue)

bottom
<dl><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginbottom--0-signal-marginonbottomchangefloat-oldvalue)

horizontal
<dl><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
Sum of the left and right margin.

## Table of contents
    * [Margin](#margin)
    * [Margin](#margin)
    * [left](#left)
    * [top](#top)
    * [right](#right)
    * [bottom](#bottom)
    * [horizontal](#horizontal)
  * [onHorizontalChange](#onhorizontalchange)
    * [vertical](#vertical)
  * [onVerticalChange](#onverticalchange)
    * [valueOf](#valueof)

##onHorizontalChange
<dl><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#signal-marginonhorizontalchangefloat-oldvalue)

vertical
<dl><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
Sum of the top and bottom margin.

##onVerticalChange
<dl><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#signal-marginonverticalchangefloat-oldvalue)

valueOf
<dl><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Returns</dt><dd><i>Float</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginvalueof)

