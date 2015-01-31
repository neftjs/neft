'use strict'

utils = require 'utils'

module.exports = (impl) ->
	{Item} = impl.Types
	{grid} = impl.utils

	DATA: grid.DATA

	createData: impl.utils.createDataCloner Item.DATA, grid.DATA

	create: (data) ->
		Item.create.call @, data

		grid.create @, grid.COLUMN | grid.ROW

	setGridColumns: grid.update
	setGridRows: grid.update
	setGridColumnSpacing: grid.update
	setGridRowSpacing: grid.update
