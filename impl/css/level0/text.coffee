'use strict'

utils = require 'utils'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{Item, Image} = impl.Types

	updatePending = false

	updateSize = (item) ->
		if document.readyState isnt 'complete'
			window.addEventListener 'load', ->
				unless item._impl.textElement.offsetWidth
					setTimeout updateSize, 0, item
				else
					updateSize item
			return;

		updatePending = true

		if item._impl.autoWidth
			item.width = item._impl.textElement.offsetWidth

		if item._impl.autoHeight
			item.height = item._impl.textElement.offsetHeight

		updatePending = false

	onWidthChanged = ->
		if not updatePending
			{textElement} = @_impl
			auto = @_impl.autoWidth = @width is 0
			textElement.style.whiteSpace = if auto then 'nowrap' else 'normal'
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
		style.whiteSpace = 'nowrap'
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
		@_impl.textElement.style.fontWeight = Math.round(val * 9) * 100
		updateSize @

	setTextFontWordSpacing: (val) ->
		@_impl.textElement.style.wordSpacing = "#{val}px"
		updateSize @

	setTextFontLetterSpacing: (val) ->
		@_impl.textElement.style.letterSpacing = "#{val}px"
		updateSize @
