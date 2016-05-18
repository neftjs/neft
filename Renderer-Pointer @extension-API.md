> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Pointer @extension**

Pointer @extension
==================

```nml
`Rectangle {
`   width: 100
`   height: 100
`   color: 'green'
`
`   Class {
`       when: target.pointer.hover
`       changes: {
`           color: 'red'
`       }
`   }
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#pointer-extension)

## Table of contents
  * [Pointer()](#pointer-pointer)
  * [enabled = true](#boolean-pointerenabled--true)
  * [Hidden draggable = false](#hidden-boolean-pointerdraggable--false)
  * [Hidden dragActive = false](#hidden-boolean-pointerdragactive--false)
  * [onClick(event)](#signal-pointeronclickpointerevent-event)
  * [pressed = false](#boolean-pointerpressed--false)
  * [onPressedChange(oldValue)](#signal-pointeronpressedchangeboolean-oldvalue)
  * [hover = false](#boolean-pointerhover--false)
  * [onHoverChange(oldValue)](#signal-pointeronhoverchangeboolean-oldvalue)
  * [PointerEvent() : *DevicePointerEvent*](#pointerevent-pointerevent--devicepointerevent)
  * [stopPropagation = false](#boolean-pointereventstoppropagation--false)
  * [checkSiblings = false](#boolean-pointereventchecksiblings--false)
  * [ensureRelease = true](#boolean-pointereventensurerelease--true)
  * [ensureMove = true](#boolean-pointereventensuremove--true)
  * [Pointer.event](#pointerevent-pointerevent)

*Pointer* Pointer()
-------------------

Enables mouse and touch handling.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#pointer-pointer)

*Boolean* Pointer::enabled = true
---------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onEnabledChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointerenabled--true-signal-pointeronenabledchangeboolean-oldvalue)

Hidden *Boolean* Pointer::draggable = false
-------------------------------------------
## Hidden [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onDraggableChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#hidden-boolean-pointerdraggable--false-hidden-signal-pointerondraggablechangeboolean-oldvalue)

Hidden *Boolean* Pointer::dragActive = false
--------------------------------------------
## Hidden [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onDragActiveChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#hidden-boolean-pointerdragactive--false-hidden-signal-pointerondragactivechangeboolean-oldvalue)

[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onClick(*PointerEvent* event)
-----------------------------------------------
[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onPress(*PointerEvent* event)
-----------------------------------------------
[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onRelease(*PointerEvent* event)
-------------------------------------------------
[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onEnter(*PointerEvent* event)
-----------------------------------------------
[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onExit(*PointerEvent* event)
----------------------------------------------
[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onWheel(*PointerEvent* event)
-----------------------------------------------
[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onMove(*PointerEvent* event)
----------------------------------------------
Hidden [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onDragStart()
--------------------------------------
Hidden [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onDragEnd()
------------------------------------
Hidden [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onDragEnter()
--------------------------------------
Hidden [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onDragExit()
-------------------------------------
Hidden [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onDrop()
---------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronclickpointerevent-eventsignal-pointeronpresspointerevent-eventsignal-pointeronreleasepointerevent-eventsignal-pointeronenterpointerevent-eventsignal-pointeronexitpointerevent-eventsignal-pointeronwheelpointerevent-eventsignal-pointeronmovepointerevent-eventhidden-signal-pointerondragstarthidden-signal-pointerondragendhidden-signal-pointerondragenterhidden-signal-pointerondragexithidden-signal-pointerondrop)

*Boolean* Pointer::pressed = false
----------------------------------

Whether the pointer is currently pressed.

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onPressedChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronpressedchangeboolean-oldvalue)

*Boolean* Pointer::hover = false
--------------------------------

Whether the pointer is currently under the item.

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Pointer::onHoverChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronhoverchangeboolean-oldvalue)

*PointerEvent* PointerEvent() : *DevicePointerEvent*
----------------------------------------------------

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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#pointerevent-pointerevent--devicepointerevent)

*Boolean* PointerEvent::stopPropagation = false
-----------------------------------------------

Enable this property to stop further event propagation.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventstoppropagation--false)

*Boolean* PointerEvent::checkSiblings = false
---------------------------------------------

By default first deepest captured item will propagate this event only by his parents.
Change this value to test previous siblings as well.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventchecksiblings--false)

*Boolean* PointerEvent::ensureRelease = true
--------------------------------------------

Define whether pressed item should get 'onRelease' signal even
if the pointer has been released outside of this item.
Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventensurerelease--true)

*Boolean* PointerEvent::ensureMove = true
-----------------------------------------

Define whether the pressed item should get 'onMove' signals even
if the pointer is outside of this item.
Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventensuremove--true)

*PointerEvent* Pointer.event
----------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#pointerevent-pointerevent)

