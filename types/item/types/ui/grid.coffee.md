Renderer.Grid
=============

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) ->

*Grid* Grid([*Object* options, *Array* children]) : *Renderer.Item*
-------------------------------------------------------------------

		class Grid extends Renderer.Item
			@__name__ = 'Grid'
			@__path__ = 'Renderer.Grid'

			itemUtils.initConstructor @,
				extends: Renderer.Item
				data:
					columns: 0
					rows: 0

*Integer* Grid::columns
-----------------------

### *Signal* Grid::columnsChanged(*Integer* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'columns'
				implementation: Impl.setGridColumns
				developmentSetter: (val) ->
					expect(val).toBe.greaterThan 0

*Integer* Grid::rows
--------------------

### *Signal* Grid::rowsChanged(*Integer* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'rows'
				implementation: Impl.setGridRows
				developmentSetter: (val) ->
					expect(val).toBe.greaterThan 0

*Spacing* Grid::spacing
-----------------------

		class Spacing extends itemUtils.DeepObject
			@__name__ = 'Spacing'

			itemUtils.initConstructor @,
				data:
					column: 0
					row: 0

			itemUtils.defineProperty
				constructor: @
				name: 'spacing'
				valueConstructor: Spacing

*Float* Grid::spacing.column
----------------------------

### *Signal* Grid::spacing.columnChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'column'
				implementation: Impl.setGridColumnSpacing
				developmentSetter: (val) ->
					expect(val).toBe.float()

*Float* Grid::spacing.row
-------------------------

### *Signal* Grid::spacing.rowChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'row'
				implementation: Impl.setGridRowSpacing
				developmentSetter: (val) ->
					expect(val).toBe.float()

*Float* Grid::spacing.valueOf()
-------------------------------

			valueOf: ->
				if @column is @row
					@column
				else
					throw new Error "column and row grid spacing are different"

		Grid
