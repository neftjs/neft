'use strict'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{items} = impl
	{Item, Image} = impl.Types

	updateSize = (id) ->
		item = items[id]

		return if item.textUpdatePending
		item.textUpdatePending = true

		if document.readyState isnt 'complete'
			setTimeout ->
				updateSize id
			, 1000

		{style} = item.elem
		if item.autoWidth
			style.width = 'auto'
		if item.autoHeight
			style.height = 'auto'

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

	impl.setItemWidth = do (_super = impl.setItemWidth) -> (id, val) ->
		_super id, val

		item = items[id]
		if item.type is 'Text' and not item.textUpdatePending
			item.elem.style.whiteSpace = if val > 0 then 'normal' else 'nowrap'
			item.autoWidth = val <= 0
			updateSize id

	impl.setItemHeight = do (_super = impl.setItemHeight) -> (id, val) ->
		_super id, val

		item = items[id]
		if item.type is 'Text' and not item.textUpdatePending
			item.autoHeight = val <= 0
			updateSize id

	create: (id, target) ->
		Item.create id, target

		target.lineHeight = 1
		target.autoWidth = true
		target.autoHeight = true
		target.textUpdatePending = false

		# TODO: write text in a container

		# set default styles
		{style} = target.elem
		style.width = 'auto'
		style.height = 'auto'
		style.whiteSpace = 'nowrap'
		style.fontSize = '14px'
		style.fontFamily = 'sans-serif'
		if isFirefox
			style.marginTop = '1px'

	getText: (id) ->
		items[id].elem.innerHTML

	setText: (id, val) ->
		items[id].elem.innerHTML = val
		updateSize id

	getTextColor: (id) ->
		items[id].elem.style.color

	setTextColor: (id, val) ->
		items[id].elem.style.color = val

	getTextLineHeight: (id) ->
		items[id].lineHeight

	setTextLineHeight: (id, val) ->
		item = items[id]
		style = item.elem.style

		item.lineHeight = val

		pxLineHeight = Math.max 1, val * (parseFloat(style.fontSize) or 0)
		style.lineHeight = "#{pxLineHeight}px"
		updateSize id

	getTextFontFamily: (id) ->
		items[id].elem.style.fontFamily

	setTextFontFamily: (id, val) ->
		items[id].elem.style.fontFamily = val
		updateSize id

	getTextFontPixelSize: (id) ->
		parseFloat(items[id].elem.style.fontSize) or 0

	setTextFontPixelSize: (id, val) ->
		{style} = items[id].elem

		lineHeight = impl.getTextLineHeight id
		items[id].elem.style.fontSize = "#{val}px"
		impl.setTextLineHeight id, lineHeight
		updateSize id

	getTextFontWeight: (id) ->
		items[id].elem.style.fontWeight / 900

	setTextFontWeight: (id, val) ->
		items[id].elem.style.fontWeight = Math.round(val * 9) * 100
		updateSize id

	getTextFontWordSpacing: (id) ->
		parseFloat(items[id].elem.style.wordSpacing) or 0

	setTextFontWordSpacing: (id, val) ->
		items[id].elem.style.wordSpacing = "#{val}px"
		updateSize id

	getTextFontLetterSpacing: (id) ->
		parseFloat(items[id].elem.style.letterSpacing) or 0

	setTextFontLetterSpacing: (id, val) ->
		items[id].elem.style.letterSpacing = "#{val}px"
		updateSize id
