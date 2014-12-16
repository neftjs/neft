'use strict'

module.exports = (impl) ->
	{Item} = impl.Types

	create: (item) ->
		item._impl.elem ?= impl.utils.createQmlObject 'Image'

		Item.create item

	setImageSource: (val, callback) ->
		@_impl.elem.source = val

		# TODO: implement callback