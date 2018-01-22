'use strict'

utils = require 'src/utils'

module.exports = (impl) ->
    pointer = impl.pointer = require('./item/pointer') impl

    NOP = ->

    DATA =
        elem: null
        bindings: null
        anchors: null
        capturePointer: 0
        childrenCapturesPointer: 0

    DATA: DATA

    createData: impl.utils.createDataCloner DATA

    create: (data) ->

    setItemParent: (val) ->

    insertItemBefore: (val) ->
        # remove this item
        impl.setItemParent.call @, null
        @_parent = null

        # remove all items to the given value
        parent = val.parent
        {children} = parent
        tmp = []
        child = val
        while child
            if child isnt @
                impl.setItemParent.call child, null
                child._parent = null
                tmp.push child
            child = child.aboveSibling

        impl.setItemParent.call @, parent
        @_parent = parent
        for item in tmp
            impl.setItemParent.call item, parent
            item._parent = parent

        return

    setItemVisible: (val) ->

    setItemClip: (val) ->

    setItemWidth: (val) ->

    setItemHeight: (val) ->

    setItemX: (val) ->

    setItemY: (val) ->

    setItemScale: (val) ->

    setItemRotation: (val) ->

    setItemOpacity: (val) ->

    setItemLinkUri: (val) ->

    attachItemSignal: (name, signal) ->
        if name is 'pointer'
            pointer.attachItemSignal.call @, signal

    setItemPointerEnabled: (val) ->
        pointer.setItemPointerEnabled.call @, val

    setItemPointerDraggable: (val) ->
        pointer.setItemPointerDraggable.call @, val

    setItemPointerDragActive: (val) ->
        pointer.setItemPointerDragActive.call @, val

    setItemKeysFocus: (val) ->
