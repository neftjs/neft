> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Anchors @extension**

Anchors @extension
==================

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#anchors-extension)

## Table of contents
  * [Anchors()](#anchors-anchors)
  * [left = null](#array-anchorsleft--null)
  * [onLeftChange(oldValue)](#signal-anchorsonleftchangearray-oldvalue)
  * [onRightChange(oldValue)](#signal-anchorsonrightchangearray-oldvalue)
  * [onHorizontalCenterChange(oldValue)](#signal-anchorsonhorizontalcenterchangearray-oldvalue)
  * [onTopChange(oldValue)](#signal-anchorsontopchangearray-oldvalue)
  * [onBottomChange(oldValue)](#signal-anchorsonbottomchangearray-oldvalue)
  * [onVerticalCenterChange(oldValue)](#signal-anchorsonverticalcenterchangearray-oldvalue)
  * [onCenterInChange(oldValue)](#signal-anchorsoncenterinchangearray-oldvalue)
  * [fill = null](#array-anchorsfill--null)
  * [onFillChange(oldValue)](#signal-anchorsonfillchangearray-oldvalue)
  * [fillWidth = null](#array-anchorsfillwidth--null)
  * [fillHeight = null](#array-anchorsfillheight--null)

*Anchors* Anchors()
-------------------

Anchors describe position relations between two items.
Each item has few lines: top, bottom, verticalCenter, left, right, horizontalCenter.
Anchors give a posibility to say, that a line of the first item must be
always in the same position as a line of the second item.
Anchors work only between siblings and in relation to the direct parent.
```nml
`Item {
`   height: 100
`
`   Rectangle {
`       id: rect1
`       width: 100
`       height: 100
`       color: 'green'
`   }
`
`   Rectangle {
`       width: 40
`       height: 40
`       color: 'red'
`       anchors.left: rect1.right
`   }
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#anchors-anchors)

```nml
`Rectangle {
`   width: 100
`   height: 100
`   color: 'green'
`
`   Rectangle {
`       width: 40
`       height: 40
`       color: 'red'
`       anchors.left: parent.right
`   }
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#anchors-anchors)

Horizontal anchors can't point to the vertical lines (and vice versa),
so `anchors.top = parent.left` is not allowed.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#anchors-anchors)

*Array* Anchors::left = null
----------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsleft--null)

## *Signal* Anchors::onLeftChange(*Array* oldValue)
*Array* Anchors::right = null
-----------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonleftchangearray-oldvaluearray-anchorsright--null)

## *Signal* Anchors::onRightChange(*Array* oldValue)
*Array* Anchors::horizontalCenter = null
----------------------------------------

```nml
`Item {
`   height: 100
`
`   Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
`   Rectangle {
`       color: 'red'; width: 40; height: 40
`       anchors.horizontalCenter: rect1.horizontalCenter
`   }
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonrightchangearray-oldvaluearray-anchorshorizontalcenter--null)

## *Signal* Anchors::onHorizontalCenterChange(*Array* oldValue)
*Array* Anchors::top = null
---------------------------

```nml
`Item {
`   height: 100
`
`   Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
`   Rectangle {
`       color: 'red'; width: 40; height: 40
`       anchors.top: rect1.verticalCenter
`   }
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonhorizontalcenterchangearray-oldvaluearray-anchorstop--null)

## *Signal* Anchors::onTopChange(*Array* oldValue)
*Array* Anchors::bottom = null
------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsontopchangearray-oldvaluearray-anchorsbottom--null)

## *Signal* Anchors::onBottomChange(*Array* oldValue)
*Array* Anchors::verticalCenter = null
--------------------------------------

```nml
`Item {
`   height: 100
`
`   Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
`   Rectangle {
`       color: 'red'; width: 40; height: 40
`       anchors.verticalCenter: rect1.verticalCenter
`   }
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonbottomchangearray-oldvaluearray-anchorsverticalcenter--null)

## *Signal* Anchors::onVerticalCenterChange(*Array* oldValue)
*Array* Anchors::centerIn = null
--------------------------------

It's a shortcut for the horizontalCenter and verticalCenter anchors.
No target line is required.
```nml
`Rectangle {
`   id: rect1
`   width: 100
`   height: 100
`   color: 'green'
`
`   Rectangle {
`       width: 40
`       height: 40
`       color: 'red'
`       anchors.centerIn: parent
`   }
`}
```

## *Signal* Anchors::onCenterInChange(*Array* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsoncenterinchangearray-oldvalue)

*Array* Anchors::fill = null
----------------------------

Changes item position and its size to be always equal the anchored target.
No target line is required.
```nml
`Item {
`   height: 100
`
`   Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
`   Rectangle {
`       color: 'red'
`       opacity: 0.5
`       anchors.fill: rect1
`   }
`}
```

## *Signal* Anchors::onFillChange(*Array* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonfillchangearray-oldvalue)

*Array* Anchors::fillWidth = null
---------------------------------
## *Signal* Anchors::onFillWidthChange(*Array* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsfillwidth--null-signal-anchorsonfillwidthchangearray-oldvalue)

*Array* Anchors::fillHeight = null
----------------------------------
## *Signal* Anchors::onFillHeightChange(*Array* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsfillheight--null-signal-anchorsonfillheightchangearray-oldvalue)

