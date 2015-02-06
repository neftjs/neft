'use strict'

utils = require 'utils'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{Item, Image} = impl.Types
	implUtils = impl.utils

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
			for elem in queue
				updateSizeNow elem
			return

		updateAllAndClean = ->
			updateAll()
			while queue.length
				item = queue.pop()
				queueItems[item.__hash__] = false
			return

		updateSizeNow = (item) ->
			sizeUpdatePending = true
			{textElement} = item._impl

			if item._impl.autoWidth
				item.width = textElement.offsetWidth+1

			if item._impl.autoHeight
				item.height = textElement.offsetHeight

			sizeUpdatePending = false

		(item) ->
			if queueItems[item.__hash__]
				return

			queueItems[item.__hash__] = true

			if document.readyState isnt 'complete'
				windowLoadQueue.push item
			else
				queue.push item

			unless pending
				setImmediate updateAll
				setTimeout updateAllAndClean, 200
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
			{textElement} = @_impl
			auto = @_impl.autoWidth = @width is 0
			textElement.style.whiteSpace = if auto then 'pre' else 'pre-wrap'
			textElement.style.width = if auto then 'auto' else '100%'
			if auto
				updateSize @

	onHeightChanged = ->
		if not sizeUpdatePending
			{textElement} = @_impl
			auto = @_impl.autoHeight = @height is 0
			textElement.style.height = if auto then 'auto' else '100%'
			if auto
				updateSize @

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
		{style} = textElement
		style.width = 'auto'
		style.height = 'auto'
		style.whiteSpace = 'pre'
		style.fontSize = '14px'
		style.fontFamily = 'sans-serif'
		if isFirefox
			style.marginTop = '1px'

	createData: impl.utils.createDataCloner Item.DATA, DATA

	create: (data) ->
		Item.create.call @, data

		exports._createTextElement @
		data.elem.appendChild data.textElement

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
