    'use strict'

    utils = require 'src/utils'

    NOP = ->

    PLATFORMS =
        onNode: 'isNode'
        onServer: 'isServer'
        onClient: 'isClient'
        onBrowser: 'isBrowser'
        onAndroid: 'isAndroid'
        onIOS: 'isIOS'

    exports.applyAll = (func) ->

# isNode

# isServer

# isClient

# isBrowser

# isAndroid

# isIOS

        for funcName, utilsProp of PLATFORMS
            getter = if utils[utilsProp] then -> this else NOP
            utils.defineProperty func, funcName, 0, getter, null
        return
