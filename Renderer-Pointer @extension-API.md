> [Wiki](Home) ▸ [API Reference](API-Reference)

Pointer
<dl></dl>
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
<dl><dt>Returns</dt><dd><i>Pointer</i></dd></dl>
Enables mouse and touch handling.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#pointer-pointer)

enabled
<dl><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointerenabled--true-signal-pointeronenabledchangeboolean-oldvalue)

draggable
<dl><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#hidden-boolean-pointerdraggable--false-hidden-signal-pointerondraggablechangeboolean-oldvalue)

dragActive
<dl><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#hidden-boolean-pointerdragactive--false-hidden-signal-pointerondragactivechangeboolean-oldvalue)

onClick
<dl><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>PointerEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronclickpointerevent-eventsignal-pointeronpresspointerevent-eventsignal-pointeronreleasepointerevent-eventsignal-pointeronenterpointerevent-eventsignal-pointeronexitpointerevent-eventsignal-pointeronwheelpointerevent-eventsignal-pointeronmovepointerevent-eventhidden-signal-pointerondragstarthidden-signal-pointerondragendhidden-signal-pointerondragenterhidden-signal-pointerondragexithidden-signal-pointerondrop)

pressed
<dl><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
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
<dl><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronpressedchangeboolean-oldvalue)

hover
<dl><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Whether the pointer is currently under the item.

##onHoverChange
<dl><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#signal-pointeronhoverchangeboolean-oldvalue)

PointerEvent
<dl><dt>Extends</dt><dd><i>DevicePointerEvent</i></dd><dt>Returns</dt><dd><i>PointerEvent</i></dd></dl>
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
<dl><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Enable this property to stop further event propagation.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventstoppropagation--false)

checkSiblings
<dl><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
By default first deepest captured item will propagate this event only by his parents.
Change this value to test previous siblings as well.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventchecksiblings--false)

ensureRelease
<dl><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
Define whether pressed item should get 'onRelease' signal even
if the pointer has been released outside of this item.
Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventensurerelease--true)

ensureMove
<dl><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
Define whether the pressed item should get 'onMove' signals even
if the pointer is outside of this item.
Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#boolean-pointereventensuremove--true)

event
<dl><dt>Static property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>PointerEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/pointer.litcoffee#pointerevent-pointerevent)

