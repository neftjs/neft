> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **Pointer**

#Pointer
<dl><dt>Syntax</dt><dd><code>Item.Pointer</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
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
  * [enabled](#enabled)
  * [draggable](#draggable)
  * [dragActive](#dragactive)
  * [onClick](#onclick)
  * [pressed](#pressed)
  * [onPressedChange](#onpressedchange)
  * [hover](#hover)
  * [onHoverChange](#onhoverchange)
  * [**Class** Pointer.Event](#class-pointerevent)
    * [stopPropagation](#stoppropagation)
    * [checkSiblings](#checksiblings)
    * [ensureRelease](#ensurerelease)
    * [ensureMove](#ensuremove)
  * [event](#event)
* [Glossary](#glossary)

# **Class** Pointer

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#class-pointer)

Enables mouse and touch handling.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#class-pointer)

##enabled
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Pointer::enabled = `true`</code></dd><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#enabled)

##draggable
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Boolean&#x2A; Pointer::draggable = `false`</code></dd><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#draggable)

##dragActive
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Boolean&#x2A; Pointer::dragActive = `false`</code></dd><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#dragactive)

##onClick
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Pointer::onClick(&#x2A;Item.Pointer.Event&#x2A; event)</code></dd><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Item.Pointer-API#class-pointerevent">Item.Pointer.Event</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#onclick)

##pressed
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Pointer::pressed = `false`</code></dd><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Whether the pointer is currently pressed.

##onPressedChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Pointer::onPressedChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#onpressedchange)

##hover
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Pointer::hover = `false`</code></dd><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Whether the pointer is currently under the item.

##onHoverChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Pointer::onHoverChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#onhoverchange)

##**Class** Pointer.Event
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Pointer.Event : &#x2A;Device.PointerEvent&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicepointerevent">Device.PointerEvent</a></dd></dl>
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

###stopPropagation
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PointerEvent::stopPropagation = `false`</code></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Enable this property to stop further event propagation.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#stoppropagation)

###checkSiblings
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PointerEvent::checkSiblings = `false`</code></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
By default first deepest captured item will propagate this event only by his parents.

Change this value to test previous siblings as well.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#checksiblings)

###ensureRelease
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PointerEvent::ensureRelease = `true`</code></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
Define whether pressed item should get 'onRelease' signal even
if the pointer has been released outside of this item.

Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#ensurerelease)

###ensureMove
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PointerEvent::ensureMove = `true`</code></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
Define whether the pressed item should get 'onMove' signals even
if the pointer is outside of this item.

Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#ensuremove)

##event
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Pointer.Event&#x2A; Pointer.event</code></dd><dt>Static property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Pointer-API#class-pointerevent">Item.Pointer.Event</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/pointer.litcoffee#event)

# Glossary

- [Item.Pointer](#class-pointer)
- [Item.Pointer.Event](#class-pointerevent)

