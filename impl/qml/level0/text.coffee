'use strict'

FONT_WEIGHT = [
	'Light',
	'Normal',
	'DemiBold',
	'Bold',
	'Black'
]

module.exports = (impl) ->
	{Item, Image} = impl.Types

	updatePending = false

	updateSize = (item) ->
		storage = item._impl
		{elem} = storage

		updatePending = true

		if storage.autoWidth
			item.width = elem.contentWidth

		if storage.autoHeight
			item.height = elem.contentHeight

		updatePending = false

	onWidthChanged = ->
		if not updatePending
			{elem} = @_impl
			auto = @_impl.autoWidth = @width is 0
			@_impl.elem.wrapMode = if auto then Text.NoWrap else Text.Wrap
			if auto
				updateSize @

	onHeightChanged = ->
		if not updatePending
			{elem} = @_impl
			auto = @_impl.autoHeight = @height is 0
			if auto
				updateSize @

	create: (item) ->
		storage = item._impl
		elem = storage.elem ?= impl.utils.createQmlObject 'Text'

		Item.create item

		storage.autoWidth = true
		storage.autoHeight = true

		# handlers
		item.onWidthChanged onWidthChanged
		item.onHeightChanged onHeightChanged

		# set default styles
		elem.font.pixelSize = 14
		elem.font.family = 'sans-serif'

	setText: (val) ->
		@_impl.elem.text = val
		updateSize @

	setTextColor: (val) ->
		@_impl.elem.color = val

	setTextLineHeight: (val) ->
		@_impl.elem.lineHeight = val
		updateSize @

	setTextFontFamily: (val) ->
		@_impl.elem.font.family = val
		updateSize @

	setTextFontPixelSize: (val) ->
		@_impl.elem.font.pixelSize = val
		updateSize @

	setTextFontWeight: (val) ->
		weight = FONT_WEIGHT[Math.round(val * (FONT_WEIGHT.length-1))]
		@_impl.elem.font.weight = Font[weight]

	setTextFontWordSpacing: (val) ->
		@_impl.elem.font.wordSpacing = val
		updateSize @

	setTextFontLetterSpacing: (val) ->
		@_impl.elem.font.letterSpacing = val
		updateSize @
