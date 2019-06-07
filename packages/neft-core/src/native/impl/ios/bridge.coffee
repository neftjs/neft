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

    ios.dataCallback = bridge.onData

    sendData: ->
        if actionsIndex <= 0
            return

        # I don't really know what is happening here, but without the line below,
        # Swift may drop some of the array elements we're going to send,
        # especially on large objects;
        ios.nop()

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

        ios.postMessage "transferData", outDataObject
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
