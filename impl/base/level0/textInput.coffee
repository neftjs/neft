'use strict'

module.exports = (impl) ->
	DATA = {}

	DATA: DATA

	createData: impl.utils.createDataCloner 'Text', DATA

	create: (data) ->
		impl.Types.Text.create.call @, data

	setTextInputText: (val) ->

	setTextInputColor: (val) ->

	setTextInputLineHeight: (val) ->

	setTextInputMultiLine: (val) ->

	setTextInputEchoMode: (val) ->

	setTextInputFontFamily: (val) ->

	setTextInputFontPixelSize: (val) ->

	setTextInputFontWeight: (val) ->

	setTextInputFontWordSpacing: (val) ->

	setTextInputFontLetterSpacing: (val) ->

	setTextInputFontItalic: (val) ->

	setTextInputAlignmentHorizontal: (val) ->

	setTextInputAlignmentVertical: (val) ->