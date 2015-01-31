'use strict'

module.exports = (impl) ->
	{items} = impl
	{Item, Image} = impl.Types

	DATA =
		text: ''
		color: 'black'
		lineHeight: 1
		fontFamily: 'sans-serif'
		fontPixelSize: 14
		fontWeight: 0.5
		fontWordSpacing: 0
		fontLetterSpacing: 0

	DATA: DATA

	createData: impl.utils.createDataCloner Item.DATA, DATA

	create: (data) ->
		Item.create.call @, data

	setText: (val) ->
		@_impl.text = val

	setTextColor: (val) ->
		@_impl.color = val

	setTextLineHeight: (val) ->
		@_impl.lineHeight = val

	setTextFontFamily: (val) ->
		@_impl.fontFamily = val

	setTextFontPixelSize: (val) ->
		@_impl.fontPixelSize = val

	setTextFontWeight: (val) ->
		@_impl.fontWeight = val

	setTextFontWordSpacing: (val) ->
		@_impl.fontWordSpacing = val

	setTextFontLetterSpacing: (val) ->
		@_impl.fontLetterSpacing = val
