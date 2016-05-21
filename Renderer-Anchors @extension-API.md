> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Anchors
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#anchors-extension)

<dl><dt>Returns</dt><dd><i>Anchors</i></dd></dl>
Anchors
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

<dl><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>
left
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsleft--null)

<dl><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
## Table of contents
    * [Anchors](#anchors)
    * [Anchors](#anchors)
    * [left](#left)
  * [onLeftChange](#onleftchange)
  * [onRightChange](#onrightchange)
  * [onHorizontalCenterChange](#onhorizontalcenterchange)
  * [onTopChange](#ontopchange)
  * [onBottomChange](#onbottomchange)
  * [onVerticalCenterChange](#onverticalcenterchange)
  * [onCenterInChange](#oncenterinchange)
  * [*Array* Anchors::fill = null](#array-anchorsfill--null)
  * [*Signal* Anchors::onFillChange(*Array* oldValue)](#signal-anchorsonfillchangearray-oldvalue)
  * [*Array* Anchors::fillWidth = null](#array-anchorsfillwidth--null)
  * [*Array* Anchors::fillHeight = null](#array-anchorsfillheight--null)

##onLeftChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonleftchangearray-oldvaluearray-anchorsright--null)

<dl><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
##onRightChange
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

<dl><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
##onHorizontalCenterChange
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

<dl><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
##onTopChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsontopchangearray-oldvaluearray-anchorsbottom--null)

<dl><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
##onBottomChange
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

<dl><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
##onVerticalCenterChange
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

<dl><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
##onCenterInChange
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

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Anchors::onFillChange(*Array* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonfillchangearray-oldvalue)

*Array* Anchors::fillWidth = null
---------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Anchors::onFillWidthChange(*Array* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsfillwidth--null-signal-anchorsonfillwidthchangearray-oldvalue)

*Array* Anchors::fillHeight = null
----------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Anchors::onFillHeightChange(*Array* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsfillheight--null-signal-anchorsonfillheightchangearray-oldvalue)

