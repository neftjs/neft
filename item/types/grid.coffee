'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope, Impl) -> class Grid extends Scope.Item
	@__name__ = 'Grid'

	utils.defProp @::, 'columns', 'e', ->
		Impl.getGridColumns @_globalId
	, (val) ->
		expect(val).toBe.greaterThan 0
		Impl.setGridColumns @_globalId, val

	utils.defProp @::, 'rows', 'e', ->
		Impl.getGridRows @_globalId
	, (val) ->
		expect(val).toBe.greaterThan 0
		Impl.setGridRows @_globalId, val

	utils.defProp @::, 'columnSpacing', 'e', ->
		Impl.getGridColumnSpacing @_globalId
	, (val) ->
		expect(val).toBe.float()
		Impl.setGridColumnSpacing @_globalId, val

	utils.defProp @::, 'rowSpacing', 'e', ->
		Impl.getGridRowSpacing @_globalId
	, (val) ->
		expect(val).toBe.float()
		Impl.setGridRowSpacing @_globalId, val

	utils.defProp @::, 'spacing', 'e', ->
		(@columnSpacing + @rowSpacing) / 2
	, (val) ->
		expect(val).toBe.float()
		@columnSpacing = val
		@rowSpacing = val