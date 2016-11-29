# Pointer

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ [Item](/api/renderer-item.md) ▸ **Pointer**

<!-- toc -->
```javascript
Rectangle {
    width: 100
    height: 100
    color: 'green'
    if (this.pointer.hover) {
        color: 'red'
    }
}
```


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee)

Enables mouse and touch handling.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee)


* * * 

### `enabled`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>


* * * 

### `onEnabledChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronenabledchangeboolean-oldvalue)


* * * 

### `draggable`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Not Implemented</dt></dl>


* * * 

### `onDraggableChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd><dt>Not Implemented</dt></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#hidden-signal-pointerondraggablechangeboolean-oldvalue)


* * * 

### `dragActive`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Not Implemented</dt></dl>


* * * 

### `onDragActiveChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd><dt>Not Implemented</dt></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#hidden-signal-pointerondragactivechangeboolean-oldvalue)


* * * 

### `onClick()`

<dl><dt>Parameters</dt><dd><ul><li>event — <i>Item.Pointer.Event</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `onPress()`

<dl><dt>Parameters</dt><dd><ul><li>event — <i>Item.Pointer.Event</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `onRelease()`

<dl><dt>Parameters</dt><dd><ul><li>event — <i>Item.Pointer.Event</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `onEnter()`

<dl><dt>Parameters</dt><dd><ul><li>event — <i>Item.Pointer.Event</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `onExit()`

<dl><dt>Parameters</dt><dd><ul><li>event — <i>Item.Pointer.Event</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `onWheel()`

<dl><dt>Parameters</dt><dd><ul><li>event — <i>Item.Pointer.Event</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `onMove()`

<dl><dt>Parameters</dt><dd><ul><li>event — <i>Item.Pointer.Event</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


* * * 

### `onDragStart()`

<dl><dt>Type</dt><dd><i>Signal</i></dd><dt>Not Implemented</dt></dl>


* * * 

### `onDragEnd()`

<dl><dt>Type</dt><dd><i>Signal</i></dd><dt>Not Implemented</dt></dl>


* * * 

### `onDragEnter()`

<dl><dt>Type</dt><dd><i>Signal</i></dd><dt>Not Implemented</dt></dl>


* * * 

### `onDragExit()`

<dl><dt>Type</dt><dd><i>Signal</i></dd><dt>Not Implemented</dt></dl>


* * * 

### `onDrop()`

<dl><dt>Type</dt><dd><i>Signal</i></dd><dt>Not Implemented</dt></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#hidden-signal-pointerondrop)


* * * 

### `pressed`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>

Whether the pointer is currently pressed.


* * * 

### `onPressedChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronpressedchangeboolean-oldvalue)


* * * 

### `hover`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>

Whether the pointer is currently under the item.


* * * 

### `onHoverChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronhoverchangeboolean-oldvalue)


* * * 

### `**Class** Pointer.Event`

<dl><dt>Extends</dt><dd><i>Device.PointerEvent</i></dd></dl>

Events order:
 1. Press
 2. Enter
 3. Move
 4. Move (not captured ensured items)
 5. Exit
 6. Release
 7. Click
 8. Release (not captured ensured items)

Stopped 'Enter' event will emit 'Move' event on this item.

Stopped 'Exit' event will emit 'Release' event on this item.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#class-pointerevent--devicepointerevent)


* * * 

### `stopPropagation`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>

Enable this property to stop further event propagation.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventstoppropagation--false)


* * * 

### `checkSiblings`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>

By default first deepest captured item will propagate this event only by his parents.

Change this value to test previous siblings as well.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventchecksiblings--false)


* * * 

### `ensureRelease`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>

Define whether pressed item should get 'onRelease' signal even
if the pointer has been released outside of this item.

Can be changed only in the 'onPress' signal.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventensurerelease--true)


* * * 

### `ensureMove`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>

Define whether the pressed item should get 'onMove' signals even
if the pointer is outside of this item.

Can be changed only in the 'onPress' signal.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventensuremove--true)


* * * 

### `Pointer.event`

<dl><dt>Static property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Item.Pointer.Event</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/basics/item/pointer.litcoffee#itempointerevent-pointerevent)

