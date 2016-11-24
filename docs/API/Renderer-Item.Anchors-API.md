> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **Anchors**

#Anchors
<dl><dt>Syntax</dt><dd><code>Item.Anchors</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee#itemanchors)

## Table of contents
* [Anchors](#anchors)
* [**Class** Anchors](#class-anchors)
  * [left](#left)
  * [onLeftChange](#onleftchange)
  * [right](#right)
  * [onRightChange](#onrightchange)
  * [horizontalCenter](#horizontalcenter)
  * [onHorizontalCenterChange](#onhorizontalcenterchange)
  * [top](#top)
  * [onTopChange](#ontopchange)
  * [bottom](#bottom)
  * [onBottomChange](#onbottomchange)
  * [verticalCenter](#verticalcenter)
  * [onVerticalCenterChange](#onverticalcenterchange)
  * [centerIn](#centerin)
  * [onCenterInChange](#oncenterinchange)
  * [fill](#fill)
  * [onFillChange](#onfillchange)
  * [fillWidth](#fillwidth)
  * [onFillWidthChange](#onfillwidthchange)
  * [fillHeight](#fillheight)
  * [onFillHeightChange](#onfillheightchange)
* [Glossary](#glossary)

# **Class** Anchors

Anchors describe position relations between two items.

Each item has few lines: top, bottom, verticalCenter, left, right, horizontalCenter.

Anchors give a posibility to say, that a line of the first item must be
always in the same position as a line of the second item.

Anchors work only between siblings and in relation to the direct parent.

```javascript
Item {
    height: 100
    Rectangle {
        id: rect1
        width: 100
        height: 100
        color: 'green'
    }
    Rectangle {
        width: 40
        height: 40
        color: 'red'
        anchors.left: rect1.right
    }
}
```

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee)

```javascript
Rectangle {
    width: 100
    height: 100
    color: 'green'
    Rectangle {
        width: 40
        height: 40
        color: 'red'
        anchors.left: parent.right
    }
}
```

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee)

Horizontal anchors can't point to the vertical lines (and vice versa),
so `anchors.top = parent.left` is not allowed.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee)

##left
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::left</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsleft)

##onLeftChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onLeftChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
##right
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::right</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsright)

##onRightChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onRightChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
##horizontalCenter
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::horizontalCenter</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
```javascript
Item {
    height: 100
    Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
    Rectangle {
        color: 'red'; width: 40; height: 40
        anchors.horizontalCenter: rect1.horizontalCenter
    }
}
```

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee#array-anchorshorizontalcenter)

##onHorizontalCenterChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onHorizontalCenterChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
##top
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::top</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
```javascript
Item {
    height: 100
    Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
    Rectangle {
        color: 'red'; width: 40; height: 40
        anchors.top: rect1.verticalCenter
    }
}
```

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee#array-anchorstop)

##onTopChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onTopChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
##bottom
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::bottom</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsbottom)

##onBottomChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onBottomChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
##verticalCenter
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::verticalCenter</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
```javascript
Item {
    height: 100
    Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
    Rectangle {
        color: 'red'; width: 40; height: 40
        anchors.verticalCenter: rect1.verticalCenter
    }
}
```

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsverticalcenter)

##onVerticalCenterChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onVerticalCenterChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
##centerIn
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::centerIn</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
It's a shortcut for the horizontalCenter and verticalCenter anchors.

No target line is required.

```javascript
Rectangle {
    id: rect1
    width: 100
    height: 100
    color: 'green'
    Rectangle {
        width: 40
        height: 40
        color: 'red'
        anchors.centerIn: parent
    }
}
```

##onCenterInChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onCenterInChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsoncenterinchangearray-oldvalue)

##fill
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::fill</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
Changes item position and its size to be always equal the anchored target.

No target line is required.

```javascript
Item {
    height: 100
    Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
    Rectangle {
        color: 'red'
        opacity: 0.5
        anchors.fill: rect1
    }
}
```

##onFillChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onFillChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonfillchangearray-oldvalue)

##fillWidth
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::fillWidth</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
##onFillWidthChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onFillWidthChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonfillwidthchangearray-oldvalue)

##fillHeight
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Anchors::fillHeight</code></dd><dt>Prototype property of</dt><dd><i>Anchors</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
##onFillHeightChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Anchors::onFillHeightChange(&#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Anchors</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonfillheightchangearray-oldvalue)

# Glossary

- [Item.Anchors](#class-anchors)

