'use strict'

module.exports = (impl) ->
	{Item} = impl.Types

	create: (item) ->
		data = item._impl

		Item.create item

		image = data.image = document.createElement 'img'
		image.style.width = "100%"
		image.style.height = "100%"
		image.style.pointerEvents = 'none'
		data.elem.appendChild image

	setImageSource: (val) ->
		@_impl.image.src = val