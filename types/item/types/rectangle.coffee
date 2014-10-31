'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Renderer, Impl, itemUtils) ->
	class Border extends Dict
		@__name__ = 'Border'

		@DATA = 
			width: 0
			color: 'transparent'

		constructor: (item) ->
			expect(item).toBe.any Rectangle

			utils.defProp @, '_item', '', item

			super Object.create Border.DATA

		itemUtils.defineProperty @::, 'width', null, (_super) -> (val) ->
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			_super.call @, val
			Impl.setRectangleBorderWidth.call @_item, val

		itemUtils.defineProperty @::, 'color', null, (_super) -> (val) ->
			expect(val).toBe.truthy().string()
			_super.call @, val
			Impl.setRectangleBorderColor.call @_item, val

	class Rectangle extends Renderer.Item
		@__name__ = 'Rectangle'
		@__path__ = 'Renderer.Rectangle'

		@DATA = utils.merge Object.create(Renderer.Item.DATA),
			color: 'transparent'
			radius: 0
			border: Border.DATA

		itemUtils.defineProperty @::, 'color', null, (_super) -> (val) ->
			expect(val).toBe.truthy().string()
			_super.call @, val
			Impl.setRectangleColor.call @, val

		itemUtils.defineProperty @::, 'radius', null, (_super) -> (val) ->
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			_super.call @, val
			Impl.setRectangleRadius.call @, val

		utils.defProp @::, 'border', 'e', ->
			utils.defProp @, 'border', 'e', val = new Border(@)
			val
		, (val) ->
			expect(val).toBe.simpleObject()
			utils.merge @border, val