'use strict'

module.exports = (impl) ->
	{bridge} = impl
	{outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

	colorUtils = require '../../base/utils/color'

	bridge.listen bridge.inActions.TEXT_INPUT_TEXT, (reader) ->
		textInput = bridge.getItemFromReader reader
		text = reader.getString()

		oldValue = textInput.text
		textInput._text = text
		textInput.onTextChange.emit oldValue
		return

	DATA = {}

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		if data.id is 0
			pushAction outActions.CREATE_TEXT_INPUT
			data.id = bridge.getId this

		impl.Types.Item.create.call @, data

	setTextInputText: (val) ->
		pushAction outActions.SET_TEXT_INPUT_TEXT
		pushItem @
		pushString val
		return

	setTextInputColor: (val) ->
		pushAction outActions.SET_TEXT_INPUT_COLOR
		pushItem @
		pushInteger colorUtils.toRGBAHex(val, 'black')
		return

	setTextInputLineHeight: (val) ->
		pushAction outActions.SET_TEXT_INPUT_LINE_HEIGHT
		pushItem @
		pushFloat val
		return

	setTextInputMultiLine: (val) ->
		pushAction outActions.SET_TEXT_INPUT_MULTI_LINE
		pushItem @
		pushBoolean val
		return

	setTextInputEchoMode: (val) ->
		pushAction outActions.SET_TEXT_INPUT_ECHO_MODE
		pushItem @
		pushString val
		return

	setTextInputFontFamily: (val) ->
		pushAction outActions.SET_TEXT_INPUT_FONT_FAMILY
		pushItem @
		pushString val
		return

	setTextInputFontPixelSize: (val) ->
		pushAction outActions.SET_TEXT_FONT_INPUT_PIXEL_SIZE
		pushItem @
		pushFloat val
		return

	setTextInputFontWordSpacing: (val) ->
		pushAction outActions.SET_TEXT_FONT_INPUT_WORD_SPACING
		pushItem @
		pushFloat val
		return

	setTextInputFontLetterSpacing: (val) ->
		pushAction outActions.SET_TEXT_FONT_INPUT_LETTER_SPACING
		pushItem @
		pushFloat val
		return

	setTextInputAlignmentHorizontal: (val) ->
		pushAction outActions.SET_TEXT_INPUT_ALIGNMENT_HORIZONTAL
		pushItem @
		pushString val
		return

	setTextInputAlignmentVertical: (val) ->
		pushAction outActions.SET_TEXT_INPUT_ALIGNMENT_VERTICAL
		pushItem @
		pushString val
		return
