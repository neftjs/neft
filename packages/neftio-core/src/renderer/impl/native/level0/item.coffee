'use strict'

utils = require '../../../../util'
assert = require '../../../../assert'

{max} = Math

module.exports = (impl) ->
    {bridge} = impl
    {outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

    focusedItem = null

    bridge.listen bridge.inActions.ITEM_KEYS_FOCUS, (reader) ->
        item = bridge.getItemFromReader reader
        focusedItem = item
        item.keys.focus = true
        return

    NOP = ->

    DATA = utils.merge
        id: -1
        bindings: null
        anchors: null
    , impl.ITEM_DATA

    DATA: DATA

    createData: impl.utils.createDataCloner DATA

    create: (data) ->
        if data.id is -1
            pushAction outActions.CREATE_ITEM
            data.id = bridge.getId @
        return

    setItemParent: (val) ->
        pushAction outActions.SET_ITEM_PARENT
        pushItem @
        pushItem val
        return

    insertItemBefore: (val) ->
        pushAction outActions.INSERT_ITEM_BEFORE
        pushItem @
        pushItem val
        return

    setItemVisible: (val) ->
        pushAction outActions.SET_ITEM_VISIBLE
        pushItem @
        pushBoolean val
        return

    setItemClip: (val) ->
        pushAction outActions.SET_ITEM_CLIP
        pushItem @
        pushBoolean val
        return

    setItemWidth: (val) ->
        pushAction outActions.SET_ITEM_WIDTH
        pushItem @
        pushFloat max 0, val
        return

    setItemHeight: (val) ->
        pushAction outActions.SET_ITEM_HEIGHT
        pushItem @
        pushFloat max 0, val
        return

    setItemX: (val) ->
        pushAction outActions.SET_ITEM_X
        pushItem @
        pushFloat val
        return

    setItemY: (val) ->
        pushAction outActions.SET_ITEM_Y
        pushItem @
        pushFloat val
        return

    setItemScale: (val) ->
        pushAction outActions.SET_ITEM_SCALE
        pushItem @
        pushFloat val
        return

    setItemRotation: (val) ->
        pushAction outActions.SET_ITEM_ROTATION
        pushItem @
        pushFloat val
        return

    setItemOpacity: (val) ->
        pushAction outActions.SET_ITEM_OPACITY
        pushItem @
        pushInteger val * 255 | 0
        return

    setItemKeysFocus: (val) ->
        if focusedItem is @
            return if val
            focusedItem = null
        pushAction outActions.SET_ITEM_KEYS_FOCUS
        pushItem @
        pushBoolean val
        return
