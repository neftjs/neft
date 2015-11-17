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
			actions.push outActions.CREATE_TEXT
			data.itemId = bridge.lastId++

			actions.push outActions.SET_ITEM_PARENT
			items.push data.itemId, data.id

	setText: (val) ->
		actions.push outActions.SET_TEXT
		items.push @_impl.itemId
		strings.push val
		return

	setTextColor: (val) ->
		actions.push outActions.SET_TEXT_COLOR
		items.push @_impl.itemId
		strings.push val
		return

	setTextLinkColor: (val) ->

	setTextLineHeight: (val) ->
		actions.push outActions.SET_TEXT_LINE_HEIGHT
		items.push @_impl.itemId
		floats.push val
		return

	setTextFontFamily: (val) ->

	setTextFontPixelSize: (val) ->
		actions.push outActions.SET_TEXT_FONT_PIXEL_SIZE
		items.push @_impl.itemId
		ints.push val
		return

	setTextFontWeight: (val) ->

	setTextFontWordSpacing: (val) ->

	setTextFontLetterSpacing: (val) ->

	setTextFontItalic: (val) ->
		actions.push outActions.SET_TEXT_FONT_ITALIC
		items.push @_impl.itemId
		booleans.push val
		return

	setTextAlignmentHorizontal: (val) ->

	setTextAlignmentVertical: (val) ->
