'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Renderer, Impl, itemUtils) ->
	class Spacing extends Dict
		@DATA =
			column: 0
			row: 0

		constructor: (item) ->
			expect(item).toBe.any Grid

			utils.defineProperty @, '_item', null, item

			super Object.create Spacing.DATA

		itemUtils.defineProperty @::, 'column', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setGridColumnSpacing.call @_item, val

		itemUtils.defineProperty @::, 'row', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setGridRowSpacing.call @_item, val

		valueOf: ->
			(@column + @row) / 2

	class Grid extends Renderer.Item
		@__name__ = 'Grid'
		@__path__ = 'Renderer.Grid'

		@DATA = utils.merge Object.create(Renderer.Item.DATA),
			columns: 0
			rows: 0
			spacing: Spacing.DATA

		itemUtils.defineProperty @::, 'columns', null, (_super) -> (val) ->
			expect(val).toBe.integer()
			expect(val).toBe.greaterThan 0
			_super.call @, val
			Impl.setGridColumns.call @, val

		itemUtils.defineProperty @::, 'rows', null, (_super) -> (val) ->
			expect(val).toBe.integer()
			expect(val).toBe.greaterThan 0
			_super.call @, val
			Impl.setGridRows.call @, val

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
