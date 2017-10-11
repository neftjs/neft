'use strict'

utils = require 'src/utils'
assert = require 'src/assert'

module.exports = (impl) ->

    platform = do ->
        switch true
            when utils.isAndroid
                require('./android') impl
            when utils.isIOS or utils.isMacOS
                require('./apple') impl
    {bridge} = platform

    bridge.listen bridge.inActions.WINDOW_RESIZE, (reader) ->
        width = reader.getFloat()
        height = reader.getFloat()
        impl.setWindowSize width, height
        return

    exports =
    Types: utils.merge
        Item: require './level0/item'
        Image: require './level0/image'
        Text: require './level0/text'
        Native: require './level0/native'
        FontLoader: require './level0/loader/font'
        Device: require './level0/device'
        Screen: require './level0/screen'
        Navigator: require './level0/navigator'

        Rectangle: require './level1/rectangle'
    , platform.Types

    bridge: bridge

    setWindow: (item) ->
        bridge.pushAction bridge.outActions.SET_WINDOW
        bridge.pushItem item
        return

    exports
