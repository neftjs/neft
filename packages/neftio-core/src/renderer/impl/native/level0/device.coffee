'use strict'

utils = require '../../../../util'

module.exports = (impl) ->
    {bridge} = impl
    {outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

    device = pointer = keyboard = null

    bridge.listen bridge.inActions.DEVICE_PIXEL_RATIO, (reader) ->
        device._pixelRatio = reader.getFloat()
        return

    bridge.listen bridge.inActions.DEVICE_IS_PHONE, (reader) ->
        device._phone = reader.getBoolean()
        return

    ###
    Pointer
    ###
    bridge.listen bridge.inActions.POINTER_PRESS, (reader) ->
        pointer.x = reader.getFloat()
        pointer.y = reader.getFloat()
        device.emit 'onPointerPress', pointer
        return

    bridge.listen bridge.inActions.POINTER_RELEASE, (reader) ->
        pointer.x = reader.getFloat()
        pointer.y = reader.getFloat()
        device.emit 'onPointerRelease', pointer
        return

    bridge.listen bridge.inActions.POINTER_MOVE, (reader) ->
        pointer.x = reader.getFloat()
        pointer.y = reader.getFloat()
        device.emit 'onPointerMove', pointer
        return

    ###
    Keyboard
    ###
    bridge.listen bridge.inActions.DEVICE_KEYBOARD_SHOW, (reader) ->
        keyboard.visible = true
        return

    bridge.listen bridge.inActions.DEVICE_KEYBOARD_HIDE, (reader) ->
        keyboard.visible = false
        return

    bridge.listen bridge.inActions.DEVICE_KEYBOARD_HEIGHT, (reader) ->
        keyboard.height = reader.getFloat()
        return

    bridge.listen bridge.inActions.KEY_PRESS, (reader) ->
        keyboard.key = reader.getString()
        keyboard.text = ''
        device.emit 'onKeyPress', keyboard
        return

    bridge.listen bridge.inActions.KEY_HOLD, (reader) ->
        keyboard.key = reader.getString()
        keyboard.text = ''
        device.emit 'onKeyHold', keyboard
        return

    bridge.listen bridge.inActions.KEY_INPUT, (reader) ->
        keyboard.key = ''
        keyboard.text = reader.getString()
        device.emit 'onKeyInput', keyboard
        return

    bridge.listen bridge.inActions.KEY_RELEASE, (reader) ->
        keyboard.key = reader.getString()
        keyboard.text = ''
        device.emit 'onKeyRelease', keyboard
        return

    initDeviceNamespace: ->
        device = @
        pointer = @pointer
        keyboard = @keyboard

        @_desktop = false
        @_platform = switch process.env.NEFT_PLATFORM
            when 'android'
                'Android'
            when 'ios'
                'iOS'
            when 'macos'
                'MacOS'
        return

    logDevice: (msg) ->
        pushAction outActions.DEVICE_LOG
        pushString msg

    showDeviceKeyboard: ->
        pushAction outActions.DEVICE_SHOW_KEYBOARD
        return

    hideDeviceKeyboard: ->
        pushAction outActions.DEVICE_HIDE_KEYBOARD
        return
