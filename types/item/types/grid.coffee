'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope, Impl) ->
	self = null

	Spacing = Object.create null

	utils.defProp Spacing, 'column', 'e', ->
		Impl.getGridColumnSpacing self._uid
	, (val) ->
		expect(val).toBe.float()
		Impl.setGridColumnSpacing self._uid, val

	utils.defProp Spacing, 'row', 'e', ->
		Impl.getGridRowSpacing self._uid
	, (val) ->
		expect(val).toBe.float()
		Impl.setGridRowSpacing self._uid, val

	Spacing.valueOf = ->
		(@column + @row) / 2

	Object.freeze Spacing

	class Grid extends Scope.Item
		@__name__ = 'Grid'

		utils.defProp @::, 'columns', 'e', ->
			Impl.getGridColumns @_uid
		, (val) ->
			expect(val).toBe.greaterThan 0
			Impl.setGridColumns @_uid, val

		utils.defProp @::, 'rows', 'e', ->
			Impl.getGridRows @_uid
		, (val) ->
			expect(val).toBe.greaterThan 0
			Impl.setGridRows @_uid, val

		utils.defProp @::, 'spacing', 'e', ->
			self = @
			Spacing
		, (val) ->
			self = @

			if utils.isObject val
				utils.merge Spacing, val
			else
				Spacing.column = val
				Spacing.row = val