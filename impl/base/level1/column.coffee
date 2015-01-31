'use strict'

module.exports = (impl) ->
	{Types} = impl
	{Item} = Types
	{grid} = impl.utils

	DATA: grid.DATA

	createData: impl.utils.createDataCloner Item.DATA, grid.DATA

	create: (data) ->
		Item.create.call @, data

		grid.create @, grid.COLUMN

	setColumnSpacing: grid.update