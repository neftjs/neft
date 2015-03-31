'use strict'

module.exports = (impl) ->
	{items} = impl

	DATA =
		text: ''
		linkColor: 'blue'
		color: 'black'
		lineHeight: 1
		fontFamily: 'sans-serif'
		fontPixelSize: 14
		fontWeight: 0.5
		fontWordSpacing: 0
		fontLetterSpacing: 0

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

	setText: (val) ->

	setTextColor: (val) ->

	setTextLinkColor: (val) ->

	setTextLineHeight: (val) ->

	setTextFontFamily: (val) ->

	setTextFontPixelSize: (val) ->

	setTextFontWeight: (val) ->

	setTextFontWordSpacing: (val) ->

	setTextFontLetterSpacing: (val) ->

	setTextAlignmentHorizontal: (val) ->

	setTextAlignmentVertical: (val) ->
