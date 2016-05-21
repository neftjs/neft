> [Wiki](Home) ▸ [API Reference](API-Reference)

Anchors
<dl><dt>Syntax</dt><dd><code>Anchors @extension</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#anchors-extension)

Anchors
<dl><dt>Syntax</dt><dd><code>&#x2A;Anchors&#x2A; Anchors()</code></dd><dt>Returns</dt><dd><i>Anchors</i></dd></dl>
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

left
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::left = null</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsleft--null)

##onLeftChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onLeftChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonleftchangearray-oldvaluearray-anchorsright--null)

##onRightChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onRightChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
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

##onHorizontalCenterChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onHorizontalCenterChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
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

##onTopChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onTopChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsontopchangearray-oldvaluearray-anchorsbottom--null)

##onBottomChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onBottomChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
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

##onVerticalCenterChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onVerticalCenterChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
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

##onCenterInChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onCenterInChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsoncenterinchangearray-oldvalue)

fill
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::fill = null</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>
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

##onFillChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onFillChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonfillchangearray-oldvalue)

fillWidth
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::fillWidth = null</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsfillwidth--null-signal-anchorsonfillwidthchangearray-oldvalue)

fillHeight
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::fillHeight = null</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsfillheight--null-signal-anchorsonfillheightchangearray-oldvalue)

