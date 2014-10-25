'use strict'

utils = require 'utils'

module.exports = (impl) ->
	{Item} = impl.Types
	{grid} = impl.utils

	create: (item) ->
		Item.create item

		grid.create item, grid.COLUMN | grid.ROW

	setGridColumns: grid.update
	setGridRows: grid.update
	setGridColumnSpacing: grid.update
	setGridRowSpacing: grid.update
