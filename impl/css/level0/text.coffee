'use strict'

utils = require 'utils'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{Item, Image} = impl.Types
	implUtils = impl.utils

	queue = []
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
		utils.clear queue

	updatePending = false

	updateSizeNow = (item) ->
		updatePending = true
		{textElement} = item._impl

		if item._impl.autoWidth
			item.width = textElement.offsetWidth+1

		if item._impl.autoHeight
			item.height = textElement.offsetHeight

		updatePending = false

	updateSize = (item) ->
		if document.readyState isnt 'complete'
			windowLoadQueue.push item
		else
			queue.push item

		unless pending
			setImmediate updateAll
			setTimeout updateAllAndClean, 200
			pending = true

	onWidthChanged = ->
		if not updatePending
			{textElement} = @_impl
			auto = @_impl.autoWidth = @width is 0
			textElement.style.whiteSpace = if auto then 'pre' else 'pre-wrap'
			textElement.style.width = if auto then 'auto' else '100%'
			if auto
				updateSize @

	onHeightChanged = ->
		if not updatePending
			{textElement} = @_impl
			auto = @_impl.autoHeight = @height is 0
			textElement.style.height = if auto then 'auto' else '100%'
			if auto
				updateSize @

	_createTextElement: (item) ->
		storage = item._impl

		storage.autoWidth = true
		storage.autoHeight = true

		# textElement
		textElement = storage.textElement = document.createElement 'span'

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

	create: (item) ->
		Item.create item
		this._createTextElement item
		item._impl.elem.appendChild item._impl.textElement

	setText: (val) ->
		@_impl.textElement.innerHTML = val
		updateSize @

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
