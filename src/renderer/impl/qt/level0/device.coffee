'use strict'

TOUCH_OS =
    android: true
    blackberry: true
    ios: true
    wince: true

PLATFORMS =
    android: 'Android'
    ios: 'iOS'
    blackberry: 'BlackBerry'
    wince: 'WindowsCE'
    winrt: 'WindowsRT'
    winphone: 'WindowsPhone'
    linux: 'Linux'
    windows: 'Windows'
    unix: 'Unix'
    osx: 'OSX'

module.exports = (impl) ->
    initDeviceNamespace: ->
        device = @
        {pointer} = @
        {screen} = __stylesWindow
        @_platform = PLATFORMS[Qt.platform.os] or 'Unix'
        @_pixelRatio = screen.devicePixelRatio
        isTouch = !!TOUCH_OS[Qt.platform.os]
        @_desktop = not isTouch
        @_phone = isTouch and Math.min(@_width, @_height)/Math.max(@_width, @_height) < 0.75

        __stylesMouseArea.onPressed.connect (e) ->
            e.accepted = true
            pointer.x = e.x
            pointer.y = e.y
            device.onPointerPress.emit pointer
            return

        __stylesMouseArea.onPositionChanged.connect (e) ->
            pointer.x = e.x
            pointer.y = e.y
            device.onPointerMove.emit pointer
            return

        __stylesMouseArea.onReleased.connect (e) ->
            pointer.x = e.x
            pointer.y = e.y
            device.onPointerRelease.emit pointer
            return

        return