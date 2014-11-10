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

			utils.defProp @, '_item', '', item

			super Object.create Spacing.DATA

		Dict.defineProperty @::, 'column'

		utils.defProp @::, 'column', 'e', utils.lookupGetter(@::, 'column')
		, do (_super = utils.lookupSetter @::, 'column') -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setGridColumnSpacing.call @_item, val

		Dict.defineProperty @::, 'row'

		utils.defProp @::, 'row', 'e', utils.lookupGetter(@::, 'row')
		, do (_super = utils.lookupSetter @::, 'row') -> (val) ->
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
		utils.defProp @::, 'spacing', 'e', ->
			utils.defProp @, 'spacing', 'e', val = new Spacing(@)
			val
		, (val) ->
			{spacing} = @

			if utils.isObject val
				utils.merge spacing, Spacing.DATA
				utils.merge spacing, val
			else
				spacing.column = val
				spacing.row = val
