'use strict'

module.exports = (impl) ->
	{grid} = impl.utils

	DATA: grid.data

	createData: impl.utils.createDataCloner 'Item', grid.DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		grid.create @, grid.ROW

	setRowSpacing: grid.update
	setRowAlignmentHorizontal: grid.update
	setRowAlignmentVertical: grid.update