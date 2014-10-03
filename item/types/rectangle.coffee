'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope, Impl) ->
	self = null

	Border = Object.create null

	utils.defProp Border, 'width', 'e', ->
		Impl.getRectangleBorderWidth self._globalId
	, (val) ->
		expect(val).toBe.float()
		expect(val).not().toBe.lessThan 0
		Impl.setRectangleBorderWidth self._globalId, val

	utils.defProp Border, 'color', 'e', ->
		Impl.getRectangleBorderColor self._globalId
	, (val) ->
		expect(val).toBe.truthy().string()
		Impl.setRectangleBorderColor self._globalId, val

	Object.freeze Border

	class Rectangle extends Scope.Item
		@__name__ = 'Rectangle'

		utils.defProp @::, 'color', 'e', ->
			Impl.getRectangleColor @_globalId
		, (val) ->
			expect(val).toBe.truthy().string()
			Impl.setRectangleColor @_globalId, val

		utils.defProp @::, 'radius', 'e', ->
			Impl.getRectangleRadius @_globalId
		, (val) ->
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			Impl.setRectangleRadius @_globalId, val

		utils.defProp @::, 'border', 'e', ->
			self = @
			Border
		, null
