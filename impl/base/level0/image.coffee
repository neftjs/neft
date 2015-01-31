'use strict'

module.exports = (impl) ->
	{Item} = impl.Types

	DATA =
		source: ''

	DATA: DATA

	createData: impl.utils.createDataCloner Item.DATA, DATA

	create: (data) ->
		Item.create.call @, data

	setImageSource: (val) ->
		@_impl.source = val