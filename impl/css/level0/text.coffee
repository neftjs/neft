'use strict'

utils = require 'utils'
signal = require 'signal'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{Item, Image} = impl.Types
	implUtils = impl.utils

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
		MAX_CHECKS = 5

		queue = []
		queueItems = Object.create null
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
					queueItems[item.__hash__] = false
				i++
			sizeUpdatePending = false
			return

		updateAllInInterval = ->
			updateAll()
			unless queue.length
				clearInterval intervalId
				intervalPending = false

		updateSizeNow = (item) ->
			{textElement} = item._impl

			if item._impl.autoWidth
				width = textElement.scrollWidth
				if width > 0
					item.width = width + 1

			if item._impl.autoHeight
				height = textElement.scrollHeight
				if height > 0
					item.height = height

			if item._height > 0
				if item._impl.textElement.parentNode is hatchery
					item._impl.elem.appendChild item._impl.textElement
				true
			else
				false

		(item) ->
			item._impl.sizeChecks = 0

			if queueItems[item.__hash__]
				return

			if not isFontReady
				windowLoadQueue.push item
				return

			queueItems[item.__hash__] = true
			queue.push item

			if item._height is 0
				hatchery.appendChild item._impl.textElement

			unless pending
				setImmediate updateAll
				pending = true

			unless intervalPending
				intervalId = setInterval updateAllInInterval, 500
				intervalPending = true

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

	updateContent = do ->
		queue = []
		queueItems = Object.create null
		pending = false

		updateItems = ->
			pending = false

			# update
			for item in queue
				val = item._text
				if val.indexOf('<') isnt -1
					item._impl.textElement.innerHTML = val
				else
					item._impl.textElement.textContent = val

			while queue.length
				item = queue.pop()
				queueItems[item.__hash__] = false
				updateSize item

			return

		(item) ->
			if queueItems[item.__hash__]
				return

			queueItems[item.__hash__] = true
			queue.push item

			unless pending
				setImmediate updateItems
				pending = true

	onWidthChanged = ->
		if not sizeUpdatePending
			{width} = @
			{textElement} = @_impl
			auto = @_impl.autoWidth = width is 0
			textElement.style.whiteSpace = if auto then 'pre' else 'pre-wrap'
			textElement.style.width = if auto then 'auto' else "#{width}px"
			if @_impl.autoWidth or @_impl.autoHeight
				updateSize @

	onHeightChanged = ->
		if not sizeUpdatePending
			{height} = @
			{textElement} = @_impl
			auto = @_impl.autoHeight = height is 0
			textElement.style.height = if auto then 'auto' else "#{height}px"
			if @_impl.autoWidth or @_impl.autoHeight
				updateSize @

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
		textElement: null
		sizeChecks: 0

	exports =
	DATA: DATA

	_createTextElement: (item) ->
		data = item._impl

		# textElement
		textElement = data.textElement = document.createElement 'span'

		# handlers
		item.onWidthChanged onWidthChanged
		item.onHeightChanged onHeightChanged

		# set default styles
		textElement.setAttribute 'class', 'text'

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		Item.create.call @, data

		exports._createTextElement @
		hatchery.appendChild data.textElement

	setText: (val) ->
		updateContent @

	setTextColor: (val) ->
		@_impl.textElement.style.color = val
		return

	setTextLinkColor: (val) ->
		data = @_impl
		unless data.stylesheet
			data.stylesheet = document.createElement 'style'
			data.elem.appendChild data.stylesheet
			data.textElement.setAttribute 'id', "id#{@__hash__}"
		data.stylesheet.innerHTML = "#id#{@__hash__} a { color: #{val}; }"
		return

	setTextLineHeight: (val) ->
		pxLineHeight = val * @font.pixelSize
		@_impl.textElement.style.lineHeight = "#{pxLineHeight}px"
		updateSize @

	setTextFontFamily: (val) ->
		unless isFontReady
			reloadFontFamilyQueue.push @_impl.textElement

		if impl.DEFAULT_FONTS[val]
			val = "#{impl.DEFAULT_FONTS[val]}, #{val}"
		else
			val = "'#{val}'"
		@_impl.textElement.style.fontFamily = val
		updateSize @

	setTextFontPixelSize: (val) ->
		@_impl.textElement.style.fontSize = "#{val}px"
		impl.setTextLineHeight.call @, @lineHeight
		updateSize @

	setTextFontWeight: (val) ->
		@_impl.textElement.style.fontWeight = implUtils.getFontWeight val
		updateSize @

	setTextFontWordSpacing: (val) ->
		@_impl.textElement.style.wordSpacing = "#{val}px"
		updateSize @

	setTextFontLetterSpacing: (val) ->
		@_impl.textElement.style.letterSpacing = "#{val}px"
		updateSize @

	setTextFontItalic: (val) ->
		@_impl.textElement.style.fontStyle = if val then 'italic' else 'normal'
