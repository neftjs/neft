`// when=NEFT_IOS`

'use strict'

utils = require 'src/utils'

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

    outDataObject =
        actions: actions
        booleans: booleans
        integers: integers
        floats: floats
        strings: strings

    ios.dataCallback = bridge.onData

    sendData: ->
        if actionsIndex <= 0
            return

        for i in [actionsIndex...actions.length] by 1
            actions.pop()
        for i in [booleansIndex...booleans.length] by 1
            booleans.pop()
        for i in [integersIndex...integers.length] by 1
            integers.pop()
        for i in [floatsIndex...floats.length] by 1
            floats.pop()
        for i in [stringsIndex...strings.length] by 1
            strings.pop()

        actionsIndex = 0
        booleansIndex = 0
        integersIndex = 0
        floatsIndex = 0
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
