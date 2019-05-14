'use strict'

utils = require '../../../../util'
assert = require '../../../../assert'

module.exports = (impl) ->
    {bridge} = impl
    {outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

    createPointerListener = (action) ->
        (event) ->
            pushAction action
            pushItem @
            pushFloat event.x
            pushFloat event.y
            return

    onPointerPress = createPointerListener outActions.ON_NATIVE_ITEM_POINTER_PRESS
    onPointerRelease = createPointerListener outActions.ON_NATIVE_ITEM_POINTER_RELEASE
    onPointerMove = createPointerListener outActions.ON_NATIVE_ITEM_POINTER_MOVE

    bridge.listen bridge.inActions.NATIVE_ITEM_WIDTH, (reader) ->
        item = bridge.getItemFromReader reader
        item._impl.nativeWidth = reader.getFloat()
        updateNativeSize.call item
        return

    bridge.listen bridge.inActions.NATIVE_ITEM_HEIGHT, (reader) ->
        item = bridge.getItemFromReader reader
        item._impl.nativeHeight = reader.getFloat()
        updateNativeSize.call item
        return

    DATA =
        nativeWidth: 0
        nativeHeight: 0

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        if data.id is -1
            pushAction outActions.CREATE_NATIVE_ITEM
            pushString @constructor.name
            data.id = bridge.getId @

        @pointer.onPress.connect onPointerPress, @
        @pointer.onRelease.connect onPointerRelease, @
        @pointer.onMove.connect onPointerMove, @
        return

    updateNativeSize: updateNativeSize = ->
        {setPropertyValue} = impl.Renderer.itemUtils

        if @_autoWidth
            setPropertyValue @, 'width', @_impl.nativeWidth
        if @_autoHeight
            setPropertyValue @, 'height', @_impl.nativeHeight
        return
