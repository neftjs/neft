Anchors @extension
==================

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

Horizontal anchors can't point to the vertical lines (and vice versa),
so `anchors.top = parent.left` is not allowed.

*Array* Anchors::left = null
----------------------------

## *Signal* Anchors::onLeftChange(*Array* oldValue)

*Array* Anchors::right = null
-----------------------------

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

## *Signal* Anchors::onTopChange(*Array* oldValue)

*Array* Anchors::bottom = null
------------------------------

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

*Array* Anchors::fillWidth = null
---------------------------------

## *Signal* Anchors::onFillWidthChange(*Array* oldValue)

*Array* Anchors::fillHeight = null
----------------------------------

## *Signal* Anchors::onFillHeightChange(*Array* oldValue)

