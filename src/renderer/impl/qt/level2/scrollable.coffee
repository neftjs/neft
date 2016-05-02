'use strict'

module.exports = (impl) ->
    {Item} = impl.Types

    DATA =
        updatePending: false

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        data.elem ?= impl.utils.createQmlObject 'Flickable {' +
            'property variant neftContentItem;' +
            'contentWidth: neftContentItem ? neftContentItem.width : 0;' +
            'contentHeight: neftContentItem ? neftContentItem.height : 0;' +
            'clip: true;' +
        '}'

        data.elem.contentXChanged.connect @, ->
            @_impl.updatePending = true
            @contentX = @_impl.elem.contentX
            @_impl.updatePending = false

        data.elem.contentYChanged.connect @, ->
            @_impl.updatePending = true
            @contentY = @_impl.elem.contentY
            @_impl.updatePending = false

        Item.create.call @, data

    setScrollableContentItem: (val) ->
        this._impl.elem.neftContentItem = val._impl.elem
        val._impl.elem.parent = this._impl.elem.contentItem
        return

    setScrollableContentX: (val) ->
        unless @_impl.updatePending
            @_impl.elem.contentX = val

    setScrollableContentY: (val) ->
        unless @_impl.updatePending
            @_impl.elem.contentY = val
