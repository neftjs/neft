'use strict'

utils = require '../../../../util'
{SignalsEmitter} = require '../../../../signal'
assert = require '../../../../assert'

NOP = ->

module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class Pointer extends itemUtils.DeepObject
    @__name__ = 'Pointer'

    itemUtils.defineProperty
        constructor: ctor
        name: 'pointer'
        valueConstructor: Pointer

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

    itemUtils.defineProperty
        constructor: Pointer
        name: 'enabled'
        defaultValue: true
        namespace: 'pointer'
        parentConstructor: ctor
        implementation: Impl.setItemPointerEnabled
        developmentSetter: (val) ->
            assert.isBoolean val

    # itemUtils.defineProperty
    #     constructor: Pointer
    #     name: 'draggable'
    #     defaultValue: false
    #     namespace: 'pointer'
    #     parentConstructor: ctor
    #     implementation: Impl.setItemPointerDraggable
    #     developmentSetter: (val) ->
    #         assert.isBoolean val

    # itemUtils.defineProperty
    #     constructor: Pointer
    #     name: 'dragActive'
    #     defaultValue: false
    #     namespace: 'pointer'
    #     parentConstructor: ctor
    #     implementation: Impl.setItemPointerDragActive
    #     developmentSetter: (val) ->
    #         assert.isBoolean val

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
        SignalsEmitter.createSignal @, signalName, onLazySignalInitialized

    initializePressed = do ->
        onPress = (event) ->
            event.stopPropagation = false
            @pressed = true
        onRelease = ->
            @pressed = false

        (pointer) ->
            unless pointer._pressedInitialized
                pointer._pressedInitialized = true
                pointer.onPress.connect onPress
                pointer.onRelease.connect onRelease
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

    initializeHover = do ->
        onEnter = ->
            @hover = true
        onExit = ->
            @hover = false

        (pointer) ->
            unless pointer._hoverInitialized
                pointer._hoverInitialized = true
                pointer.onEnter.connect onEnter
                pointer.onExit.connect onExit
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

    @Event = class PointerEvent
        constructor: ->
            @_itemX = 0
            @_itemY = 0
            @_stopPropagation = true
            @_checkSiblings = false
            @_ensureRelease = true
            @_ensureMove = true
            @_preventClick = false
            Object.preventExtensions @

        @:: = Object.create Renderer.Device.pointer
        @::constructor = PointerEvent

        utils.defineProperty @::, 'itemX', null, (-> @_itemX), null

        utils.defineProperty @::, 'itemY', null, (-> @_itemY), null

        utils.defineProperty @::, 'stopPropagation', null, ->
            @_stopPropagation
        , (val) ->
            assert.isBoolean val
            @_stopPropagation = val

        utils.defineProperty @::, 'checkSiblings', null, ->
            @_checkSiblings
        , (val) ->
            assert.isBoolean val
            @_checkSiblings = val

        utils.defineProperty @::, 'ensureRelease', null, ->
            @_ensureRelease
        , (val) ->
            assert.isBoolean val
            @_ensureRelease = val

        utils.defineProperty @::, 'ensureMove', null, ->
            @_ensureMove
        , (val) ->
            assert.isBoolean val
            @_ensureMove = val

        utils.defineProperty @::, 'preventClick', null, ->
            @_preventClick
        , (val) ->
            assert.isBoolean val
            @_preventClick = val

    @event = new PointerEvent
