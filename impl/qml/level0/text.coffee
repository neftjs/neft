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

	onLickActivated = (link) ->
		__location.append link

	DATA =
		autoWidth: true
		autoHeight: true

	DATA: DATA

	createData: impl.utils.createDataCloner Item.DATA, DATA

	create: (data) ->
		elem = data.elem ?= impl.utils.createQmlObject 'Text { property string _fontFamily: ""; textFormat: Text.StyledText; font.pixelSize: 14 }'
		elem.linkActivated.connect onLickActivated

		Item.create.call @, data

		# font family
		elem.font.family = Qt.binding -> (stylesWindow.fonts[this._fontFamily] || true).name || ''
		elem.onFontChanged.connect => updateSize @

		# handlers
		@onWidthChanged onWidthChanged
		@onHeightChanged onHeightChanged

		# set default styles
		elem._fontFamily = 'sans-serif'

	setText: (val) ->
		Renderer = require 'renderer'
		{SUPPORTED_HTML_TAGS} = Renderer.Text

		# remove unsupported HTML tags
		val = val.replace ///<\/?([a-zA-Z0-9]+).*?>///g, (str, tag) ->
			if SUPPORTED_HTML_TAGS[tag]
				str
			else
				''
		val = val.replace ///(\ ){2,}///g, (str) ->
			str.replace ///\ ///g, '&nbsp; '

		@_impl.elem.text = val
		updateSize @

	setTextColor: (val) ->
		@_impl.elem.color = impl.utils.toQtColor val

	setTextLineHeight: (val) ->
		@_impl.elem.lineHeight = val

	setTextFontFamily: (val) ->
		@_impl.elem._fontFamily = val.toLowerCase()

	setTextFontPixelSize: (val) ->
		@_impl.elem.font.pixelSize = val

	setTextFontWeight: (val) ->
		weight = FONT_WEIGHT[Math.round(val * (FONT_WEIGHT.length-1))]
		@_impl.elem.font.weight = Font[weight]

	setTextFontWordSpacing: (val) ->
		@_impl.elem.font.wordSpacing = val

	setTextFontLetterSpacing: (val) ->
		@_impl.elem.font.letterSpacing = val

	setTextFontItalic: (val) ->
		@_impl.elem.font.italic = val
