'use strict'

utils = require 'neft-utils'
assert = require 'neft-assert'

module.exports = (impl) ->
	{bridge} = impl
	{outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

	createPointerListener = (action) ->
		(event) ->
			pushAction action
			pushItem @
			pushFloat event.x
			pushFloat event.y
			return

	onPointerPress = createPointerListener outActions.ON_NATIVE_ITEM_POINTER_PRESS
	onPointerRelease = createPointerListener outActions.ON_NATIVE_ITEM_POINTER_RELEASE
	onPointerMove = createPointerListener outActions.ON_NATIVE_ITEM_POINTER_MOVE

	bridge.listen bridge.inActions.NATIVE_ITEM_WIDTH, (reader) ->
		item = bridge.getItemFromReader reader
		oldVal = item.width
		item._width = reader.getFloat()
		item.onWidthChange.emit oldVal
		return

	bridge.listen bridge.inActions.NATIVE_ITEM_HEIGHT, (reader) ->
		item = bridge.getItemFromReader reader
		oldVal = item.height
		item._height = reader.getFloat()
		item.onHeightChange.emit oldVal
		return

	DATA = {}

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		if data.id is 0
			pushAction outActions.CREATE_NATIVE_ITEM
			pushString @constructor.__name__
			data.id = bridge.getId this

		@pointer.onPress onPointerPress, @
		@pointer.onRelease onPointerRelease, @
		@pointer.onMove onPointerMove, @
		return
