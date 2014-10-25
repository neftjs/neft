'use strict'

module.exports = (impl) ->
	{Types} = impl
	{Item} = Types
	{grid} = impl.utils

	create: (item) ->
		Item.create item

		grid.create item, grid.COLUMN

	setColumnSpacing: grid.update