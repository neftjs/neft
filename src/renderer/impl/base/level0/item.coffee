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

    doItemOverlap: (item) ->
        a = @
        b = item
        tmp = null

        x1 = a._x; y1 = a._y
        x2 = b._x; y2 = b._y

        parent1 = a
        while tmp = parent1._parent
            x1 += tmp._x
            y1 += tmp._y
            parent1 = tmp

        parent2 = b
        while tmp = parent2._parent
            x1 += tmp._x
            y1 += tmp._y
            parent2 = tmp

        parent1 is parent2 and
        x1 + a._width > x2 and
        y1 + a._height > y2 and
        x1 < x2 + b._width and
        y1 < y2 + b._height

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
