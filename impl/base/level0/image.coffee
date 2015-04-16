'use strict'

module.exports = (impl) ->
	DATA =
		source: ''

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

	setImageSource: (val) ->
		@_impl.source = val

	setImageSourceWidth: (val) ->

	setImageSourceHeight: (val) ->

	setImageFillMode: (val) ->

	setImageOffsetX: (val) ->

	setImageOffsetY: (val) ->