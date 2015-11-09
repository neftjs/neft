'use strict'

utils = require 'utils'
signal = require 'signal'

module.exports = (impl) ->
	{Item, Image} = impl.Types
	implUtils = impl.utils

	{round} = Math

	# used to render not visible texts
	hatchery = impl._hatchery

	textImpl = {}
	signal.create textImpl, 'onFontReady'

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

			textImpl.onFontReady.emit()
			return

	reloadFontFamily = (family) ->
		if (@_font and @_font._family is family) or (not @_font and family is 'sans-serif')
			@_impl.innerElemStyle.fontFamily = @_impl.innerElemStyle.fontFamily
		return

	updateSize = do ->
		windowLoadQueue = []

		textImpl.onFontReady ->
			while elem = windowLoadQueue.pop()
				updateSize elem
			return

		(item) ->
			data = item._impl
			{innerElem} = data

			if not data.autoWidth and not data.autoHeight
				return

			if not isFontReady
				windowLoadQueue.push item

			data.sizeUpdatePending = true
			if data.autoWidth
				item.width = innerElem.offsetWidth
			if data.autoHeight
				item.height = innerElem.offsetHeight
			data.sizeUpdatePending = false

			if innerElem.parentNode is hatchery
				implUtils.prependElement data.elem, innerElem
			else
				if item._height is 0
					hatchery.appendChild data.innerElem
					updateSize item
			return

	updateContent = do ->
		pending = false
		queue = []

		updateItem = (item) ->
			data = item._impl
			if data.containsHTML
				data.innerElem.innerHTML = item._text
			else
				data.innerElem.textContent = item._text
			updateSize item
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
				pending = false
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

	SHEET = """
		.text {
			width: auto;
			height: auto;
			white-space: pre;
			font-size: 14px;
			line-height: 1;
			font-family: #{impl.utils.DEFAULT_FONTS['sans-serif']}, sans-serif;
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
		updateContent @
		return

	setTextFontPixelSize: (val) ->
		val = round val
		@_impl.innerElemStyle.fontSize = "#{val}px"
		updateContent @
		return

	setTextFontWeight: (val) ->
		@_impl.innerElemStyle.fontWeight = implUtils.getFontWeight val
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
