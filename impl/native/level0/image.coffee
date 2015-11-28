'use strict'

module.exports = (impl) ->
	{bridge} = impl
	{outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

	DATA = {}

	bridge.listen bridge.inActions.IMAGE_SIZE, (reader) ->
		image = reader.getItem()
		width = reader.getFloat()
		height = reader.getFloat()

		# text.width = width
		# text.height = height
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

	setImageSource: (val) ->
		pushAction outActions.SET_IMAGE_SOURCE
		pushItem @
		pushString val or ""
		return

	setImageSourceWidth: (val) ->

	setImageSourceHeight: (val) ->

	setImageFillMode: (val) ->

	setImageOffsetX: (val) ->

	setImageOffsetY: (val) ->
