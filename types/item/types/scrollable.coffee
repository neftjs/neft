'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope, Impl) -> class Scrollable extends Scope.Item
	@__name__ = 'Scrollable'

	utils.defProp @::, 'contentX', 'e', ->
		Impl.getScrollableContentX @_uid
	, (val) ->
		expect(val).toBe.float()
		Impl.setScrollableContentX @_uid, val

	utils.defProp @::, 'contentY', 'e', ->
		Impl.getScrollableContentY @_uid
	, (val) ->
		expect(val).toBe.float()
		Impl.setScrollableContentY @_uid, val