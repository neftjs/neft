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

		requestAnimationFrame ->
			{elem} = item

			if item.autoWidth
				impl.setItemWidth id, elem.offsetWidth+1

			if item.autoHeight
				impl.setItemHeight id, elem.offsetHeight

			item.textUpdatePending = false

	impl.setItemWidth = do (_super = impl.setItemWidth) -> (id, val) ->
		_super id, val

		item = items[id]
		if item.type is 'Text'
			item.elem.style.whiteSpace = if val > 0 then 'normal' else 'nowrap'
			item.autoWidth = val <= 0
			updateSize id

	impl.setItemHeight = do (_super = impl.setItemHeight) -> (id, val) ->
		_super id, val

		item = items[id]
		if item.type is 'Text'
			item.autoHeight = val <= 0
			updateSize id

	create: (id, target) ->
		Item.create id, target

		target.autoWidth = true
		target.autoHeight = true
		target.textUpdatePending = false

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
		{style} = items[id].elem
		(parseFloat(style.lineHeight) / parseFloat(style.fontSize)) or 0

	setTextLineHeight: (id, val) ->
		{style} = items[id].elem
		pxLineHeight = val * (parseFloat(style.fontSize) or 0)
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
