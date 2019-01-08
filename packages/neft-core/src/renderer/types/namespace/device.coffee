'use strict'

utils = require '../../../util'
{SignalsEmitter} = require '../../../signal'

module.exports = (Renderer, Impl, itemUtils) ->
    class Device extends SignalsEmitter
        constructor: ->
            super()
            @_platform = 'Unix'
            @_desktop = true
            @_phone = false
            @_pixelRatio = 1
            @_pointer = new DevicePointerEvent
            @_keyboard = new DeviceKeyboardEvent

            Object.preventExtensions @

        utils.defineProperty @::, 'platform', null, ->
            @_platform
        , null

        utils.defineProperty @::, 'desktop', null, ->
            @_desktop
        , null

        utils.defineProperty @::, 'tablet', null, ->
            not @desktop and not @phone
        , null

        utils.defineProperty @::, 'phone', null, ->
            @_phone
        , null

        utils.defineProperty @::, 'mobile', null, ->
            @tablet or @phone
        , null

        utils.defineProperty @::, 'pixelRatio', null, ->
            @_pixelRatio
        , null

        log: (msgs...) ->
            Impl.logDevice msgs.join(' ')

        utils.defineProperty Device::, 'pointer', null, ->
            @_pointer
        , null

        SignalsEmitter.createSignal @, 'onPointerPress'

        SignalsEmitter.createSignal @, 'onPointerRelease'

        SignalsEmitter.createSignal @, 'onPointerMove'

        SignalsEmitter.createSignal @, 'onPointerWheel'

        utils.defineProperty Device::, 'keyboard', null, ->
            @_keyboard
        , null

        SignalsEmitter.createSignal @, 'onKeyPress'

        SignalsEmitter.createSignal @, 'onKeyHold'

        SignalsEmitter.createSignal @, 'onKeyRelease'

        SignalsEmitter.createSignal @, 'onKeyInput'

    class DevicePointerEvent extends SignalsEmitter
        constructor: ->
            super()

            @_x = 0
            @_y = 0
            @_movementX = 0
            @_movementY = 0
            @_deltaX = 0
            @_deltaY = 0

            Object.preventExtensions @

        itemUtils.defineProperty
            constructor: @
            name: 'x'
            defaultValue: 0

        itemUtils.defineProperty
            constructor: @
            name: 'y'
            defaultValue: 0

        itemUtils.defineProperty
            constructor: @
            name: 'movementX'
            defaultValue: 0

        itemUtils.defineProperty
            constructor: @
            name: 'movementY'
            defaultValue: 0

        itemUtils.defineProperty
            constructor: @
            name: 'deltaX'
            defaultValue: 0

        itemUtils.defineProperty
            constructor: @
            name: 'deltaY'
            defaultValue: 0

    class DeviceKeyboardEvent extends SignalsEmitter
        constructor: ->
            super()

            @_visible = false
            @_height = 0
            @_key = ''
            @_text = ''

            Object.preventExtensions @

        itemUtils.defineProperty
            constructor: @
            name: 'visible'
            defaultValue: false

        itemUtils.defineProperty
            constructor: @
            name: 'height'
            defaultValue: 0

        itemUtils.defineProperty
            constructor: @
            name: 'key'
            defaultValue: ''

        itemUtils.defineProperty
            constructor: @
            name: 'text'
            defaultValue: ''

        show: ->
            Impl.showDeviceKeyboard.call device

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

        device.onPointerPress.connect updateMovement
        device.onPointerRelease.connect updateMovement
        device.onPointerMove.connect updateMovement

    # initialize by the implementation
    Impl.initDeviceNamespace.call device
    device
