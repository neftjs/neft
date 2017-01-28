# Pointer

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

    'use strict'

    utils = require 'src/utils'
    signal = require 'src/signal'
    assert = require 'src/assert'

    NOP = ->

    module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class Pointer extends itemUtils.DeepObject
        @__name__ = 'Pointer'

        itemUtils.defineProperty
            constructor: ctor
            name: 'pointer'
            valueConstructor: Pointer

Enables mouse and touch handling.

        constructor: (ref) ->
            super ref
            @_enabled = true
            @_draggable = false
            @_dragActive = false
            @_pressed = false
            @_hover = false
            @_pressedInitialized = false
            @_hoverInitialized = false

            Object.preventExtensions @

## *Boolean* Pointer::enabled = `true`

## *Signal* Pointer::onEnabledChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: Pointer
            name: 'enabled'
            defaultValue: true
            namespace: 'pointer'
            parentConstructor: ctor
            implementation: Impl.setItemPointerEnabled
            developmentSetter: (val) ->
                assert.isBoolean val

## Hidden *Boolean* Pointer::draggable = `false`

## Hidden *Signal* Pointer::onDraggableChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: Pointer
            name: 'draggable'
            defaultValue: false
            namespace: 'pointer'
            parentConstructor: ctor
            implementation: Impl.setItemPointerDraggable
            developmentSetter: (val) ->
                assert.isBoolean val

## Hidden *Boolean* Pointer::dragActive = `false`

## Hidden *Signal* Pointer::onDragActiveChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: Pointer
            name: 'dragActive'
            defaultValue: false
            namespace: 'pointer'
            parentConstructor: ctor
            implementation: Impl.setItemPointerDragActive
            developmentSetter: (val) ->
                assert.isBoolean val

## *Signal* Pointer::onClick(*Item.Pointer.Event* event)

## *Signal* Pointer::onPress(*Item.Pointer.Event* event)

## *Signal* Pointer::onRelease(*Item.Pointer.Event* event)

## *Signal* Pointer::onEnter(*Item.Pointer.Event* event)

## *Signal* Pointer::onExit(*Item.Pointer.Event* event)

## *Signal* Pointer::onWheel(*Item.Pointer.Event* event)

## *Signal* Pointer::onMove(*Item.Pointer.Event* event)

        PRESS_SIGNALS =
            onClick: true
            onPress: true
            onRelease: true

        MOVE_SIGNALS =
            onEnter: true
            onExit: true
            onMove: true

        onLazySignalInitialized = (pointer, name) ->
            # automatically initialize pressed and hover properties
            # if required events will be listened
            if PRESS_SIGNALS[name] or MOVE_SIGNALS[name]
                initializePressed pointer
                if MOVE_SIGNALS[name]
                    initializeHover pointer
            Impl.attachItemSignal.call pointer, 'pointer', name # TODO: send here an item
            return

        @SIGNALS = Object.keys(PRESS_SIGNALS).concat(Object.keys(MOVE_SIGNALS)).concat [
            'onWheel'
            # 'onDragStart', 'onDragEnd',
            # 'onDragEnter', 'onDragExit', 'onDrop'
        ]

        for signalName in @SIGNALS
            signal.Emitter.createSignal @, signalName, onLazySignalInitialized

## *Boolean* Pointer::pressed = `false`

Whether the pointer is currently pressed.

## *Signal* Pointer::onPressedChange(*Boolean* oldValue)

        initializePressed = do ->
            onPress = (event) ->
                event.stopPropagation = false
                @pressed = true
            onRelease = ->
                @pressed = false

            (pointer) ->
                unless pointer._pressedInitialized
                    pointer._pressedInitialized = true
                    pointer.onPress onPress
                    pointer.onRelease onRelease
                return

        itemUtils.defineProperty
            constructor: Pointer
            name: 'pressed'
            defaultValue: false
            namespace: 'pointer'
            parentConstructor: ctor
            signalInitializer: initializePressed
            getter: (_super) -> ->
                initializePressed @
                _super.call @

## *Boolean* Pointer::hover = `false`

Whether the pointer is currently under the item.

## *Signal* Pointer::onHoverChange(*Boolean* oldValue)

        initializeHover = do ->
            onEnter = ->
                @hover = true
            onExit = ->
                @hover = false

            (pointer) ->
                unless pointer._hoverInitialized
                    pointer._hoverInitialized = true
                    pointer.onEnter onEnter
                    pointer.onExit onExit
                return

        itemUtils.defineProperty
            constructor: Pointer
            name: 'hover'
            defaultValue: false
            namespace: 'pointer'
            parentConstructor: ctor
            signalInitializer: initializeHover
            getter: (_super) -> ->
                initializeHover @
                _super.call @

## **Class** Pointer.Event : *Device.PointerEvent*

Events order:
 1. Press
 2. Enter
 3. Move
 4. Move (not captured ensured items)
 5. Exit
 6. Release
 7. Click
 8. Exit (entered items on touch devices)
 9. Release (not captured ensured items)

Stopped 'Enter' event will emit 'Move' event on this item.

Stopped 'Exit' event will emit 'Release' event on this item.

        @Event = class PointerEvent
            constructor: ->
                @_stopPropagation = true
                @_checkSiblings = false
                @_ensureRelease = true
                @_ensureMove = true
                @_preventClick = false
                Object.preventExtensions @

            @:: = Object.create Renderer.Device.pointer
            @::constructor = PointerEvent

### *Boolean* PointerEvent::stopPropagation = `false`

Enable this property to stop further event propagation.

This property is reset on each pointer press.

            utils.defineProperty @::, 'stopPropagation', null, ->
                @_stopPropagation
            , (val) ->
                assert.isBoolean val
                @_stopPropagation = val

### *Boolean* PointerEvent::checkSiblings = `false`

By default first deepest captured item will propagate this event only by his parents.

Change this value to test previous siblings as well.

This property is reset on each pointer press.

            utils.defineProperty @::, 'checkSiblings', null, ->
                @_checkSiblings
            , (val) ->
                assert.isBoolean val
                @_checkSiblings = val

### *Boolean* PointerEvent::ensureRelease = `true`

Define whether pressed item should get 'onRelease' signal even
if the pointer has been released outside of this item.

Can be changed only in the 'onPress' signal.

            utils.defineProperty @::, 'ensureRelease', null, ->
                @_ensureRelease
            , (val) ->
                assert.isBoolean val
                @_ensureRelease = val

### *Boolean* PointerEvent::ensureMove = `true`

Define whether the pressed item should get 'onMove' signals even
if the pointer is outside of this item.

Can be changed only in the 'onPress' signal.

            utils.defineProperty @::, 'ensureMove', null, ->
                @_ensureMove
            , (val) ->
                assert.isBoolean val
                @_ensureMove = val

### *Boolean* PointerEvent::preventClick = `false`

Set it to `true` to block emitting `click` signals.

This property is reset on each pointer press.

It's internally used by Scrollable element to block `clicks` after view has been scrolled.

            utils.defineProperty @::, 'preventClick', null, ->
                @_preventClick
            , (val) ->
                assert.isBoolean val
                @_preventClick = val

## *Item.Pointer.Event* Pointer.event

        @event = new PointerEvent
