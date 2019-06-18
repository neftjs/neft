'use strict'

utils = require '../../../../util'
{SignalsEmitter} = require '../../../../signal'
assert = require '../../../../assert'

module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class Keys extends itemUtils.DeepObject
    @__name__ = 'Keys'

    {Device} = Renderer

    itemUtils.defineProperty
        constructor: ctor
        name: 'keys'
        valueConstructor: Keys

    @focusedItem = null

    @Event = class KeysEvent
        constructor: ->
            Object.preventExtensions @

        @:: = Object.create Device.keyboard
        @::constructor = KeysEvent

    constructor: (ref) ->
        super ref
        @_focus = false
        Object.preventExtensions @

    @SIGNALS = ['onPress', 'onHold', 'onRelease', 'onInput']

    for signalName in @SIGNALS
        SignalsEmitter.createSignal @, signalName

    focusedKeys = null

    itemUtils.defineProperty
        constructor: Keys
        name: 'focus'
        defaultValue: false
        implementation: Impl.setItemKeysFocus
        namespace: 'keys'
        parentConstructor: ctor
        developmentSetter: (val) ->
            assert.isBoolean val
        setter: (_super) -> (val) ->
            if @_focus isnt val
                if val and focusedKeys isnt @
                    focusedKeys?.focus = false
                    focusedKeys = @
                    Keys.focusedItem = @_ref
                _super.call @, val
                if not val and focusedKeys is @
                    focusedKeys = null
                    Keys.focusedItem = null
            return

    Device.onKeyPress.connect (event) ->
        focusedKeys?.emit 'onPress', keysEvent

    Device.onKeyHold.connect (event) ->
        focusedKeys?.emit 'onHold', keysEvent

    Device.onKeyRelease.connect (event) ->
        focusedKeys?.emit 'onRelease', keysEvent

    Device.onKeyInput.connect (event) ->
        focusedKeys?.emit 'onInput', keysEvent

    @event = keysEvent = new KeysEvent
