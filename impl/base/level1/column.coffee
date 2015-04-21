'use strict'

module.exports = (impl) ->
	{grid} = impl.utils

	DATA: grid.DATA

	createData: impl.utils.createDataCloner 'Item', grid.DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		grid.create @, grid.COLUMN

	setColumnSpacing: grid.update
	setColumnAlignmentHorizontal: grid.update
	setColumnAlignmentVertical: grid.update