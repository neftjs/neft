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

    _neft.native.onData bridge.onData

    sendData: ->
        if actionsIndex <= 0
            return
        tmpActionsIndex = actionsIndex
        tmpBooleansIndex = booleansIndex
        tmpIntegersIndex = integersIndex
        tmpFloatsIndex = floatsIndex
        tmpStringsIndex = stringsIndex

        actionsIndex = 0
        booleansIndex = 0
        integersIndex = 0
        floatsIndex = 0
        stringsIndex = 0

        _neft.native.transferData actions, tmpActionsIndex,
            booleans, tmpBooleansIndex,
            integers, tmpIntegersIndex,
            floats, tmpFloatsIndex,
            strings, tmpStringsIndex
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
