'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope, Impl) -> class Column extends Scope.Item
	@__name__ = 'Column'

	utils.defProp @::, 'spacing', 'e', ->
		Impl.getColumnSpacing @_globalId
	, (val) ->
		expect(val).toBe.float()
		Impl.setColumnSpacing @_globalId, val