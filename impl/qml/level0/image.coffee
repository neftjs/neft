'use strict'

module.exports = (impl) ->
	{items} = impl
	{Item} = impl.Types

	create: (id, target) ->
		target.elem ?= impl.utils.createQmlObject 'Image', id

		Item.create id, target

	getImageSource: (id) ->
		items[id].elem.source

	setImageSource: (id, val) ->
		items[id].elem.source = val