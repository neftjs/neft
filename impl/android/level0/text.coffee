'use strict'

module.exports = (impl) ->
	{bridge} = impl
	{outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

	bridge.listen bridge.inActions.TEXT_SIZE, (reader) ->
		text = reader.getItem()
		width = reader.getFloat()
		height = reader.getFloat()

		text.width = width
		text.height = height
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
		return

	setTextColor: (val) ->
		pushAction outActions.SET_TEXT_COLOR
		pushItem @
		pushString val
		return

	setTextLinkColor: (val) ->

	setTextLineHeight: (val) ->
		pushAction outActions.SET_TEXT_LINE_HEIGHT
		pushItem @
		pushFloat val
		return

	setTextFontFamily: (val) ->

	setTextFontPixelSize: (val) ->
		pushAction outActions.SET_TEXT_FONT_PIXEL_SIZE
		pushItem @
		pushFloat val
		return

	setTextFontWeight: (val) ->

	setTextFontWordSpacing: (val) ->

	setTextFontLetterSpacing: (val) ->

	setTextFontItalic: (val) ->
		

	setTextAlignmentHorizontal: (val) ->

	setTextAlignmentVertical: (val) ->
