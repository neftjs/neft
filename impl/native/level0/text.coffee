'use strict'

module.exports = (impl) ->
	{bridge} = impl
	{outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

	colorUtils = require '../../base/utils/color'

	bridge.listen bridge.inActions.TEXT_SIZE, (reader) ->
		text = reader.getItem()
		width = reader.getFloat()
		height = reader.getFloat()

		text.contentWidth = width
		text.contentHeight = height
		return

	updateTextContentSize = (item) ->
		pushAction outActions.UPDATE_TEXT_CONTENT_SIZE
		pushItem item
		return

	DATA = {}

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		if data.id is 0
			pushAction outActions.CREATE_TEXT
			data.id = bridge.getId this

		impl.Types.Item.create.call @, data

	setText: (val) ->
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
