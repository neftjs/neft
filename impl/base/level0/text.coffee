'use strict'

module.exports = (impl) ->
	{items} = impl
	{Item, Image} = impl.Types

	create: (item) ->

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
