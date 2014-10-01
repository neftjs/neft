'use strict'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{items} = impl
	{Item, Image} = impl.Types

	getImageSource = (id) ->
		item = items[id]

		width = impl.getItemWidth id
		height = impl.getItemHeight id

		# retina displays
		item.textElem.style.transform = "scale(2)"

		svg = "data:image/svg+xml;utf8," +
		"<svg width='#{width*2}' height='#{height*2}' xmlns='http://www.w3.org/2000/svg'>" +
			"<foreignObject width='100%' height='100%'>" +
				item.textElem.outerHTML +
			"</foreignObject>" +
		"</svg>"

		item.textElem.style.transform = ""

		svg

	updateSize = (id) ->
		item = items[id]

		return if item.textUpdatePending
		item.textUpdatePending = true

		if document.readyState isnt 'complete'
			return setTimeout ->
				item.textUpdatePending = false
				updateSize id
			, 1000

		requestAnimationFrame ->
			{textElem} = item

			if item.autoWidth
				impl.setItemWidth id, textElem.offsetWidth+1

			if item.autoHeight
				impl.setItemHeight id, textElem.offsetHeight

			# image
			impl.setImageSource id, getImageSource(id)

			item.textUpdatePending = false

	impl.setItemWidth = do (_super = impl.setItemWidth) -> (id, val) ->
		_super id, val

		item = items[id]
		if item.type is 'Text'
			item.textElem.style.width = if val > 0 then "#{val}px" else 'auto'
			item.textElem.style.whiteSpace = if val > 0 then 'normal' else 'nowrap'
			item.autoWidth = val > 0
			updateSize id

	impl.setItemHeight = do (_super = impl.setItemHeight) -> (id, val) ->
		_super id, val

		item = items[id]
		if item.type is 'Text'
			item.textElem.style.height = if val > 0 then "#{val}px" else 'auto'
			item.autoHeight = val > 0
			updateSize id

	create: (id, target) ->
		Image.create id, target

		target.autoWidth = true
		target.autoHeight = true
		target.textUpdatePending = false

		textElem = target.textElem = document.createElement 'div'
		textElem.setAttribute 'xmlns', 'http://www.w3.org/1999/xhtml'
		impl._hatchery.appendChild textElem

		# set default styles
		{style} = textElem
		style.transformOrigin = '0 0'
		style.visible = 'invisible'
		style.width = 'auto'
		style.height = 'auto'
		style.fontSize = "40px"
		style.whiteSpace = 'nowrap'
		if isFirefox
			style.marginTop = '1px'

	getText: (id) ->
		items[id].textElem.innerHTML

	setText: (id, val) ->
		items[id].textElem.innerHTML = val
		updateSize id

	getTextColor: (id) ->
		items[id].textElem.style.color

	setTextColor: (id, val) ->
		items[id].textElem.style.color = val

	getTextLineHeight: (id) ->
		{style} = items[id].textElem
		(parseFloat(style.lineHeight) / parseFloat(style.fontSize)) or 0

	setTextLineHeight: (id, val) ->
		{style} = items[id].textElem
		pxLineHeight = val * (parseFloat(style.fontSize) or 0)
		style.lineHeight = "#{pxLineHeight}px"
		updateSize id

	getTextFontFamily: (id) ->
		items[id].textElem.style.fontFamily

	setTextFontFamily: (id, val) ->
		items[id].textElem.style.fontFamily = val
		updateSize id

	getTextFontPixelSize: (id) ->
		parseFloat(items[id].textElem.style.fontSize) or 0

	setTextFontPixelSize: (id, val) ->
		{style} = items[id].textElem

		lineHeight = impl.getTextLineHeight id
		items[id].textElem.style.fontSize = "#{val}px"
		impl.setTextLineHeight id, lineHeight
		updateSize id

	getTextFontWeight: (id) ->
		items[id].textElem.style.fontWeight / 1000

	setTextFontWeight: (id, val) ->
		items[id].textElem.style.fontWeight = val * 1000
		updateSize id

	getTextFontWordSpacing: (id) ->
		parseFloat(items[id].textElem.style.wordSpacing) or 0

	setTextFontWordSpacing: (id, val) ->
		items[id].textElem.style.wordSpacing = "#{val}px"
		updateSize id

	getTextFontLetterSpacing: (id) ->
		parseFloat(items[id].textElem.style.letterSpacing) or 0

	setTextFontLetterSpacing: (id, val) ->
		items[id].textElem.style.letterSpacing = "#{val}px"
		updateSize id
