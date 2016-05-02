'use strict'

utils = require 'src/utils'
signal = require 'src/signal'

module.exports = (impl) ->
    {bridge} = impl
    {outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

    bridge.listen bridge.inActions.SCROLLABLE_CONTENT_X, (reader) ->
        item = bridge.getItemFromReader reader
        item.contentX = reader.getFloat()
        return

    bridge.listen bridge.inActions.SCROLLABLE_CONTENT_Y, (reader) ->
        item = bridge.getItemFromReader reader
        item.contentY = reader.getFloat()
        return

    onPointerPress = ->
        pushAction outActions.ACTIVATE_SCROLLABLE
        pushItem @
        return

    DATA = {}

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        if data.id is 0
            pushAction outActions.CREATE_SCROLLABLE
            data.id = bridge.getId this

        impl.Types.Item.create.call @, data

        @pointer.onPress onPointerPress, @
        return

    setScrollableContentItem: (val) ->
        pushAction outActions.SET_SCROLLABLE_CONTENT_ITEM
        pushItem @
        pushItem val
        return

    setScrollableContentX: (val) ->
        pushAction outActions.SET_SCROLLABLE_CONTENT_X
        pushItem @
        pushFloat val
        return

    setScrollableContentY: (val) ->
        pushAction outActions.SET_SCROLLABLE_CONTENT_Y
        pushItem @
        pushFloat val
        return

    setScrollableSnap: (val) ->
        return

    setScrollableSnapItem: (val) ->
        return
