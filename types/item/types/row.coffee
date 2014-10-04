'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope, Impl) -> class Row extends Scope.Item
	@__name__ = 'Row'

	utils.defProp @::, 'spacing', 'e', ->
		Impl.getRowSpacing @_uid
	, (val) ->
		expect(val).toBe.float()
		Impl.setRowSpacing @_uid, val