'use strict'

eventLoop = require 'src/eventLoop'

module.exports = (impl) ->
    {bridge} = impl
    {outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

    colorUtils = require '../../../utils/color'

    bridge.listen bridge.inActions.TEXT_SIZE, (reader) ->
        text = bridge.getItemFromReader reader
        width = reader.getFloat()
        height = reader.getFloat()

        text.contentWidth = width
        text.contentHeight = height
        return

    updateTextContentSize = do ->
        pending = false
        queue = []

        update = (item) ->
            pushAction outActions.UPDATE_TEXT_CONTENT_SIZE
            pushItem item
            return

        updateAll = (item) ->
            while item = queue.pop()
                item._impl.sizeUpdatePending = false
                update item
            pending = false
            return

        (item) ->
            if item._impl.sizeUpdatePending
                return

            item._impl.sizeUpdatePending = true
            queue.push item

            unless pending
                pending = true
                eventLoop.setImmediate updateAll
            return

    DATA =
        sizeUpdatePending: false

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        if data.id is -1
            pushAction outActions.CREATE_TEXT
            data.id = bridge.getId @

        impl.Types.Item.create.call @, data

    setText: (val) ->
        val = val.replace ///<[bB][rR]\s?\/?>///g, "\n"

        # remove html tags
        # TODO: add simple html support
        val = val.replace ///<([^>]+)>///g, ""

        pushAction outActions.SET_TEXT
        pushItem @
        pushString val
        updateTextContentSize @
        return

    setTextWrap: (val) ->
        pushAction outActions.SET_TEXT_WRAP
        pushItem @
        pushBoolean val
        updateTextContentSize @
        return

    updateTextContentSize: ->
        updateTextContentSize @
        return

    setTextColor: (val) ->
        pushAction outActions.SET_TEXT_COLOR
        pushItem @
        pushInteger colorUtils.toRGBAHex(val, 'black')
        return

    setTextLinkColor: (val) ->

    setTextLineHeight: (val) ->
        pushAction outActions.SET_TEXT_LINE_HEIGHT
        pushItem @
        pushFloat val
        updateTextContentSize @
        return

    setTextFontFamily: (val) ->
        pushAction outActions.SET_TEXT_FONT_FAMILY
        pushItem @
        pushString val
        updateTextContentSize @
        return

    setTextFontPixelSize: (val) ->
        pushAction outActions.SET_TEXT_FONT_PIXEL_SIZE
        pushItem @
        pushFloat val
        updateTextContentSize @
        return

    setTextFontWordSpacing: (val) ->
        pushAction outActions.SET_TEXT_FONT_WORD_SPACING
        pushItem @
        pushFloat val
        updateTextContentSize @
        return

    setTextFontLetterSpacing: (val) ->
        pushAction outActions.SET_TEXT_FONT_LETTER_SPACING
        pushItem @
        pushFloat val
        updateTextContentSize @
        return

    setTextAlignmentHorizontal: (val) ->
        pushAction outActions.SET_TEXT_ALIGNMENT_HORIZONTAL
        pushItem @
        pushString val
        return

    setTextAlignmentVertical: (val) ->
        pushAction outActions.SET_TEXT_ALIGNMENT_VERTICAL
        pushItem @
        pushString val
        return
