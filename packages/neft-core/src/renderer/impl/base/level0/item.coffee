'use strict'

utils = require '../../../../util'

module.exports = (impl) ->
    pointer = impl.pointer = require('./item/pointer') impl
    flowLayout = require('./item/layout/flow') impl
    gridLayout = require('./item/layout/grid') impl

    NOP = ->

    DATA = utils.merge
        bindings: null
        anchors: null
        capturePointer: 0
        childrenCapturesPointer: 0
        layout: null
        loops: 0
        pending: false
        updatePending: false
        gridType: 0
        gridUpdateLoops: 0
        autoWidth: true
        autoHeight: true
    , pointer.DATA

    impl.ITEM_DATA = DATA

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

    setItemLayout: (val) ->
        @_impl.layout?.turnOff.call @

        if val is 'flow'
            @_impl.layout = flowLayout
            flowLayout.turnOn.call @
        else if val is 'column'
            @_impl.layout = gridLayout
            gridLayout.turnOn.call @, gridLayout.COLUMN
        else if val is 'row'
            @_impl.layout = gridLayout
            gridLayout.turnOn.call @, gridLayout.ROW
        else if val is 'grid'
            @_impl.layout = gridLayout
            gridLayout.turnOn.call @, gridLayout.COLUMN | gridLayout.ROW

        return

    setItemColumnSpacing: (val) ->
        @_impl.layout?.update.call @

    setItemRowSpacing: (val) ->
        @_impl.layout?.update.call @

    setItemColumns: (val) ->
        @_impl.layout?.update.call @

    setItemRows: (val) ->
        @_impl.layout?.update.call @

    setItemAlignmentHorizontal: (val) ->
        @_impl.layout?.update.call @

    setItemAlignmentVertical: (val) ->
        @_impl.layout?.update.call @

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
