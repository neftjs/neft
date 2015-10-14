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

	sizeUpdatePending = false

	updateSize = do ->
		MAX_CHECKS = 40
		CHECKS_AFTER_CHANGE = 35

		queue = []
		windowLoadQueue = []
		pending = false
		intervalPending = false
		intervalId = 0

		textImpl.onFontReady ->
			while elem = windowLoadQueue.pop()
				updateSize elem
			return

		updateAll = ->
			pending = false
			sizeUpdatePending = true
			i = 0
			n = queue.length
			while i < n
				item = queue[i]
				updateSizeNow item
				if ++item._impl.sizeChecks > MAX_CHECKS
					if i is n-1
						queue.pop()
						n--
					else
						queue[i] = queue.pop()
						i--
						n--
					item._impl.pendingSize = false
				i++
			sizeUpdatePending = false
			return

		updateAllInInterval = ->
			updateAll()
			unless queue.length
				clearInterval intervalId
				intervalPending = false
			return

		updateSizeNow = (item) ->
			{innerElem} = item._impl

			if item._impl.autoWidth
				width = innerElem.offsetWidth
				if item.width isnt width + 1
					item._impl.sizeChecks = CHECKS_AFTER_CHANGE
				if width > 0
					item.width = width + 1

			if item._impl.autoHeight
				height = innerElem.offsetHeight
				if item.height isnt height
					item._impl.sizeChecks = CHECKS_AFTER_CHANGE
				if height > 0
					item.height = height

			if (item._height > 0 and item._impl.elem.offsetParent) or item._impl.sizeChecks is MAX_CHECKS
				if item._impl.innerElem.parentNode is hatchery
					implUtils.prependElement item._impl.elem, item._impl.innerElem

			return

		(item) ->
			data = item._impl

			data.sizeChecks = 0

			if data.pendingSize or (not data.autoWidth and not data.autoHeight)
				return

			if not isFontReady
				windowLoadQueue.push item
				return

			sizeUpdatePending = true
			updateSizeNow item
			sizeUpdatePending = false
			if data.sizeChecks is MAX_CHECKS
				return

			data.pendingSize = true
			queue.push item

			if item._height is 0 or not data.elem.offsetParent
				hatchery.appendChild data.innerElem

			unless pending
				setTimeout updateAll, 10
				pending = true

			unless intervalPending
				intervalId = setInterval updateAllInInterval, 50
				intervalPending = true
			return

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

	updateContent = do ->
		queue = []
		pending = false

		updateItems = ->
			pending = false

			# update
			for item in queue
				val = item._text
				if val.indexOf('<') isnt -1 or val.indexOf('&#x') isnt -1
					item._impl.innerElem.innerHTML = val
				else
					item._impl.innerElem.textContent = val

			while queue.length
				item = queue.pop()
				item._impl.pendingContent = false
				updateSize item

			return

		(item) ->
			if item._impl.pendingContent
				return

			item._impl.pendingContent = true
			queue.push item

			unless pending
				setImmediate updateItems
				pending = true
			return

	onWidthChange = ->
		if not sizeUpdatePending
			{width} = @
			{innerElemStyle} = @_impl
			auto = @_impl.autoWidth = width is 0
			innerElemStyle.whiteSpace = if auto then 'pre' else 'pre-wrap'
			innerElemStyle.width = if auto then 'auto' else "#{width}px"
			if @_impl.autoWidth or @_impl.autoHeight
				updateSize @
		return

	onHeightChange = ->
		if not sizeUpdatePending
			{height} = @
			{innerElemStyle} = @_impl
			auto = @_impl.autoHeight = height is 0
			innerElemStyle.height = if auto then 'auto' else "#{height}px"
			if @_impl.autoWidth or @_impl.autoHeight
				updateSize @
		return

	SHEET = """
		.text {
			width: auto;
			height: auto;
			white-space: pre;
			font-size: 14px;
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

	DATA =
		stylesheet: null
		autoWidth: true
		autoHeight: true
		innerElem: null
		innerElemStyle: null
		sizeChecks: 0
		pendingSize: false
		pendingContent: false
		uid: 0

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
		updateContent @

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
		pxLineHeight = round val * @font.pixelSize
		@_impl.innerElemStyle.lineHeight = "#{pxLineHeight}px"
		updateSize @

	setTextFontFamily: (val) ->
		if impl.utils.loadingFonts[val] > 0
			impl.utils.onFontLoaded reloadFontFamily, @

		if impl.utils.DEFAULT_FONTS[val]
			val = "#{impl.utils.DEFAULT_FONTS[val]}, #{val}"
		else
			val = "'#{val}'"
		@_impl.innerElemStyle.fontFamily = val
		updateSize @

	setTextFontPixelSize: (val) ->
		val = round val
		@_impl.innerElemStyle.fontSize = "#{val}px"
		impl.setTextLineHeight.call @, @lineHeight
		updateSize @

	setTextFontWeight: (val) ->
		@_impl.innerElemStyle.fontWeight = implUtils.getFontWeight val
		updateSize @

	setTextFontWordSpacing: (val) ->
		@_impl.innerElemStyle.wordSpacing = "#{val}px"
		updateSize @

	setTextFontLetterSpacing: (val) ->
		@_impl.innerElemStyle.letterSpacing = "#{val}px"
		updateSize @

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
