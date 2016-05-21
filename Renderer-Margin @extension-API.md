> [Wiki](Home) ▸ [API Reference](API-Reference)

Margin
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#margin-extension)

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

left
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginleft--0-signal-marginonleftchangefloat-oldvalue)

top
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-margintop--0-signal-marginontopchangefloat-oldvalue)

right
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginright--0-signal-marginonrightchangefloat-oldvalue)

bottom
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginbottom--0-signal-marginonbottomchangefloat-oldvalue)

horizontal
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
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#signal-marginonhorizontalchangefloat-oldvalue)

vertical
Sum of the top and bottom margin.

##onVerticalChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#signal-marginonverticalchangefloat-oldvalue)

valueOf
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginvalueof)

