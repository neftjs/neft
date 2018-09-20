`// when=NEFT_NATIVE`

'use strict'

utils = require '../../../util'
assert = require '../../../assert'

module.exports = (impl) ->
    platform = try require('./android') impl
    platform or= try require('./apple') impl
    platform or= try require('./android') impl
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
