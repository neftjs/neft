'use strict'

utils = require 'utils'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{Item, Image} = impl.Types
	implUtils = impl.utils
	hatchery = impl._hatchery

	sizeUpdatePending = false

	updateSize = do ->
		queue = []
		queueItems = Object.create null
		windowLoadQueue = []
		pending = false

		window.addEventListener 'load', ->
			while elem = windowLoadQueue.pop()
				updateSize elem
			return

		updateAll = ->
			pending = false
			sizeUpdatePending = true
			for elem in queue
				updateSizeNow elem
			sizeUpdatePending = false
			return

		updateAllAndClean = ->
			updateAll()
			while queue.length
				item = queue.pop()
				queueItems[item.__hash__] = false

				if item._impl.textElement.parentNode is hatchery
					item._impl.elem.appendChild item._impl.textElement
			return

		updateSizeNow = (item) ->
			{textElement} = item._impl

			if item._impl.autoWidth
				item.width = textElement.scrollWidth+1

			if item._impl.autoHeight
				item.height = textElement.scrollHeight

		(item) ->
			if queueItems[item.__hash__]
				return

			queueItems[item.__hash__] = true

			if document.readyState isnt 'complete'
				windowLoadQueue.push item
			else
				queue.push item

			if item._data.height is 0
				hatchery.appendChild item._impl.textElement

			unless pending
				setImmediate updateAll
				requestAnimationFrame updateAllAndClean
				pending = true

	updateContent = do ->
		queue = []
		queueItems = Object.create null
		pending = false

		updateItems = ->
			pending = false

			# update
			for item in queue
				val = item._data.text
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
			if auto
				updateSize @

	onHeightChanged = ->
		if not sizeUpdatePending
			{height} = @
			{textElement} = @_impl
			auto = @_impl.autoHeight = height is 0
			textElement.style.height = if auto then 'auto' else "#{height}px"
			if auto
				updateSize @

	SHEET = "
		.text {
			width: auto;
			height: auto;
			white-space: pre;
			font-size: 14px;
			font-family: sans-serif;
			margin-top: #{if isFirefox then 1 else 0}px;
		}
	"
	window.addEventListener 'load', ->
		styles = document.createElement 'style'
		styles.innerHTML = SHEET
		document.body.appendChild styles

	DATA =
		autoWidth: true
		autoHeight: true
		textElement: null

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

	createData: impl.utils.createDataCloner Item.DATA, DATA

	create: (data) ->
		Item.create.call @, data

		exports._createTextElement @
		hatchery.appendChild data.textElement

	setText: (val) ->
		updateContent @

	setTextColor: (val) ->
		@_impl.textElement.style.color = val

	setTextLineHeight: (val) ->
		pxLineHeight = val * @font.size
		@_impl.textElement.style.lineHeight = "#{pxLineHeight}px"
		updateSize @

	setTextFontFamily: (val) ->
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
