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

*Pointer* Pointer()
-------------------

Enables mouse and touch handling.

*Boolean* Pointer::enabled = true
---------------------------------

## *Signal* Pointer::onEnabledChange(*Boolean* oldValue)

Hidden *Boolean* Pointer::draggable = false
-------------------------------------------

## Hidden *Signal* Pointer::onDraggableChange(*Boolean* oldValue)

Hidden *Boolean* Pointer::dragActive = false
--------------------------------------------

## Hidden *Signal* Pointer::onDragActiveChange(*Boolean* oldValue)

*Signal* Pointer::onClick(*PointerEvent* event)
-----------------------------------------------

*Signal* Pointer::onPress(*PointerEvent* event)
-----------------------------------------------

*Signal* Pointer::onRelease(*PointerEvent* event)
-------------------------------------------------

*Signal* Pointer::onEnter(*PointerEvent* event)
-----------------------------------------------

*Signal* Pointer::onExit(*PointerEvent* event)
----------------------------------------------

*Signal* Pointer::onWheel(*PointerEvent* event)
-----------------------------------------------

*Signal* Pointer::onMove(*PointerEvent* event)
----------------------------------------------

Hidden *Signal* Pointer::onDragStart()
--------------------------------------

Hidden *Signal* Pointer::onDragEnd()
------------------------------------

Hidden *Signal* Pointer::onDragEnter()
--------------------------------------

Hidden *Signal* Pointer::onDragExit()
-------------------------------------

Hidden *Signal* Pointer::onDrop()
---------------------------------

*Boolean* Pointer::pressed = false
----------------------------------

Whether the pointer is currently pressed.

## *Signal* Pointer::onPressedChange(*Boolean* oldValue)

*Boolean* Pointer::hover = false
--------------------------------

Whether the pointer is currently under the item.

## *Signal* Pointer::onHoverChange(*Boolean* oldValue)

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

*Boolean* PointerEvent::stopPropagation = false
-----------------------------------------------

Enable this property to stop further event propagation.

*Boolean* PointerEvent::checkSiblings = false
---------------------------------------------

By default first deepest captured item will propagate this event only by his parents.

Change this value to test previous siblings as well.

*Boolean* PointerEvent::ensureRelease = true
--------------------------------------------

Define whether pressed item should get 'onRelease' signal even
if the pointer has been released outside of this item.

Can be changed only in the 'onPress' signal.

*Boolean* PointerEvent::ensureMove = true
-----------------------------------------

Define whether the pressed item should get 'onMove' signals even
if the pointer is outside of this item.

Can be changed only in the 'onPress' signal.

*PointerEvent* Pointer.event
----------------------------

