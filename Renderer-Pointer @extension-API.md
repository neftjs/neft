> [Wiki](Home) ▸ [[API Reference|API-Reference]]

Pointer
<dl><dt>Syntax</dt><dd><code>Pointer @extension</code></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#pointer)

Pointer
<dl><dt>Syntax</dt><dd><code>&#x2A;Pointer&#x2A; Pointer()</code></dd><dt>Returns</dt><dd><i>Pointer</i></dd></dl>
Enables mouse and touch handling.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#pointer)

enabled
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Pointer::enabled = true</code></dd><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#enabled)

draggable
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Boolean&#x2A; Pointer::draggable = false</code></dd><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#draggable)

dragActive
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Boolean&#x2A; Pointer::dragActive = false</code></dd><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#dragactive)

onClick
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Pointer::onClick(&#x2A;PointerEvent&#x2A; event)</code></dd><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>PointerEvent</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#onclick)

pressed
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Pointer::pressed = false</code></dd><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Whether the pointer is currently pressed.

##onPressedChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Pointer::onPressedChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#onpressedchange)

hover
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Pointer::hover = false</code></dd><dt>Prototype property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Whether the pointer is currently under the item.

##onHoverChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Pointer::onHoverChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Pointer</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#onhoverchange)

PointerEvent
<dl><dt>Syntax</dt><dd><code>&#x2A;PointerEvent&#x2A; PointerEvent() : &#x2A;DevicePointerEvent&#x2A;</code></dd><dt>Extends</dt><dd><i>DevicePointerEvent</i></dd><dt>Returns</dt><dd><i>PointerEvent</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#pointerevent)

stopPropagation
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PointerEvent::stopPropagation = false</code></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
Enable this property to stop further event propagation.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#stoppropagation)

checkSiblings
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PointerEvent::checkSiblings = false</code></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
By default first deepest captured item will propagate this event only by his parents.

Change this value to test previous siblings as well.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#checksiblings)

ensureRelease
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PointerEvent::ensureRelease = true</code></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
Define whether pressed item should get 'onRelease' signal even
if the pointer has been released outside of this item.

Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#ensurerelease)

ensureMove
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PointerEvent::ensureMove = true</code></dd><dt>Prototype property of</dt><dd><i>PointerEvent</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
Define whether the pressed item should get 'onMove' signals even
if the pointer is outside of this item.

Can be changed only in the 'onPress' signal.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#ensuremove)

event
<dl><dt>Syntax</dt><dd><code>&#x2A;PointerEvent&#x2A; Pointer.event</code></dd><dt>Static property of</dt><dd><i>Pointer</i></dd><dt>Type</dt><dd><i>PointerEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/pointer.litcoffee#event)

