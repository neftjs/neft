Renderer.Grid
=============

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) ->

*Grid* Grid([*Object* options, *Array* children])
-------------------------------------------------

**Extends:** `Renderer.Item`

		class Grid extends Renderer.Item
			@__name__ = 'Grid'
			@__path__ = 'Renderer.Grid'

			@DATA = utils.merge Object.create(Renderer.Item.DATA),
				columns: 0
				rows: 0

*Integer* Grid::columns
-----------------------

### Grid::columnsChanged(*Integer* oldValue)

			itemUtils.defineProperty @::, 'columns', Impl.setGridColumns, null, (_super) -> (val) ->
				expect(val).toBe.integer()
				expect(val).toBe.greaterThan 0
				_super.call @, val

*Integer* Grid::rows
--------------------

### Grid::rowsChanged(*Imteger* oldValue)

			itemUtils.defineProperty @::, 'rows', Impl.setGridRows, null, (_super) -> (val) ->
				expect(val).toBe.integer()
				expect(val).toBe.greaterThan 0
				_super.call @, val

*Spacing* Grid::spacing
-----------------------

			Renderer.State.supportObjectProperty 'spacing'
			utils.defineProperty @::, 'spacing', utils.ENUMERABLE, ->
				utils.defineProperty @, 'spacing', utils.ENUMERABLE, val = new Spacing(@)
				val
			, (val) ->
				{spacing} = @

				if utils.isPlainObject val
					utils.merge spacing, Spacing.DATA
					utils.merge spacing, val
				else
					spacing.column = val
					spacing.row = val

*Spacing* Spacing()
-------------------

		class Spacing
			@DATA = Grid.DATA.spacing =
				column: 0
				row: 0

			constructor: (item) ->
				expect(item).toBe.any Grid

				utils.defineProperty @, '_item', null, item

				data = Object.create Spacing.DATA
				utils.defineProperty @, '_data', null, data

*Float* Spacing::column
-----------------------

### Spacing::columnChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'column', Impl.setGridColumnSpacing, null, (_super) -> (val) ->
				expect(val).toBe.float()
				_super.call @, val

*Float* Spacing::row
--------------------

### Spacing::rowChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'row', Impl.setGridRowSpacing, null, (_super) -> (val) ->
				expect(val).toBe.float()
				_super.call @, val

*Float* Spacing::valueOf()
--------------------------

			valueOf: ->
				(@column + @row) / 2

		Grid