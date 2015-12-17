'use strict'

utils = require 'utils'

module.exports = (impl) ->
	{bridge} = impl
	{outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

	DATA =
		imageLoadCallback: null

	bridge.listen bridge.inActions.IMAGE_SIZE, (reader) ->
		image = reader.getItem()
		source = reader.getString()
		success = reader.getBoolean()
		width = reader.getFloat()
		height = reader.getFloat()

		if image.source isnt source
			return

		image._impl.imageLoadCallback?.call image, not success,
			source: source
			width: width
			height: height
		return

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		if data.id is 0
			pushAction outActions.CREATE_IMAGE
			data.id = bridge.getId this

		impl.Types.Item.create.call @, data
		return

	setStaticImagePixelRatio: (val) ->

	setImageSource: (val, callback) ->
		@_impl.imageLoadCallback = callback

		pushAction outActions.SET_IMAGE_SOURCE
		pushItem @
		pushString val or ""
		return

	setImageSourceWidth: (val) ->
		pushAction outActions.SET_IMAGE_SOURCE_WIDTH
		pushItem @
		pushFloat val
		return

	setImageSourceHeight: (val) ->
		pushAction outActions.SET_IMAGE_SOURCE_HEIGHT
		pushItem @
		pushFloat val
		return

	setImageFillMode: (val) ->
		pushAction outActions.SET_IMAGE_FILL_MODE
		pushItem @
		pushString val
		return

	setImageOffsetX: (val) ->
		pushAction outActions.SET_IMAGE_OFFSET_X
		pushItem @
		pushFloat val
		return

	setImageOffsetY: (val) ->
		pushAction outActions.SET_IMAGE_OFFSET_Y
		pushItem @
		pushFloat val
		return
