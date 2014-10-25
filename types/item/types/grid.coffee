'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Scope, Impl) ->
	class Spacing extends Dict
		constructor: (item) ->
			expect(item).toBe.any Grid

			utils.defProp @, '_item', '', item

			super
				column: 0
				row: 0

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

	class Grid extends Scope.Item
		@__name__ = 'Grid'

		@DATA = utils.merge Object.create(Scope.Item.DATA),
			columns: 0
			rows: 0

		Dict.defineProperty @::, 'columns'

		utils.defProp @::, 'columns', 'e', utils.lookupGetter(@::, 'columns')
		, do (_super = utils.lookupSetter @::, 'columns') -> (val) ->
			expect(val).toBe.integer()
			expect(val).toBe.greaterThan 0
			_super.call @, val
			Impl.setGridColumns.call @, val

		Dict.defineProperty @::, 'rows'

		utils.defProp @::, 'rows', 'e', utils.lookupGetter(@::, 'rows')
		, do (_super = utils.lookupSetter @::, 'rows') -> (val) ->
			expect(val).toBe.integer()
			expect(val).toBe.greaterThan 0
			_super.call @, val
			Impl.setGridRows.call @, val

		utils.defProp @::, 'spacing', 'e', ->
			utils.defProp @, 'spacing', 'e', val = new Spacing(@)
			val
		, (val) ->
			{spacing} = @

			if utils.isObject val
				utils.merge spacing, val
			else
				spacing.column = val
				spacing.row = val
