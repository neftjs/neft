# Device

    'use strict'

    utils = require 'src/utils'
    signal = require 'src/signal'

    module.exports = (Renderer, Impl, itemUtils) ->
        class Device extends signal.Emitter
            constructor: ->
                super()
                @_platform = 'Unix'
                @_desktop = true
                @_phone = false
                @_pixelRatio = 1
                @_pointer = new DevicePointerEvent
                @_keyboard = new DeviceKeyboardEvent

                Object.preventExtensions @

## *Boolean* Device.platform = `'Unix'`

Possible values are:
 - Android,
 - iOS,
 - BlackBerry,
 - WindowsCE,
 - WindowsRT,
 - WindowsPhone,
 - Linux,
 - Windows,
 - Unix,
 - OSX.

```javascript
Text {
    text: 'You are using: ' + Device.platform
    font.pixelSize: 30
}
```

            utils.defineProperty @::, 'platform', null, ->
                @_platform
            , null

## *Boolean* Device.desktop = `true`

            utils.defineProperty @::, 'desktop', null, ->
                @_desktop
            , null

## *Boolean* Device.tablet = `false`

            utils.defineProperty @::, 'tablet', null, ->
                not @desktop and not @phone
            , null

## *Boolean* Device.phone = `false`

            utils.defineProperty @::, 'phone', null, ->
                @_phone
            , null

## *Boolean* Device.mobile = `false`

Tablet or a phone.

```javascript
Text {
    text: Device.mobile ? 'Mobile' : 'Desktop'
    font.pixelSize: 30
}
```

            utils.defineProperty @::, 'mobile', null, ->
                @tablet or @phone
            , null

## *Boolean* Device.pixelRatio = `1`

```javascript
Text {
    text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
    font.pixelSize: 30
}
```

            utils.defineProperty @::, 'pixelRatio', null, ->
                @_pixelRatio
            , null

## ReadOnly *Device.PointerEvent* Device.pointer

            utils.defineProperty Device::, 'pointer', null, ->
                @_pointer
            , null

## *Signal* Device.onPointerPress(*Device.PointerEvent* event)

            signal.Emitter.createSignal @, 'onPointerPress'

## *Signal* Device.onPointerRelease(*Device.PointerEvent* event)

            signal.Emitter.createSignal @, 'onPointerRelease'

## *Signal* Device.onPointerMove(*Device.PointerEvent* event)

            signal.Emitter.createSignal @, 'onPointerMove'

## *Signal* Device.onPointerWheel(*Device.PointerEvent* event)

            signal.Emitter.createSignal @, 'onPointerWheel'

## ReadOnly *Device.KeyboardEvent* Device.keyboard

            utils.defineProperty Device::, 'keyboard', null, ->
                @_keyboard
            , null

## *Signal* Device.onKeyPress(*Device.KeyboardEvent* event)

            signal.Emitter.createSignal @, 'onKeyPress'

## *Signal* Device.onKeyHold(*Device.KeyboardEvent* event)

            signal.Emitter.createSignal @, 'onKeyHold'

## *Signal* Device.onKeyRelease(*Device.KeyboardEvent* event)

            signal.Emitter.createSignal @, 'onKeyRelease'

## *Signal* Device.onKeyInput(*Device.KeyboardEvent* event)

            signal.Emitter.createSignal @, 'onKeyInput'

# **Class** Device.PointerEvent

        class DevicePointerEvent extends signal.Emitter
            constructor: ->
                super()

                @_x = 0
                @_y = 0
                @_movementX = 0
                @_movementY = 0
                @_deltaX = 0
                @_deltaY = 0

                Object.preventExtensions @

## ReadOnly *Float* Device.PointerEvent::x

## *Signal* Device.PointerEvent::onXChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'x'
                defaultValue: 0

## ReadOnly *Float* Device.PointerEvent::y

## *Signal* Device.PointerEvent::onYChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'y'
                defaultValue: 0

## ReadOnly *Float* Device.PointerEvent::movementX

## *Signal* Device.PointerEvent::onMovementXChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'movementX'
                defaultValue: 0

## ReadOnly *Float* Device.PointerEvent::movementY

## *Signal* Device.PointerEvent::onMovementYChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'movementY'
                defaultValue: 0

## ReadOnly *Float* Device.PointerEvent::deltaX

## *Signal* Device.PointerEvent::onDeltaXChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'deltaX'
                defaultValue: 0

## ReadOnly *Float* Device.PointerEvent::deltaY

## *Signal* Device.PointerEvent::onDeltaYChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'deltaY'
                defaultValue: 0

# **Class** Device.KeyboardEvent()

        class DeviceKeyboardEvent extends signal.Emitter
            constructor: ->
                super()

                @_visible = false
                @_key = ''
                @_text = ''

                Object.preventExtensions @

## ReadOnly *Boolean* Device.KeyboardEvent::visible

## *Signal* Device.KeyboardEvent::onVisibleChange(*Boolean* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'visible'
                defaultValue: false

## ReadOnly *String* Device.KeyboardEvent::key

## *Signal* Device.KeyboardEvent::onKeyChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'key'
                defaultValue: ''

## ReadOnly *String* Device.KeyboardEvent::text

## *Signal* Device.KeyboardEvent::onTextChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'text'
                defaultValue: ''

## Device.KeyboardEvent::show()

            show: ->
                Impl.showDeviceKeyboard.call device

## Device.KeyboardEvent::hide()

            hide: ->
                Impl.hideDeviceKeyboard.call device

        # create new instance
        device = new Device

        # support pointer movement
        do ->
            x = y = 0
            updateMovement = (event) ->
                event.movementX = event.x - x
                event.movementY = event.y - y
                x = event.x
                y = event.y
                return

            device.onPointerPress updateMovement
            device.onPointerRelease updateMovement
            device.onPointerMove updateMovement

        # initialize by the implementation
        Impl.initDeviceNamespace.call device
        device

# Glossary

- [Device](#device)
- [Device.PointerEvent](#class-devicepointerevent)
- [Device.KeyboardEvent](#class-devicekeyboardevent)
