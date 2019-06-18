'use strict'

module.exports = (impl) ->
    {items} = impl

    DATA = {}

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        impl.Types.Item.create.call @, data

    setText: (val) ->

    setTextWrap: (val) ->

    updateTextContentSize: ->

    setTextColor: (val) ->

    setTextLinkColor: (val) ->

    setTextLineHeight: (val) ->

    setTextFontFamily: (val) ->

    setTextFontPixelSize: (val) ->

    setTextFontWordSpacing: (val) ->

    setTextFontLetterSpacing: (val) ->

    setTextAlignmentHorizontal: (val) ->

    setTextAlignmentVertical: (val) ->
