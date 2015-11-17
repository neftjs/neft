'use strict'

utils = require 'utils'
assert = require 'assert'

module.exports = (impl) ->
	{bridge} = impl
	{outActions, actions, items, booleans, ints, floats, strings} = bridge

	NOP = ->

	DATA =
		id: 0
		bindings: null
		anchors: null

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		if data.id is 0
			actions.push outActions.CREATE_ITEM
			data.id = bridge.lastId++
		return

	setItemParent: (val) ->
		actions.push outActions.SET_ITEM_PARENT
		items.push @_impl.id
		items.push if val then val._impl.id else 0
		return

	setItemIndex: (val) ->
		if @_impl.itemId
			val++
		if @_background
			val++

		actions.push outActions.SET_ITEM_INDEX
		items.push @_impl.id
		ints.push val
		return

	setItemBackground: (val) ->
		if oldElem = @_background?._impl
			actions.push outActions.SET_ITEM_PARENT
			items.push oldElem.id
			items.push 0

		if val
			actions.push outActions.SET_ITEM_PARENT
			items.push val._impl.id
			items.push @_impl.id

			actions.push outActions.SET_ITEM_INDEX
			items.push val._impl.id
			ints.push 0
		return

		actions.push outActions.SET_ITEM_BACKGROUND
		items.push @_impl.id
		ints.push val
		return

	setItemVisible: (val) ->
		actions.push outActions.SET_ITEM_VISIBLE
		items.push @_impl.id
		booleans.push val
		return

	setItemClip: (val) ->
		actions.push outActions.SET_ITEM_CLIP
		items.push @_impl.id
		booleans.push val
		return

	setItemWidth: (val) ->
		actions.push outActions.SET_ITEM_WIDTH
		items.push @_impl.id
		ints.push val
		return

	setItemHeight: (val) ->
		actions.push outActions.SET_ITEM_HEIGHT
		items.push @_impl.id
		ints.push val
		return

	setItemX: (val) ->
		actions.push outActions.SET_ITEM_X
		items.push @_impl.id
		ints.push val
		return

	setItemY: (val) ->
		actions.push outActions.SET_ITEM_Y
		items.push @_impl.id
		ints.push val
		return

	setItemZ: (val) ->
		actions.push outActions.SET_ITEM_Z
		items.push @_impl.id
		ints.push val
		return

	setItemScale: (val) ->
		actions.push outActions.SET_ITEM_SCALE
		items.push @_impl.id
		floats.push val
		return

	setItemRotation: (val) ->
		actions.push outActions.SET_ITEM_ROTATION
		items.push @_impl.id
		floats.push val
		return

	setItemOpacity: (val) ->
		actions.push outActions.SET_ITEM_OPACITY
		items.push @_impl.id
		ints.push val * 255 | 0
		return

	setItemLinkUri: (val) ->

	attachItemSignal: (name, signal) ->

	setItemPointerEnabled: (val) ->

	setItemPointerDraggable: (val) ->

	setItemPointerDragging: (val) ->

	setItemKeysFocus: (val) ->
