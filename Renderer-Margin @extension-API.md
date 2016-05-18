> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Margin @extension**

Margin @extension
=================

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#margin-extension)

## Table of contents
  * [Margin()](#margin-margin)
  * [left = 0](#float-marginleft--0)
  * [top = 0](#float-margintop--0)
  * [right = 0](#float-marginright--0)
  * [bottom = 0](#float-marginbottom--0)
  * [horizontal = 0](#float-marginhorizontal--0)
  * [onHorizontalChange(oldValue)](#signal-marginonhorizontalchangefloat-oldvalue)
  * [vertical = 0](#float-marginvertical--0)
  * [onVerticalChange(oldValue)](#signal-marginonverticalchangefloat-oldvalue)
  * [valueOf()](#float-marginvalueof)

*Margin* Margin()
-----------------

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

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::left = 0
------------------------
## *Signal* Margin::onLeftChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginleft--0-signal-marginonleftchangefloat-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::top = 0
-----------------------
## *Signal* Margin::onTopChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-margintop--0-signal-marginontopchangefloat-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::right = 0
-------------------------
## *Signal* Margin::onRightChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginright--0-signal-marginonrightchangefloat-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::bottom = 0
--------------------------
## *Signal* Margin::onBottomChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginbottom--0-signal-marginonbottomchangefloat-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::horizontal = 0
------------------------------

Sum of the left and right margin.

## *Signal* Margin::onHorizontalChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#signal-marginonhorizontalchangefloat-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::vertical = 0
----------------------------

Sum of the top and bottom margin.

## *Signal* Margin::onVerticalChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#signal-marginonverticalchangefloat-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Margin::valueOf()
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/margin.litcoffee#float-marginvalueof)

