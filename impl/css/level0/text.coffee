'use strict'

utils = require 'utils'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{Item, Image} = impl.Types

	# TODO: move it to the utils
	stringCount = (str, char) ->
		str.length - str.replace(RegExp(char, 'g'), '').length

	getTextWidth = (item) ->
		{text} = item
		fontSize = item.font.pixelSize

		text.length * fontSize * 0.45

	getTextHeight = (item) ->
		{text, width, lineHeight} = item
		fontSize = item.font.pixelSize

		if width isnt 0
			w = text.length * fontSize * 0.45
			w = Math.round(w * 100) / 100
			lines = Math.ceil w / width
		else
			lines = 1
		lines += stringCount text, '\n'
		lines * lineHeight * fontSize

	updateWidth = (item) ->

	updateHeight = (item) ->

	updateSize = (item) ->
		return if item._impl.textUpdatePending
		item._impl.textUpdatePending = true

		{text} = item
		unless text.length
			if item._impl.autoWidth
				item.width = 0
			if item._impl.autoHeight
				item.height = 0
		else
			if document.readyState isnt 'complete'
				setTimeout ->
					updateSize item
				, 1000

			style = item._impl.textArea.style
			if item._impl.autoWidth
				style.width = 'auto'
				# updateWidth id
				item.width = getTextWidth(item)

			if item._impl.autoHeight
				style.height = 'auto'
				# updateHeight id
				item.height = getTextHeight(item)

		item._impl.textUpdatePending = false
		return;

		limit = 16 * 60 * 2
		requestAnimationFrame update = ->
			{elem} = item

			unless limit
				return

			width = elem.offsetWidth
			height = elem.offsetHeight
			if (item.autoWidth and width is 0) or (item.autoHeight and height is 0) and elem.innerHTML
				limit--
				requestAnimationFrame update
				return;

			if item.autoWidth
				impl.setItemWidth id, width+1

			if item.autoHeight
				impl.setItemHeight id, height

			item.textUpdatePending = false

	onWidthChanged = (val) ->
		if not @_impl.textUpdatePending
			@_impl.elem.style.whiteSpace = if val > 0 then 'normal' else 'nowrap'
			@_impl.textArea.style.width = if val > 0 then '100%' else 'auto'
			@_impl.autoWidth = val <= 0
			updateSize @

	onHeightChanged = (val) ->
		if not @_impl.textUpdatePending
			@_impl.textArea.style.height = if val > 0 then '100%' else 'auto'
			@_impl.autoHeight = val <= 0
			updateSize @

	create: (item) ->
		storage = item._impl
		Item.create item

		storage.autoWidth = true
		storage.autoHeight = true
		storage.textUpdatePending = false

		# textArea
		textArea = storage.textArea = document.createElement 'span'
		storage.elem.appendChild textArea

		# handlers
		item.onWidthChanged onWidthChanged
		item.onHeightChanged onHeightChanged

		# set default styles
		{style} = textArea
		style.width = 'auto'
		style.height = 'auto'
		style.whiteSpace = 'nowrap'
		style.fontSize = '14px'
		style.fontFamily = 'sans-serif'
		if isFirefox
			style.marginTop = '1px'

	setText: (val) ->
		@_impl.textArea.innerHTML = val
		updateSize @

	setTextColor: (val) ->
		@_impl.textArea.style.color = val

	setTextLineHeight: (val) ->
		pxLineHeight = val * @font.size
		@_impl.textArea.style.lineHeight = "#{pxLineHeight}px"
		updateSize @

	setTextFontFamily: (val) ->
		@_impl.textArea.style.fontFamily = val
		updateSize @

	setTextFontPixelSize: (val) ->
		@_impl.textArea.style.fontSize = "#{val}px"
		impl.setTextLineHeight.call @, @lineHeight
		updateSize @

	setTextFontWeight: (val) ->
		@_impl.textArea.style.fontWeight = Math.round(val * 9) * 100
		updateSize @

	setTextFontWordSpacing: (val) ->
		@_impl.textArea.style.wordSpacing = "#{val}px"
		updateSize @

	setTextFontLetterSpacing: (val) ->
		@_impl.textArea.style.letterSpacing = "#{val}px"
		updateSize @
