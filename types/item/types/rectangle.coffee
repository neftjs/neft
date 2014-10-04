'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope, Impl) ->
	self = null

	Border = Object.create null

	utils.defProp Border, 'width', 'e', ->
		Impl.getRectangleBorderWidth self._uid
	, (val) ->
		expect(val).toBe.float()
		expect(val).not().toBe.lessThan 0
		Impl.setRectangleBorderWidth self._uid, val

	utils.defProp Border, 'color', 'e', ->
		Impl.getRectangleBorderColor self._uid
	, (val) ->
		expect(val).toBe.truthy().string()
		Impl.setRectangleBorderColor self._uid, val

	Object.freeze Border

	class Rectangle extends Scope.Item
		@__name__ = 'Rectangle'

		utils.defProp @::, 'color', 'e', ->
			Impl.getRectangleColor @_uid
		, (val) ->
			expect(val).toBe.truthy().string()
			Impl.setRectangleColor @_uid, val

		utils.defProp @::, 'radius', 'e', ->
			Impl.getRectangleRadius @_uid
		, (val) ->
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			Impl.setRectangleRadius @_uid, val

		utils.defProp @::, 'border', 'e', ->
			self = @
			Border
		, null
