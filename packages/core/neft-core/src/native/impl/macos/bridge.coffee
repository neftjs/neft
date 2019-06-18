utils = require '../../../util'

module.exports = (bridge) ->
    actions = []
    actionsIndex = 0
    booleans = []
    booleansIndex = 0
    integers = []
    integersIndex = 0
    floats = []
    floatsIndex = 0
    strings = []
    stringsIndex = 0

    __macos__.clientDataHandler = bridge.onData

    sendData: ->
        if actionsIndex <= 0
            return

        outDataObject =
            actions: actions
            booleans: booleans
            integers: integers
            floats: floats
            strings: strings

        actions = []
        actionsIndex = 0
        booleans = []
        booleansIndex = 0
        integers = []
        integersIndex = 0
        floats = []
        floatsIndex = 0
        strings = []
        stringsIndex = 0

        webkit.messageHandlers.client.postMessage outDataObject
        return
    pushAction: (val) ->
        actions[actionsIndex++] = val
        return
    pushBoolean: (val) ->
        booleans[booleansIndex++] = val
        return
    pushInteger: (val) ->
        integers[integersIndex++] = val
        return
    pushFloat: (val) ->
        floats[floatsIndex++] = val
        return
    pushString: (val) ->
        strings[stringsIndex++] = val
        return
