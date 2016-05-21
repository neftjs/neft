> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
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

<dl><dt>Returns</dt><dd><i>Pointer</i></dd></dl>
Pointer
Enables mouse and touch handling.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#pointer-pointer)

<dl><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
enabled
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointerenabled--true-signal-pointeronenabledchangeboolean-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>hidden</dt></dl>
draggable
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#hidden-boolean-pointerdraggable--false-hidden-signal-pointerondraggablechangeboolean-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>hidden</dt></dl>
dragActive
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#hidden-boolean-pointerdragactive--false-hidden-signal-pointerondragactivechangeboolean-oldvalue)

<dl><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li><b>event</b> — <i>PointerEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onClick
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronclickpointerevent-eventsignal-pointeronpresspointerevent-eventsignal-pointeronreleasepointerevent-eventsignal-pointeronenterpointerevent-eventsignal-pointeronexitpointerevent-eventsignal-pointeronwheelpointerevent-eventsignal-pointeronmovepointerevent-eventhidden-signal-pointerondragstarthidden-signal-pointerondragendhidden-signal-pointerondragenterhidden-signal-pointerondragexithidden-signal-pointerondrop)

<dl><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
pressed
Whether the pointer is currently pressed.

<dl><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
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
  * [*Boolean* PointerEvent::checkSiblings = false](#boolean-pointereventchecksiblings--false)
  * [*Boolean* PointerEvent::ensureRelease = true](#boolean-pointereventensurerelease--true)
  * [*Boolean* PointerEvent::ensureMove = true](#boolean-pointereventensuremove--true)
  * [*PointerEvent* Pointer.event](#pointerevent-pointerevent)

##onPressedChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronpressedchangeboolean-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
hover
Whether the pointer is currently under the item.

<dl><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
##onHoverChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronhoverchangeboolean-oldvalue)

<dl><dt>Extends</dt><dd><i>DevicePointerEvent</i></dd><dt>Returns</dt><dd><i>PointerEvent</i></dd></dl>
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

<dl><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
stopPropagation
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

