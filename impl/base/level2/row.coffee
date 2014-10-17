'use strict'

module.exports = (impl) ->
	{Types} = impl
	{Grid} = Types

	create: (id, target) ->
		Grid.create id, target

		target.type = 'Grid'
		target.columns = Infinity
		target.rows = 1
		target.updateY = false

	getRowSpacing: impl.getGridColumnSpacing

	setRowSpacing: impl.setGridColumnSpacing