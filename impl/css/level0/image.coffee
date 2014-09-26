'use strict'

module.exports = (impl) ->
	{items} = impl
	{Item} = impl.Types

	create: (id, target) ->
		Item.create id, target

		image = target.image = document.createElement 'img'
		image.style.width = "100%"
		image.style.height = "100%"
		target.elem.appendChild image

	getImageSource: (id) ->
		items[id].image.src

	setImageSource: (id, val) ->
		items[id].image.src = val