> [Wiki](Home) ▸ [API Reference](API-Reference)

Pointer
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

Pointer
Enables mouse and touch handling.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#pointer-pointer)

enabled
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointerenabled--true-signal-pointeronenabledchangeboolean-oldvalue)

draggable
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#hidden-boolean-pointerdraggable--false-hidden-signal-pointerondraggablechangeboolean-oldvalue)

dragActive
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#hidden-boolean-pointerdragactive--false-hidden-signal-pointerondragactivechangeboolean-oldvalue)

onClick
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronclickpointerevent-eventsignal-pointeronpresspointerevent-eventsignal-pointeronreleasepointerevent-eventsignal-pointeronenterpointerevent-eventsignal-pointeronexitpointerevent-eventsignal-pointeronwheelpointerevent-eventsignal-pointeronmovepointerevent-eventhidden-signal-pointerondragstarthidden-signal-pointerondragendhidden-signal-pointerondragenterhidden-signal-pointerondragexithidden-signal-pointerondrop)

pressed
Whether the pointer is currently pressed.

## Table of contents
    * [Pointer](#pointer)
    * [Pointer](#pointer)
    * [enabled](#enabled)
    * [draggable](#draggable)
    * [dragActive](#dragactive)
    * [onClick](#onclick)
    * [pressed](#pressed)
  * [onPressedChange](#onpressedchange)
    * [hover](#hover)
  * [onHoverChange](#onhoverchange)
    * [PointerEvent](#pointerevent)
    * [stopPropagation](#stoppropagation)
    * [checkSiblings](#checksiblings)
    * [ensureRelease](#ensurerelease)
    * [ensureMove](#ensuremove)
    * [event](#event)

##onPressedChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronpressedchangeboolean-oldvalue)

hover
Whether the pointer is currently under the item.

##onHoverChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronhoverchangeboolean-oldvalue)

PointerEvent
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

stopPropagation
Enable this property to stop further event propagation.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventstoppropagation--false)

checkSiblings
By default first deepest captured item will propagate this event only by his parents.
Change this value to test previous siblings as well.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventchecksiblings--false)

ensureRelease
Define whether pressed item should get 'onRelease' signal even
if the pointer has been released outside of this item.
Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventensurerelease--true)

ensureMove
Define whether the pressed item should get 'onMove' signals even
if the pointer is outside of this item.
Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventensuremove--true)

event
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#pointerevent-pointerevent)

