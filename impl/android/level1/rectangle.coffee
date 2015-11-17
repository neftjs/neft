'use strict'

module.exports = (impl) ->
	{bridge} = impl
	{outActions, actions, items, booleans, ints, floats, strings} = bridge

	DATA =
		itemId: 0

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		if data.itemId is 0
			actions.push outActions.CREATE_RECTANGLE
			data.itemId = bridge.lastId++

			actions.push outActions.SET_ITEM_PARENT
			items.push data.itemId, data.id
		return

	setRectangleColor: (val) ->
		actions.push outActions.SET_RECTANGLE_COLOR
		items.push @_impl.itemId
		strings.push val
		return

	setRectangleRadius: (val) ->
		actions.push outActions.SET_RECTANGLE_RADIUS
		items.push @_impl.itemId
		floats.push val
		return

	setRectangleBorderColor: (val) ->
		actions.push outActions.SET_RECTANGLE_BORDER_COLOR
		items.push @_impl.itemId
		strings.push val
		return

	setRectangleBorderWidth: (val) ->
		actions.push outActions.SET_RECTANGLE_BORDER_WIDTH
		items.push @_impl.itemId
		floats.push val
		return
