'use strict'

FONT_WEIGHT = [
	'Light',
	'Normal',
	'DemiBold',
	'Bold',
	'Black'
]

FONT_WEIGHT_LAST_INDEX = FONT_WEIGHT.length - 1

module.exports = (impl) ->
	{Item, Image} = impl.Types

	updatePending = false

	updateSize = ->
		data = @_impl
		{elem} = data

		updatePending = true

		if data.autoWidth
			@width = elem.contentWidth

		if data.autoHeight
			@height = elem.contentHeight

		updatePending = false

	onWidthChanged = ->
		if not updatePending
			auto = @_impl.autoWidth = @width is 0
			@_impl.elem.wrapMode = if auto then Text.NoWrap else Text.Wrap
		if @_impl.autoWidth or @_impl.autoHeight
			updateSize.call @

	onHeightChanged = ->
		if not updatePending
			@_impl.autoHeight = @height is 0
		if @_impl.autoWidth or @_impl.autoHeight
			updateSize.call @

	onLickActivated = (link) ->
		__location.append link

	onFontLoaded = (name) ->
		fontFamily = @_impl.fontFamily
		if name is fontFamily
			@_impl.elem.font.family = impl.fonts[fontFamily]
			impl.onFontLoaded.disconnect onFontLoaded, @
			@_impl.listensOnFontLoaded = false
		return

	DATA =
		autoWidth: true
		autoHeight: true
		fontFamily: 'sans-serif'
		listensOnFontLoaded: false

	exports =
	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		elem = data.elem ?= impl.utils.createQmlObject(
			'Text {' +
				'font.pixelSize: 14;' +
				'textFormat: Text.StyledText;' +
			'}'
		)

		Item.create.call @, data

		exports.setTextFontFamily.call @, data.fontFamily
		
		# update size
		elem.onFontChanged.connect @, updateSize

		# links
		elem.linkActivated.connect onLickActivated

		# update autoWidth/autoHeight
		@onWidthChanged onWidthChanged
		@onHeightChanged onHeightChanged

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
		updateSize.call @

	setTextColor: (val) ->
		@_impl.elem.color = impl.utils.toQtColor val

	setTextLineHeight: (val) ->
		@_impl.elem.lineHeight = val

	setTextFontFamily: (val) ->
		val = val.toLowerCase()
		@_impl.fontFamily = val
		if impl.fonts[val]
			@_impl.elem.font.family = impl.fonts[val]
		else
			unless @_impl.listensOnFontLoaded
				impl.onFontLoaded onFontLoaded, @
				@_impl.listensOnFontLoaded = true
		return

	setTextFontPixelSize: (val) ->
		@_impl.elem.font.pixelSize = val

	setTextFontWeight: (val) ->
		weight = FONT_WEIGHT[(val * FONT_WEIGHT_LAST_INDEX + 0.5)|0]
		@_impl.elem.font.weight = Font[weight]

	setTextFontWordSpacing: (val) ->
		@_impl.elem.font.wordSpacing = val

	setTextFontLetterSpacing: (val) ->
		@_impl.elem.font.letterSpacing = val

	setTextFontItalic: (val) ->
		@_impl.elem.font.italic = val
