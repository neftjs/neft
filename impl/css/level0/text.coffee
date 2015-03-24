'use strict'

utils = require 'utils'
signal = require 'signal'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{Item, Image} = impl.Types
	implUtils = impl.utils

	{round} = Math

	# used to render not visible texts
	hatchery = impl._hatchery

	impl.DEFAULT_FONTS =
		__proto__: null
		'sans': 'neft-sans-family'
		'sans-serif': 'neft-sans-serif-family'
		'monospace': 'neft-monospace-family'

	textImpl = {}
	signal.create textImpl, 'fontReady'

	sizeUpdatePending = false

	updateSize = do ->
		MAX_CHECKS = 20

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
				if ++item._impl.sizeChecks >= MAX_CHECKS
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
			{textElem} = item._impl

			if item._impl.autoWidth
				width = textElem.offsetWidth
				if width > 0
					item.width = width + 1

			if item._impl.autoHeight
				height = textElem.offsetHeight
				if height > 0
					item.height = height

			if (item._height > 0 and item._impl.elem.offsetParent) or item._impl.sizeChecks is MAX_CHECKS-1
				if item._impl.textElem.parentNode is hatchery
					item._impl.elem.appendChild item._impl.textElem

			return

		(item) ->
			item._impl.sizeChecks = 0

			if item._impl.pendingSize
				return

			if not isFontReady
				windowLoadQueue.push item
				return

			item._impl.pendingSize = true
			queue.push item

			if item._height is 0 or not item._impl.elem.offsetParent
				hatchery.appendChild item._impl.textElem

			unless pending
				setImmediate updateAll
				pending = true

			unless intervalPending
				intervalId = setInterval updateAllInInterval, 200
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

			textImpl.fontReady()
			return

	updateContent = do ->
		queue = []
		pending = false

		updateItems = ->
			pending = false

			# update
			for item in queue
				val = item._text
				if val.indexOf('<') isnt -1
					item._impl.textElem.innerHTML = val
				else
					item._impl.textElem.textContent = val

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

	onWidthChanged = ->
		if not sizeUpdatePending
			{width} = @
			{textElemStyle} = @_impl
			auto = @_impl.autoWidth = width is 0
			textElemStyle.whiteSpace = if auto then 'pre' else 'pre-wrap'
			textElemStyle.width = if auto then 'auto' else "#{width}px"
			if @_impl.autoWidth or @_impl.autoHeight
				updateSize @
		return

	onHeightChanged = ->
		if not sizeUpdatePending
			{height} = @
			{textElemStyle} = @_impl
			auto = @_impl.autoHeight = height is 0
			textElemStyle.height = if auto then 'auto' else "#{height}px"
			if @_impl.autoWidth or @_impl.autoHeight
				updateSize @
		return

	SHEET = """
		.text {
			width: auto;
			height: auto;
			white-space: pre;
			font-size: 14px;
			font-family: #{impl.DEFAULT_FONTS['sans-serif']}, sans-serif;
			margin-top: #{if isFirefox then 1 else 0}px;
		}
	"""

	DATA =
		stylesheet: null
		autoWidth: true
		autoHeight: true
		textElem: null
		textElemStyle: null
		sizeChecks: 0
		pendingSize: false
		pendingContent: false
		uid: 0

	exports =
	DATA: DATA

	_createTextElement: (item) ->
		data = item._impl

		# textElem
		textElem = data.textElem = document.createElement 'span'
		data.textElemStyle = textElem.style

		# handlers
		item.onWidthChanged onWidthChanged
		item.onHeightChanged onHeightChanged

		# set default styles
		textElem.setAttribute 'class', 'text'

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		Item.create.call @, data

		exports._createTextElement @

	setText: (val) ->
		updateContent @

	setTextColor: (val) ->
		@_impl.textElemStyle.color = val
		return

	setTextLinkColor: do ->
		uid = 0
		(val) ->
			data = @_impl
			unless data.stylesheet
				data.stylesheet = document.createElement 'style'
				data.elem.appendChild data.stylesheet
				data.textElem.setAttribute 'id', "textLinkColor#{uid}"
				data.uid = uid++
			data.stylesheet.innerHTML = "#textLinkColor#{data.uid} a { color: #{val}; }"
			return

	setTextLineHeight: (val) ->
		pxLineHeight = round val * @font.pixelSize
		@_impl.textElemStyle.lineHeight = "#{pxLineHeight}px"
		updateSize @

	setTextFontFamily: (val) ->
		unless isFontReady
			reloadFontFamilyQueue.push @_impl.textElem

		if impl.DEFAULT_FONTS[val]
			val = "#{impl.DEFAULT_FONTS[val]}, #{val}"
		else
			val = "'#{val}'"
		@_impl.textElemStyle.fontFamily = val
		updateSize @

	setTextFontPixelSize: (val) ->
		val = round val
		@_impl.textElemStyle.fontSize = "#{val}px"
		impl.setTextLineHeight.call @, @lineHeight
		updateSize @

	setTextFontWeight: (val) ->
		@_impl.textElemStyle.fontWeight = implUtils.getFontWeight val
		updateSize @

	setTextFontWordSpacing: (val) ->
		@_impl.textElemStyle.wordSpacing = "#{val}px"
		updateSize @

	setTextFontLetterSpacing: (val) ->
		@_impl.textElemStyle.letterSpacing = "#{val}px"
		updateSize @

	setTextFontItalic: (val) ->
		@_impl.textElemStyle.fontStyle = if val then 'italic' else 'normal'
