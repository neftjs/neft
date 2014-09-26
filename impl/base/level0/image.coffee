'use strict'

module.exports = (impl) ->
	{items} = impl

	create: (id, target) ->
		impl.Types.Item.create id, target
		target.source = ''

	getImageSource: (id) ->
		items[id].source

	setImageSource: (id, val) ->
		items[id].source = val