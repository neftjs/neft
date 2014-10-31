'use strict'

module.exports = (impl) ->
	{Item} = impl.Types

	create: (item) ->
		item._impl.elem ?= impl.utils.createQmlObject 'Image'

		Item.create item

	setImageSource: (val) ->
		@_impl.elem.source = val