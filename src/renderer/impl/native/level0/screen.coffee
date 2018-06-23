'use strict'

module.exports = (impl) ->
    {bridge} = impl
    {outActions, pushAction, pushString} = bridge

    callback = screen = null

    bridge.listen bridge.inActions.SCREEN_SIZE, (reader) ->
        screen._width = reader.getFloat()
        screen._height = reader.getFloat()

        callback()
        return

    bridge.listen bridge.inActions.SCREEN_ORIENTATION, (reader) ->
        screen.orientation = reader.getString()
        return

    bridge.listen bridge.inActions.SCREEN_STATUSBAR_HEIGHT, (reader) ->
        screen.statusBar.height = reader.getFloat()
        return

    bridge.listen bridge.inActions.SCREEN_NAVIGATIONBAR_HEIGHT, (reader) ->
        screen.navigationBar.height = reader.getFloat()
        return

    initScreenNamespace: (_callback) ->
        callback = _callback
        screen = this

        @_touch = true # TODO

    setScreenStatusBarColor: (val) ->
        pushAction outActions.SET_SCREEN_STATUSBAR_COLOR
        pushString val
        return
