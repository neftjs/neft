'use strict'

module.exports = (impl) ->
	{bridge} = impl
	{outActions, actions, items, strings} = bridge

	DATA =
		itemId: 0

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		if data.itemId is 0
			actions.push outActions.CREATE_IMAGE
			data.itemId = bridge.lastId++

			actions.push outActions.SET_ITEM_PARENT
			items.push data.itemId, data.id
		return

	setStaticImagePixelRatio: (val) ->

	setImageSource: (val) ->
		actions.push outActions.SET_IMAGE_SOURCE
		items.push @_impl.itemId
		strings.push val
		return

	setImageSourceWidth: (val) ->

	setImageSourceHeight: (val) ->

	setImageFillMode: (val) ->

	setImageOffsetX: (val) ->

	setImageOffsetY: (val) ->