'use strict'

utils = require 'utils'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{items} = impl
	{Item, Image} = impl.Types

	# TODO: move it to the utils
	stringCount = (str, char) ->
		str.length - str.replace(RegExp(char, 'g'), '').length

	getTextWidth = (id) ->
		text = impl.getText id
		fontSize = impl.getTextFontPixelSize id

		text.length * fontSize * 0.45

	getTextHeight = (id) ->
		text = impl.getText id
		width = impl.getItemWidth id
		fontSize = impl.getTextFontPixelSize id
		lineHeight = impl.getTextLineHeight id

		if width isnt 0
			w = text.length * fontSize * 0.45
			w = Math.round(w * 100) / 100
			lines = Math.ceil w / width
		else
			lines = 1
		lines += stringCount text, '\n'
		lines * lineHeight * fontSize

	updateWidth = (id) ->

	updateHeight = (id) ->

	updateSize = (id) ->
		item = items[id]
		{style} = item.elem

		return if item.textUpdatePending
		item.textUpdatePending = true

		text = impl.getText id
		unless text.length
			if item.autoWidth
				impl.setItemWidth id, 0
			if item.autoHeight
				impl.setItemHeight id, 0
		else
			if document.readyState isnt 'complete'
				setTimeout ->
					updateSize id
				, 1000

			if item.autoWidth
				style.width = 'auto'
				# updateWidth id
				impl.setItemWidth id, getTextWidth(id)

			if item.autoHeight
				style.height = 'auto'
				# updateHeight id
				impl.setItemHeight id, getTextHeight(id)

		item.textUpdatePending = false
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

	impl.setItemWidth = do (_super = impl.setItemWidth) -> (id, val) ->
		_super id, val

		item = items[id]
		if item.type is 'Text' and not item.textUpdatePending
			item.elem.style.whiteSpace = if val > 0 then 'normal' else 'nowrap'
			item.textArea.style.width = if val > 0 then '100%' else 'auto'
			item.autoWidth = val <= 0
			updateSize id

	impl.setItemHeight = do (_super = impl.setItemHeight) -> (id, val) ->
		_super id, val

		item = items[id]
		if item.type is 'Text' and not item.textUpdatePending
			item.textArea.style.height = if val > 0 then '100%' else 'auto'
			item.autoHeight = val <= 0
			updateSize id

	create: (id, target) ->
		Item.create id, target

		target.lineHeight = 1
		target.autoWidth = true
		target.autoHeight = true
		target.textUpdatePending = false

		# textArea
		target.textArea = textArea = document.createElement 'span'
		target.elem.appendChild textArea

		# set default styles
		{style} = textArea
		style.width = 'auto'
		style.height = 'auto'
		style.whiteSpace = 'nowrap'
		style.fontSize = '14px'
		style.fontFamily = 'sans-serif'
		if isFirefox
			style.marginTop = '1px'

	getText: (id) ->
		items[id].textArea.innerHTML

	setText: (id, val) ->
		items[id].textArea.innerHTML = val
		updateSize id

	getTextColor: (id) ->
		items[id].textArea.style.color

	setTextColor: (id, val) ->
		items[id].textArea.style.color = val

	getTextLineHeight: (id) ->
		items[id].lineHeight

	setTextLineHeight: (id, val) ->
		item = items[id]
		{style} = item.textArea

		item.lineHeight = val

		pxLineHeight = Math.max 1, val * (parseFloat(style.fontSize) or 0)
		style.lineHeight = "#{pxLineHeight}px"
		updateSize id

	getTextFontFamily: (id) ->
		items[id].textArea.style.fontFamily

	setTextFontFamily: (id, val) ->
		items[id].textArea.style.fontFamily = val
		updateSize id

	getTextFontPixelSize: (id) ->
		parseFloat(items[id].textArea.style.fontSize) or 0

	setTextFontPixelSize: (id, val) ->
		{style} = items[id].textArea

		lineHeight = impl.getTextLineHeight id
		items[id].textArea.style.fontSize = "#{val}px"
		impl.setTextLineHeight id, lineHeight
		updateSize id

	getTextFontWeight: (id) ->
		items[id].textArea.style.fontWeight / 900

	setTextFontWeight: (id, val) ->
		items[id].textArea.style.fontWeight = Math.round(val * 9) * 100
		updateSize id

	getTextFontWordSpacing: (id) ->
		parseFloat(items[id].textArea.style.wordSpacing) or 0

	setTextFontWordSpacing: (id, val) ->
		items[id].textArea.style.wordSpacing = "#{val}px"
		updateSize id

	getTextFontLetterSpacing: (id) ->
		parseFloat(items[id].textArea.style.letterSpacing) or 0

	setTextFontLetterSpacing: (id, val) ->
		items[id].textArea.style.letterSpacing = "#{val}px"
		updateSize id
