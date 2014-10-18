'use strict'

FONT_WEIGHT = [
	'Light',
	'Normal',
	'DemiBold',
	'Bold',
	'Black'
]

module.exports = (impl) ->
	{items} = impl
	{Item, Image} = impl.Types

	updateSize = (id) ->
		impl.setItemWidth id, impl.getItemWidth(id)
		impl.setItemHeight id, impl.getItemHeight(id)

	create: (id, target) ->
		target.elem ?= impl.utils.createQmlObject 'Text', id

		Item.create id, target

		target.elem.font.pixelSize = 14
		target.elem.font.family = 'sans-serif'

	getText: (id) ->
		items[id].elem.text

	setText: (id, val) ->
		items[id].elem.text = val
		updateSize id

	getTextColor: (id) ->
		items[id].elem.color

	setTextColor: (id, val) ->
		items[id].elem.color = val

	getTextLineHeight: (id) ->
		items[id].elem.lineHeight

	setTextLineHeight: (id, val) ->
		items[id].elem.lineHeight = val
		updateSize id

	getTextFontFamily: (id) ->
		items[id].elem.font.family

	setTextFontFamily: (id, val) ->
		items[id].elem.font.family = val
		updateSize id

	getTextFontPixelSize: (id) ->
		items[id].elem.font.pixelSize

	setTextFontPixelSize: (id, val) ->
		items[id].elem.font.pixelSize = val
		updateSize id

	getTextFontWeight: (id) ->
		FONT_WEIGHT.indexOf items[id].elem.font.weight

	setTextFontWeight: (id, val) ->
		weight = FONT_WEIGHT[Math.round(val * (FONT_WEIGHT.length-1))]
		items[id].elem.font.weight = Font[weight]

	getTextFontWordSpacing: (id) ->
		items[id].elem.font.wordSpacing

	setTextFontWordSpacing: (id, val) ->
		items[id].elem.font.wordSpacing = val
		updateSize id

	getTextFontLetterSpacing: (id) ->
		items[id].elem.font.letterSpacing

	setTextFontLetterSpacing: (id, val) ->
		items[id].elem.font.letterSpacing = val
		updateSize id
