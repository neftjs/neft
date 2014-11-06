'use strict'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{items} = impl
	{Item, Image} = impl.Types

	CssText = require('../../css/level0/text') impl

	SVG_TEXT_ZOOM = 2

	getImageSource = (item) ->
		{width, height} = item
		{textElement} = item._impl

		# retina displays
		textElement.style.zoom = SVG_TEXT_ZOOM
		width *= SVG_TEXT_ZOOM
		height *= SVG_TEXT_ZOOM

		svg = "data:image/svg+xml;utf8," +
		"<svg width='#{width}' height='#{height}' xmlns='http://www.w3.org/2000/svg'>" +
			"<foreignObject width='100%' height='100%'>" +
				textElement.outerHTML +
			"</foreignObject>" +
		"</svg>"

		textElement.style.zoom = ""

		svg

	updateText = do ->
		queue = []
		queueItems = {}
		pending = false

		updateItem = (item) ->
			{width, height} = item

			if width is 0 or height is 0
				return

			item._impl.contentElem.width = width
			item._impl.contentElem.height = height
			impl.setImageSource.call item, getImageSource(item)

		updateAll = ->
			pending = false
			while queue.length
				item = queue.pop()
				queueItems[item.__hash__] = false
				updateItem item
			null

		->
			if queueItems[@__hash__]
				return

			queueItems[@__hash__] = true
			queue.push @

			unless pending
				setImmediate updateAll
				pending = true

	onSizeChanged = ->
		{textContainer} = @_impl
		{width, height} = @
		textContainer.style.width = "#{width}px"
		textContainer.style.height = "#{height}px"

		updateText.call @

	create: (item) ->
		Image.create item

		item.onWidthChanged onSizeChanged
		item.onHeightChanged onSizeChanged

		CssText._createTextElement item
		{textElement} = item._impl
		textContainer = item._impl.textContainer = document.createElement 'div'
		textContainer.appendChild textElement
		impl._hatchery.appendChild textContainer
		textElement.style.transformOrigin = '0 0'

		textElement.setAttribute 'xmlns', 'http://www.w3.org/1999/xhtml'

	setText: (val) ->
		CssText.setText.call @, val
		updateText.call @

	setTextColor: (val) ->
		CssText.setTextColor.call @, val
		updateText.call @

	setTextLineHeight: (val) ->
		CssText.setTextLineHeight.call @, val
		updateText.call @

	setTextFontFamily: (val) ->
		CssText.setTextFontFamily.call @, val
		updateText.call @

	setTextFontPixelSize: (val) ->
		CssText.setTextFontPixelSize.call @, val
		updateText.call @

	setTextFontWeight: (val) ->
		CssText.setTextFontWeight.call @, val
		updateText.call @

	setTextFontWordSpacing: (val) ->
		CssText.setTextFontWordSpacing.call @, val
		updateText.call @

	setTextFontLetterSpacing: (val) ->
		CssText.setTextFontLetterSpacing.call @, val
		updateText.call @
