# Keys

```javascript
Rectangle {
    width: 100
    height: 100
    color: 'green'
    keys.focus: true
    keys.onPressed: function(){
        this.color = 'red';
    }
    keys.onReleased: function(){
        this.color = 'green';
    }
}
```

    'use strict'

    utils = require '../../../../util'
    signal = require '../../../../signal'
    assert = require '../../../../assert'

    module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class Keys extends itemUtils.DeepObject
        @__name__ = 'Keys'

        {Device} = Renderer

        itemUtils.defineProperty
            constructor: ctor
            name: 'keys'
            valueConstructor: Keys

## *Item* Keys.focusedItem

        @focusedItem = null

## **Class** Keys.Event : *Device.KeyboardEvent*

        @Event = class KeysEvent
            constructor: ->
                Object.preventExtensions @

            @:: = Object.create Device.keyboard
            @::constructor = KeysEvent

        constructor: (ref) ->
            super ref
            @_focus = false
            Object.preventExtensions @

## *Signal* Keys::onPress(*Item.Keys.Event* event)

## *Signal* Keys::onHold(*Item.Keys.Event* event)

## *Signal* Keys::onRelease(*Item.Keys.Event* event)

## *Signal* Keys::onInput(*Item.Keys.Event* event)

        @SIGNALS = ['onPress', 'onHold', 'onRelease', 'onInput']

        for signalName in @SIGNALS
            signal.Emitter.createSignal @, signalName

## *Boolean* Keys::focus = `false`

## *Signal* Keys::onFocusChange(*Boolean* oldValue)

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

        Device.onKeyPress (event) ->
            focusedKeys?.onPress.emit keysEvent

        Device.onKeyHold (event) ->
            focusedKeys?.onHold.emit keysEvent

        Device.onKeyRelease (event) ->
            focusedKeys?.onRelease.emit keysEvent

        Device.onKeyInput (event) ->
            focusedKeys?.onInput.emit keysEvent

## *Item.Keys.Event* Keys.event

        @event = keysEvent = new KeysEvent
