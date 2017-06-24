# Keys

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ [Item](/api/renderer-item.md) ▸ **Keys**

<!-- toc -->
```javascript
Rectangle {
    width: 100
    height: 100
    color: 'green'
    keys.focus: true
    keys.onPressed: function(){
        this.color = 'red';
    }
    keys.onReleased: function(){
        this.color = 'green';
    }
}
```


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/basics/item/keys.litcoffee)


* * * 

### `Keys.focusWindowOnPointerPress`

<dl><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocuswindowonpointerpress--true)


* * * 

### `Keys.focusedItem`

<dl><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/basics/item/keys.litcoffee#item-keysfocuseditem)


* * * 

### `**Class** Keys.Event`

<dl><dt>Extends</dt><dd><i>Device.KeyboardEvent</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/basics/item/keys.litcoffee#class-keysevent--devicekeyboardevent)


* * * 

### `onPress()`

<dl><dt>Parameters</dt><dd><ul><li>event — <i>Item.Keys.Event</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `onHold()`

<dl><dt>Parameters</dt><dd><ul><li>event — <i>Item.Keys.Event</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `onRelease()`

<dl><dt>Parameters</dt><dd><ul><li>event — <i>Item.Keys.Event</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `onInput()`

<dl><dt>Parameters</dt><dd><ul><li>event — <i>Item.Keys.Event</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/basics/item/keys.litcoffee#signal-keysoninputitemkeysevent-event)


* * * 

### `focus`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>


* * * 

### `onFocusChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/basics/item/keys.litcoffee#signal-keysonfocuschangeboolean-oldvalue)


* * * 

### `Keys.event`

<dl><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Item.Keys.Event</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/basics/item/keys.litcoffee#itemkeysevent-keysevent)

