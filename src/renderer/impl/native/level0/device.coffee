'use strict'

utils = require 'src/utils'

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
        device.onPointerPress.emit pointer
        return

    bridge.listen bridge.inActions.POINTER_RELEASE, (reader) ->
        pointer.x = reader.getFloat()
        pointer.y = reader.getFloat()
        device.onPointerRelease.emit pointer
        return

    bridge.listen bridge.inActions.POINTER_MOVE, (reader) ->
        pointer.x = reader.getFloat()
        pointer.y = reader.getFloat()
        device.onPointerMove.emit pointer
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
        device.onKeyPress.emit keyboard
        return

    bridge.listen bridge.inActions.KEY_HOLD, (reader) ->
        keyboard.key = reader.getString()
        device.onKeyHold.emit keyboard
        return

    bridge.listen bridge.inActions.KEY_INPUT, (reader) ->
        keyboard.text = reader.getString()
        device.onKeyInput.emit keyboard
        return

    bridge.listen bridge.inActions.KEY_RELEASE, (reader) ->
        keyboard.key = reader.getString()
        device.onKeyRelease.emit keyboard
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
