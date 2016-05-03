Margin @extension
=================

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

*Float* Margin::left = 0
------------------------

## *Signal* Margin::onLeftChange(*Float* oldValue)

*Float* Margin::top = 0
-----------------------

## *Signal* Margin::onTopChange(*Float* oldValue)

*Float* Margin::right = 0
-------------------------

## *Signal* Margin::onRightChange(*Float* oldValue)

*Float* Margin::bottom = 0
--------------------------

## *Signal* Margin::onBottomChange(*Float* oldValue)

*Float* Margin::horizontal = 0
------------------------------

Sum of the left and right margin.

## *Signal* Margin::onHorizontalChange(*Float* oldValue)

*Float* Margin::vertical = 0
----------------------------

Sum of the top and bottom margin.

## *Signal* Margin::onVerticalChange(*Float* oldValue)

*Float* Margin::valueOf()
--------------------------

