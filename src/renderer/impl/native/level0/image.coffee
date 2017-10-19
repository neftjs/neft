'use strict'

utils = require 'src/utils'

module.exports = (impl) ->
    {bridge} = impl
    {outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

    DATA =
        imageLoadCallback: null

    bridge.listen bridge.inActions.IMAGE_SIZE, (reader) ->
        image = bridge.getItemFromReader reader
        source = reader.getString()
        success = reader.getBoolean()
        width = reader.getFloat()
        height = reader.getFloat()

        image._impl.imageLoadCallback?.call image, not success,
            source: source
            width: width
            height: height
        return

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        if data.id is -1
            pushAction outActions.CREATE_IMAGE
            data.id = bridge.getId @

        impl.Types.Item.create.call @, data
        return

    setImageSource: (val, callback) ->
        @_impl.imageLoadCallback = callback

        pushAction outActions.SET_IMAGE_SOURCE
        pushItem @
        pushString val or ''
        return
