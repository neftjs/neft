# Anchors

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ [Item](/api/renderer-item.md) ▸ **Anchors**

<!-- toc -->

> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee)

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


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee)

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


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee)

Horizontal anchors can't point to the vertical lines (and vice versa),
so `anchors.top = parent.left` is not allowed.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee)


* * * 

### `left`

<dl><dt>Type</dt><dd><i>Array</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsleft)


* * * 

### `onLeftChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `right`

<dl><dt>Type</dt><dd><i>Array</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsright)


* * * 

### `onRightChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `horizontalCenter`

<dl><dt>Type</dt><dd><i>Array</i></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee#array-anchorshorizontalcenter)


* * * 

### `onHorizontalCenterChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `top`

<dl><dt>Type</dt><dd><i>Array</i></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee#array-anchorstop)


* * * 

### `onTopChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `bottom`

<dl><dt>Type</dt><dd><i>Array</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsbottom)


* * * 

### `onBottomChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `verticalCenter`

<dl><dt>Type</dt><dd><i>Array</i></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee#array-anchorsverticalcenter)


* * * 

### `onVerticalCenterChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `centerIn`

<dl><dt>Type</dt><dd><i>Array</i></dd></dl>

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


* * * 

### `onCenterInChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsoncenterinchangearray-oldvalue)


* * * 

### `fill`

<dl><dt>Type</dt><dd><i>Array</i></dd></dl>

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


* * * 

### `onFillChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonfillchangearray-oldvalue)


* * * 

### `fillWidth`

<dl><dt>Type</dt><dd><i>Array</i></dd></dl>


* * * 

### `onFillWidthChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonfillwidthchangearray-oldvalue)


* * * 

### `fillHeight`

<dl><dt>Type</dt><dd><i>Array</i></dd></dl>


* * * 

### `onFillHeightChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/anchors.litcoffee#signal-anchorsonfillheightchangearray-oldvalue)

