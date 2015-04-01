'use strict'

module.exports = (impl) ->
	DATA = {}

	DATA: DATA

	createData: impl.utils.createDataCloner 'Text', DATA

	create: (data) ->
		impl.Types.Text.create.call @, data

	setTextInputIsMultiLine: (val) ->
