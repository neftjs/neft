'use strict'

module.exports = (impl) ->
	{items} = impl
	{Item} = impl.Types

	# TODO: browsers makes borders always visible even
	#       if the size is less than border width

	create: (id, target) ->
		Item.create id, target

		rect = target.rect = document.createElement 'div'
		target.elem.appendChild rect

		{style} = rect
		style.width = '100%'
		style.height = '100%'
		style.boxSizing = 'border-box'
		style.borderWidth = '0'
		style.borderStyle = 'solid'
		style.borderColor = 'transparent'

	getRectangleColor: (id) ->
		items[id].rect.style.backgroundColor

	setRectangleColor: (id, val) ->
		items[id].rect.style.backgroundColor = val

	getRectangleRadius: (id) ->
		parseFloat(items[id].rect.style.borderRadius) or 0

	setRectangleRadius: (id, val) ->
		items[id].rect.style.borderRadius = "#{val}px"

	getRectangleBorderColor: (id) ->
		items[id].rect.style.borderColor

	setRectangleBorderColor: (id, val) ->
		items[id].rect.style.borderColor = val

	getRectangleBorderWidth: (id) ->
		parseFloat(items[id].rect.style.borderWidth) or 0

	setRectangleBorderWidth: (id, val) ->
		items[id].rect.style.borderWidth = "#{val}px"
