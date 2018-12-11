# Native

    'use strict'

    utils = require '../util'
    assert = require '../assert'
    log = require '../log'

    actions = require './actions'
    eventTypes = require './event-types'
    bridge = require './bridge'

    {CALL_FUNCTION, CALL_FUNCTION_WITH_CALLBACK} = actions.out
    {EVENT_NULL_TYPE, EVENT_BOOLEAN_TYPE, EVENT_INTEGER_TYPE, EVENT_FLOAT_TYPE, EVENT_STRING_TYPE} = eventTypes

    listeners = Object.create null

    bridge.addActionListener actions.in.EVENT, do (args = []) -> (reader) ->
        name = reader.getString()
        argsLen = reader.getInteger()
        for i in [0...argsLen] by 1
            switch reader.getInteger() # type
                when EVENT_NULL_TYPE
                    args[i] = null
                when EVENT_BOOLEAN_TYPE
                    args[i] = reader.getBoolean()
                when EVENT_INTEGER_TYPE
                    args[i] = reader.getInteger()
                when EVENT_FLOAT_TYPE
                    args[i] = reader.getFloat()
                when EVENT_STRING_TYPE
                    args[i] = reader.getString()
                else
                    throw new Error "Unexpected native event argument type"
        if arr = listeners[name]
            for func in arr
                func args...
        else
            log.warn "No listeners added for the native event '#{name}'"
        return

## native.callNativeFunction(*String* name, [*Boolean*|*Float*|*String* args...])

    pushPending = false

    sendData = ->
        pushPending = false
        bridge.sendData()
        return

    exports.callNativeFunction = (name, arg1, arg2, arg3) ->
        assert.isString name, """
            native.callNativeFunction name needs to be a string, but #{name} given
        """
        assert.notLengthOf name, 0, """
            native.callNativeFunction name cannot be an empty string
        """

        bridge.pushAction CALL_FUNCTION
        bridge.pushString name

        argsLen = arguments.length - 1
        bridge.pushInteger argsLen

        for i in [0...argsLen]
            arg = arguments[i + 1]
            switch true
                when typeof arg is 'boolean'
                    bridge.pushInteger EVENT_BOOLEAN_TYPE
                    bridge.pushBoolean arg
                when typeof arg is 'string'
                    bridge.pushInteger EVENT_STRING_TYPE
                    bridge.pushString arg
                when utils.isInteger(arg)
                    bridge.pushInteger EVENT_INTEGER_TYPE
                    bridge.pushInteger arg
                when typeof arg is 'number'
                    assert.isFloat arg, "NaN can't be passed to the native function"
                    bridge.pushInteger EVENT_FLOAT_TYPE
                    bridge.pushFloat arg
                else
                    if arg?
                        log.warn 'Native function can be called with a boolean, ' +
                            "integer, float or a string, but '#{arg}' given"
                    bridge.pushInteger EVENT_NULL_TYPE

        # unless pushPending
        #     pushPending = true
        #     setImmediate sendData
        return

    exports.callFunction = utils.deprecate exports.callNativeFunction, '''
        Neft.native.callFunction is deprecated; use callNativeFunction instead
    '''

## native.onNativeEvent(*String* eventName, *Function* listener)

    exports.onNativeEvent = (name, listener) ->
        assert.isString name, "native.onNativeEvent name needs to be a string, but #{name} given"
        assert.notLengthOf name, 0, "native.onNativeEvent name cannot be an empty string"
        assert.isFunction listener, """
            native.onNativeEvent listener needs to be a function, but #{listener} given
        """

        eventListeners = listeners[name] ?= []
        eventListeners.push listener
        return

    exports.on = utils.deprecate exports.onNativeEvent, '''
        Neft.native.on is deprecated; use onNativeEvent instead
    '''

    exports.registerNativeFunction = bridge.registerNativeFunction

    exports.publishNativeEvent = bridge.publishNativeEvent
