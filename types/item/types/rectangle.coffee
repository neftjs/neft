'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Renderer, Impl, itemUtils) ->
	class Border extends Dict
		@DATA = 
			width: 0
			color: 'transparent'

		constructor: (item) ->
			expect(item).toBe.any Rectangle

			utils.defProp @, '_item', '', item

			super Object.create Border.DATA

		Dict.defineProperty @::, 'width'

		utils.defProp @::, 'width', 'e', utils.lookupGetter(@::, 'width')
		, do (_super = utils.lookupSetter @::, 'width') -> (val) ->
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			_super.call @, val
			Impl.setRectangleBorderWidth.call @_item, val

		Dict.defineProperty @::, 'color'

		utils.defProp @::, 'color', 'e', utils.lookupGetter(@::, 'color')
		, do (_super = utils.lookupSetter @::, 'color') -> (val) ->
			expect(val).toBe.truthy().string()
			_super.call @, val
			Impl.setRectangleBorderColor.call @_item, val

	class Rectangle extends Renderer.Item
		@__name__ = 'Rectangle'

		@DATA = utils.merge Object.create(Renderer.Item.DATA),
			color: 'transparent'
			radius: 0
			border: Border.DATA

		Dict.defineProperty @::, 'color'

		utils.defProp @::, 'color', 'e', utils.lookupGetter(@::, 'color')
		, do (_super = utils.lookupSetter @::, 'color') ->
			itemUtils.createBindingSetter 'color', (val) ->
				expect(val).toBe.truthy().string()
				_super.call @, val
				Impl.setRectangleColor.call @, val

		Dict.defineProperty @::, 'radius'

		utils.defProp @::, 'radius', 'e', utils.lookupGetter(@::, 'radius')
		, do (_super = utils.lookupSetter @::, 'radius') ->
			itemUtils.createBindingSetter 'radius', (val) ->
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