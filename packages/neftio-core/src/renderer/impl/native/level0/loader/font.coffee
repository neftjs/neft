'use strict'

module.exports = (impl) ->
    {bridge} = impl
    {outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

    listeners = Object.create null

    bridge.listen bridge.inActions.FONT_LOAD, (reader) ->
        name = reader.getString()
        success = reader.getBoolean()

        unless success
            error = new Error "Cannot load font #{name}"
        listeners[name]?.pop() error
        return

    loadFont: (name, source, sources, callback) ->
        pushAction outActions.LOAD_FONT
        pushString name
        pushString source

        listeners[name] ?= []
        listeners[name].push callback
        return
