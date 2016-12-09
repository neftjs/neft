# Margin

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ [Item](/api/renderer-item.md) ▸ **Margin**

<!-- toc -->

> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/margin.litcoffee)

Margins are used in anchors and within layout items.

```javascript
Rectangle {
    width: 100
    height: 100
    color: 'red'
    Rectangle {
        width: 100
        height: 50
        color: 'yellow'
        anchors.left: parent.right
        margin.left: 20
    }
}
```

```javascript
Column {
    Rectangle { color: 'red'; width: 50; height: 50; }
    Rectangle { color: 'yellow'; width: 50; height: 50; margin.top: 20; }
    Rectangle { color: 'green'; width: 50; height: 50; }
}
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/margin.litcoffee)


* * * 

### `left`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onLeftChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/margin.litcoffee#signal-marginonleftchangefloat-oldvalue)


* * * 

### `top`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onTopChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/margin.litcoffee#signal-marginontopchangefloat-oldvalue)


* * * 

### `right`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onRightChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/margin.litcoffee#signal-marginonrightchangefloat-oldvalue)


* * * 

### `bottom`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onBottomChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/margin.litcoffee#signal-marginonbottomchangefloat-oldvalue)


* * * 

### `horizontal`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>

Sum of the left and right margin.


* * * 

### `onHorizontalChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/margin.litcoffee#signal-marginonhorizontalchangefloat-oldvalue)


* * * 

### `vertical`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>

Sum of the top and bottom margin.


* * * 

### `onVerticalChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/margin.litcoffee#signal-marginonverticalchangefloat-oldvalue)


* * * 

### `valueOf()`

<dl><dt>Returns</dt><dd><i>Float</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/margin.litcoffee#float-marginvalueof)

