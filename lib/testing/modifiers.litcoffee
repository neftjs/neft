    'use strict'

    {utils} = Neft

    PLATFORMS =
        onNode: 'isNode'
        onServer: 'isServer'
        onClient: 'isClient'
        onBrowser: 'isBrowser'
        onAndroid: 'isAndroid'
        onIOS: 'isIOS'

    exports.applyAll = (func) ->

# onNode

# onServer

# onClient

# onBrowser

# onAndroid

# onIOS

        for funcName, utilsProp of PLATFORMS
            getter = if utils[utilsProp] then -> @ else utils.NOP
            utils.defineProperty func, funcName, 0, getter, null
        return
