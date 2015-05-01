'use strict'

utils = require 'utils'

module.exports = (impl) ->
	DATA =
		disableFill: true

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

	setButtonMargin: impl.Types.Item.setItemMargin
