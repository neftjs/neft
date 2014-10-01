'use strict'

module.exports = (impl) ->
	{items} = impl
	{Item, Image} = impl.Types

	create: (id, target) ->
		Image.create id, target

		target.text = ''
		target.color = 'black'
		target.lineHeight = 1
		target.fontFamily = 'sans-serif'
		target.fontPixelSize = 14
		target.fontWeight = 0.5
		target.fontWordSpacing = 0
		target.fontLetterSpacing = 0

	getText: (id) ->
		items[id].text

	setText: (id, val) ->
		items[id].text = val

	getTextColor: (id) ->
		items[id].color

	setTextColor: (id, val) ->
		items[id].color = val

	getTextLineHeight: (id) ->
		items[id].lineHeight

	setTextLineHeight: (id, val) ->
		items[id].lineHeight = val

	getTextFontFamily: (id) ->
		items[id].fontFamily

	setTextFontFamily: (id, val) ->
		items[id].fontFamily = val

	getTextFontPixelSize: (id) ->
		items[id].fontPixelSize

	setTextFontPixelSize: (id, val) ->
		items[id].fontPixelSize = val

	getTextFontWeight: (id) ->
		items[id].fontWeight

	setTextFontWeight: (id, val) ->
		items[id].fontWeight = val

	getTextFontWordSpacing: (id) ->
		items[id].fontWordSpacing

	setTextFontWordSpacing: (id, val) ->
		items[id].fontWordSpacing = val

	getTextFontLetterSpacing: (id) ->
		items[id].fontLetterSpacing

	setTextFontLetterSpacing: (id, val) ->
		items[id].fontLetterSpacing = val
