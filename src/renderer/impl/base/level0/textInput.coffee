'use strict'

module.exports = (impl) ->
    DATA = {}

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        impl.Types.Item.create.call @, data

    setTextInputText: (val) ->

    setTextInputColor: (val) ->

    setTextInputLineHeight: (val) ->

    setTextInputMultiLine: (val) ->

    setTextInputEchoMode: (val) ->

    setTextInputFontFamily: (val) ->

    setTextInputFontPixelSize: (val) ->

    setTextInputFontWordSpacing: (val) ->

    setTextInputFontLetterSpacing: (val) ->

    setTextInputAlignmentHorizontal: (val) ->

    setTextInputAlignmentVertical: (val) ->
