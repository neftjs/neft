'use strict'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{items} = impl
	{Item, Image} = impl.Types

	CssText = require('../../css/level0/text') impl

	getImageSource = (item) ->
		{width, height} = item
		{textElement} = item._impl

		# retina displays
		textElement.style.zoom = 2
		width *= 2
		height *= 2

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
			item._impl.contentElem.width = item.width
			item._impl.contentElem.height = item.height
			# TODO: too large height's
			# console.log getImageSource(item), item.width, item.height
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

	create: (item) ->
		Image.create item
		CssText._createTextElement item
		impl._hatchery.appendChild item._impl.textElement
		item._impl.textElement.style.transformOrigin = '0 0'

		item._impl.textElement.setAttribute 'xmlns', 'http://www.w3.org/1999/xhtml'

		item.onWidthChanged updateText
		item.onHeightChanged updateText

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
