'use strict'

utils = require 'utils'
signal = require 'signal'

module.exports = (impl) ->
	{Item, Image} = impl.Types
	implUtils = impl.utils

	{round} = Math

	# used to render not visible texts
	hatchery = impl._hatchery

	reloadFontFamilyQueue = []
	isFontReady = false
	window.addEventListener 'load', ->
		setTimeout ->
			isFontReady = true

			while elem = reloadFontFamilyQueue.pop()
				elem.style.fontFamily = elem.style.fontFamily

			styles = document.createElement 'style'
			styles.innerHTML = SHEET
			document.body.appendChild styles
			return

	reloadFontFamily = (family) ->
		if (@_font and @_font._family is family) or (not @_font and family is 'sans-serif')
			@_impl.innerElemStyle.fontFamily = @_impl.innerElemStyle.fontFamily
		return

	fontSizes = Object.create null

	getTextSizeWidth = do ->
		canvas = document.createElement 'canvas'
		ctx = canvas.getContext? '2d'
		(font, text) ->
			fontSize = fontSizes[font] ||= Object.create null
			fontSize[text] ||= (
				ctx.font = font;
				ctx.measureText(text).width or 0.1
			)

	loadingTextsByFonts = Object.create null
	implUtils.onFontLoaded (name) ->
		# clear widths
		for font, sizes of fontSizes
			for char of sizes
				sizes[char] = 0

		# update texts sizes
		if arr = loadingTextsByFonts[name]
			for item in arr
				if item._impl.containsHTML
					updateHTMLTextSize item
				else
					updatePlainTextSize item					
			if implUtils.loadedFonts[name]
				loadingTextsByFonts[name] = null
		return

	updatePlainTextSize = (item) ->
		data = item._impl

		if not data.autoWidth and not data.autoHeight
			return

		text = item._text
		if font = item._font
			fontFamily = font._family
			pixelSize = font._pixelSize
			letterSpacing = font._letterSpacing
			wordSpacing = font._wordSpacing
		else
			fontFamily = 'sans-serif'
			pixelSize = 14
			letterSpacing = 0
			wordSpacing = 0

		if implUtils.loadingFonts[fontFamily]
			arr = loadingTextsByFonts[fontFamily] ||= []
			arr.push item

		fontDef = data.font
		x = width = 0
		height = lineHeight = pixelSize * item._lineHeight
		maxWidth = if data.autoWidth then Infinity else item._width
		for char in text
			charWidth = getTextSizeWidth fontDef, char
			charWidth += letterSpacing
			if wordSpacing isnt 0 and char is ' '
				charWidth += wordSpacing
			if x + charWidth > maxWidth
				height += lineHeight
				x = 0
			x += charWidth
			if x > width
				width = x

		data.sizeUpdatePending = true
		if data.autoWidth
			item.width = width
		if data.autoHeight
			item.height = height
		data.sizeUpdatePending = false
		return

	updateHTMLTextSize = (item) ->
		data = item._impl
		{innerElem} = data

		if not data.autoWidth and not data.autoHeight
			return

		if font = item._font
			fontFamily = font._family
		else
			fontFamily = 'sans-serif'

		if implUtils.loadingFonts[fontFamily]
			arr = loadingTextsByFonts[fontFamily] ||= []
			arr.push item

		data.sizeUpdatePending = true
		if data.autoWidth
			item.width = innerElem.offsetWidth
		if data.autoHeight
			item.height = innerElem.offsetHeight
		data.sizeUpdatePending = false

		if innerElem.parentNode is hatchery
			implUtils.prependElement data.elem, innerElem
		else if item._height is 0
			hatchery.appendChild data.innerElem
			updateHTMLTextSize item
		return

	updateContent = do ->
		pending = false
		queue = []

		updateItem = (item) ->
			data = item._impl
			if (text = item._text)
				if data.containsHTML
					data.innerElem.innerHTML = text
					updateHTMLTextSize item
				else
					data.innerElem.textContent = text
					updatePlainTextSize item
			else
				data.sizeUpdatePending = true
				if data.autoWidth
					item.width = 0
				if data.autoHeight
					item.height = 0
				data.sizeUpdatePending = false
			return

		updateAll = ->
			while item = queue.pop()
				item._impl.contentUpdatePending = false
				updateItem item
			pending = false
			return

		(item) ->
			data = item._impl
			if data.contentUpdatePending
				return

			queue.push item
			data.contentUpdatePending = true

			unless pending
				setImmediate updateAll
				pending = true
			return

	onWidthChange = ->
		if not @_impl.sizeUpdatePending
			{width} = @
			{innerElemStyle} = @_impl
			auto = @_impl.autoWidth = width is 0
			innerElemStyle.whiteSpace = if auto then 'pre' else 'pre-wrap'
			innerElemStyle.width = if auto then 'auto' else "#{width}px"
			if @_impl.autoWidth or @_impl.autoHeight
				updateContent @
		return

	onHeightChange = ->
		if not @_impl.sizeUpdatePending
			{height} = @
			{innerElemStyle} = @_impl
			auto = @_impl.autoHeight = height is 0
			innerElemStyle.height = if auto then 'auto' else "#{height}px"
			if @_impl.autoWidth or @_impl.autoHeight
				updateContent @
		return

	updateTextStyle = (item) ->
		data = item._impl
		{innerElemStyle} = data
		{fontWeight, fontSize, fontFamily} = innerElemStyle
		fontWeight ||= '400'
		fontSize ||= '14px'
		fontFamily ||= implUtils.DEFAULT_FONTS['sans-serif']
		data.font = "#{fontWeight} #{fontSize} #{fontFamily}"
		return

	SHEET = """
		.text {
			width: auto;
			height: auto;
			white-space: pre;
			font-size: 14px;
			line-height: 1;
			font-family: #{implUtils.DEFAULT_FONTS['sans-serif']}, sans-serif;
			margin-top: #{if impl.utils.isFirefox then 1 else 0}px;
		}
		.text.textVerticalCenterAlign {
			height: auto !important;
			top: 50%;
			#{impl.utils.transformCSSProp}: translateY(-50%);
		}
		.text.textVerticalBottomAlign {
			height: auto !important;
			top: 100%;
			#{impl.utils.transformCSSProp}: translateY(-100%);
		}
	"""

	COLOR_RESOURCE_REQUEST =
		property: 'color'

	CONTAINS_HTML_RE = /<|&#x/

	DATA =
		stylesheet: null
		autoWidth: true
		autoHeight: true
		innerElem: null
		innerElemStyle: null
		uid: 0
		contentUpdatePending: false
		containsHTML: false
		sizeUpdatePending: false
		font: "14px #{implUtils.DEFAULT_FONTS['sans-serif']}"

	exports =
	DATA: DATA

	_createTextElement: (item) ->
		data = item._impl

		# innerElem
		innerElem = data.innerElem = document.createElement 'span'
		data.innerElemStyle = innerElem.style

		# handlers
		item.onWidthChange onWidthChange
		item.onHeightChange onHeightChange

		# set default styles
		innerElem.setAttribute 'class', 'text'

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		Item.create.call @, data

		exports._createTextElement @
		impl.utils.prependElement data.elem, data.innerElem

		if impl.utils.loadingFonts['sans-serif'] > 0
			impl.utils.onFontLoaded reloadFontFamily, @

	setText: (val) ->
		@_impl.containsHTML = CONTAINS_HTML_RE.test(val)
		updateContent @
		return

	setTextColor: (val) ->
		val = impl.Renderer.resources?.resolve(val, COLOR_RESOURCE_REQUEST) or val
		@_impl.innerElemStyle.color = val
		return

	setTextLinkColor: do ->
		RSC_REQ =
			property: 'linkColor'
		uid = 0
		(val) ->
			val = impl.Renderer.resources?.resolve(val, RSC_REQ) or val
			data = @_impl
			unless data.stylesheet
				data.stylesheet = document.createElement 'style'
				data.elem.appendChild data.stylesheet
				data.innerElem.setAttribute 'id', "textLinkColor#{uid}"
				data.uid = uid++
			data.stylesheet.innerHTML = "#textLinkColor#{data.uid} a { color: #{val}; }"
			return

	setTextLineHeight: (val) ->
		@_impl.innerElemStyle.lineHeight = val
		updateContent @
		return

	setTextFontFamily: (val) ->
		if impl.utils.loadingFonts[val] > 0
			impl.utils.onFontLoaded reloadFontFamily, @

		if impl.utils.DEFAULT_FONTS[val]
			val = "#{impl.utils.DEFAULT_FONTS[val]}, #{val}"
		else
			val = "'#{val}'"
		@_impl.innerElemStyle.fontFamily = val
		updateTextStyle @
		updateContent @
		return

	setTextFontPixelSize: (val) ->
		val = round val
		@_impl.innerElemStyle.fontSize = "#{val}px"
		updateTextStyle @
		updateContent @
		return

	setTextFontWeight: (val) ->
		@_impl.innerElemStyle.fontWeight = implUtils.getFontWeight val
		updateTextStyle @
		updateContent @
		return

	setTextFontWordSpacing: (val) ->
		@_impl.innerElemStyle.wordSpacing = "#{val}px"
		updateContent @
		return

	setTextFontLetterSpacing: (val) ->
		@_impl.innerElemStyle.letterSpacing = "#{val}px"
		updateContent @
		return

	setTextFontItalic: (val) ->
		@_impl.innerElemStyle.fontStyle = if val then 'italic' else 'normal'
		return

	setTextAlignmentHorizontal: (val) ->
		@_impl.innerElemStyle.textAlign = val
		return

	setTextAlignmentVertical: do ->
		CLASSES =
			top: ''
			center: 'textVerticalCenterAlign'
			bottom: 'textVerticalBottomAlign'

		(val) ->
			@_impl.innerElem.setAttribute 'class', "text #{CLASSES[val]}"
			return
