> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **Pointer**

#Pointer
<dl><dt>Syntax</dt><dd><code>Item.Pointer</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/Renderer-Item-API.md#class-item">Item</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#pointer)

## Table of contents
* [Pointer](#pointer)
* [**Class** Pointer](#class-pointer)
  * [*Boolean* Pointer::enabled = `true`](#boolean-pointerenabled--true)
  * [Hidden *Boolean* Pointer::draggable = `false`](#hidden-boolean-pointerdraggable--false)
  * [Hidden *Boolean* Pointer::dragActive = `false`](#hidden-boolean-pointerdragactive--false)
  * [onClick](#onclick)
  * [*Boolean* Pointer::pressed = `false`](#boolean-pointerpressed--false)
  * [onPressedChange](#onpressedchange)
  * [*Boolean* Pointer::hover = `false`](#boolean-pointerhover--false)
  * [onHoverChange](#onhoverchange)
  * [**Class** Pointer.Event](#class-pointerevent)
    * [*Boolean* PointerEvent::stopPropagation = `false`](#boolean-pointereventstoppropagation--false)
    * [*Boolean* PointerEvent::checkSiblings = `false`](#boolean-pointereventchecksiblings--false)
    * [*Boolean* PointerEvent::ensureRelease = `true`](#boolean-pointereventensurerelease--true)
    * [*Boolean* PointerEvent::ensureMove = `true`](#boolean-pointereventensuremove--true)
  * [event](#event)
* [Glossary](#glossary)

# **Class** Pointer

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#class-pointer)

Enables mouse and touch handling.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#class-pointer)

## *Boolean* Pointer::enabled = `true`

## [Signal](/Neft-io/neft/Signal-API.md#class-signal) Pointer::onEnabledChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointerenabled--true-signal-pointeronenabledchangeboolean-oldvalue)

## Hidden *Boolean* Pointer::draggable = `false`

## Hidden [Signal](/Neft-io/neft/Signal-API.md#class-signal) Pointer::onDraggableChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#hidden-boolean-pointerdraggable--false-hidden-signal-pointerondraggablechangeboolean-oldvalue)

## Hidden *Boolean* Pointer::dragActive = `false`

## Hidden [Signal](/Neft-io/neft/Signal-API.md#class-signal) Pointer::onDragActiveChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#hidden-boolean-pointerdragactive--false-hidden-signal-pointerondragactivechangeboolean-oldvalue)

##onClick
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Pointer::onClick(&#x2A;Item.Pointer.Event&#x2A; event)</code></dd><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/Renderer-Item.Pointer-API.md#class-pointerevent">Item.Pointer.Event</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#onclick)

## *Boolean* Pointer::pressed = `false`

Whether the pointer is currently pressed.

##onPressedChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Pointer::onPressedChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#onpressedchange)

## *Boolean* Pointer::hover = `false`

Whether the pointer is currently under the item.

##onHoverChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Pointer::onHoverChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#onhoverchange)

##**Class** Pointer.Event
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Pointer.Event : &#x2A;Device.PointerEvent&#x2A;</code></dd><dt>Extends</dt><dd><i>Device.PointerEvent</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#class-pointerevent)

### *Boolean* PointerEvent::stopPropagation = `false`

Enable this property to stop further event propagation.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventstoppropagation--false)

### *Boolean* PointerEvent::checkSiblings = `false`

By default first deepest captured item will propagate this event only by his parents.

Change this value to test previous siblings as well.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventchecksiblings--false)

### *Boolean* PointerEvent::ensureRelease = `true`

Define whether pressed item should get 'onRelease' signal even
if the pointer has been released outside of this item.

Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventensurerelease--true)

### *Boolean* PointerEvent::ensureMove = `true`

Define whether the pressed item should get 'onMove' signals even
if the pointer is outside of this item.

Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventensuremove--true)

##event
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Pointer.Event&#x2A; Pointer.event</code></dd><dt>Static property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Renderer-Item.Pointer-API.md#class-pointerevent">Item.Pointer.Event</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#event)

# Glossary

- [Item.Pointer](#class-pointer)
- [Item.Pointer.Event](#class-pointerevent)

