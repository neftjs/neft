'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Scope, Impl) ->
	class Font extends Dict
		constructor: (item) ->
			expect(item).toBe.any Text

			utils.defProp @, '_item', '', item

			super
				family: 'sans-serif'
				pixelSize: 14
				weight: 0.5
				wordSpacing: 0
				letterSpacing: 0

		Dict.defineProperty @::, 'family'

		utils.defProp @::, 'family', 'e', utils.lookupGetter(@::, 'family')
		, do (_super = utils.lookupSetter @::, 'family') -> (val) ->
			expect(val).toBe.truthy().string()
			_super.call @, val
			Impl.setTextFontFamily.call @_item, val

		Dict.defineProperty @::, 'pixelSize'

		utils.defProp @::, 'pixelSize', 'e', utils.lookupGetter(@::, 'pixelSize')
		, do (_super = utils.lookupSetter @::, 'pixelSize') -> (val) ->
			expect(val).toBe.truthy().float()
			_super.call @, val
			Impl.setTextFontPixelSize.call @_item, val

		Dict.defineProperty @::, 'weight'

		utils.defProp @::, 'weight', 'e', utils.lookupGetter(@::, 'weight')
		, do (_super = utils.lookupSetter @::, 'weight') -> (val) ->
			expect(val).toBe.float()
			expect(val).not().toBe.greaterThan 1
			expect(val).not().toBe.lessThan 0
			_super.call @, val
			Impl.setTextFontWeight.call @_item, val

		Dict.defineProperty @::, 'wordSpacing'

		utils.defProp @::, 'wordSpacing', 'e', utils.lookupGetter(@::, 'wordSpacing')
		, do (_super = utils.lookupSetter @::, 'wordSpacing') -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setTextFontWordSpacing.call @_item, val

		Dict.defineProperty @::, 'letterSpacing'

		utils.defProp @::, 'letterSpacing', 'e', utils.lookupGetter(@::, 'letterSpacing')
		, do (_super = utils.lookupSetter @::, 'letterSpacing') -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setTextFontLetterSpacing.call @_item, val

	class Text extends Scope.Item
		@__name__ = 'Text'

		@DATA = utils.merge Object.create(Scope.Item.DATA),
			text: ''
			color: 'black'
			lineHeight: 1
			font: 'sans-serif'

		Dict.defineProperty @::, 'text'

		utils.defProp @::, 'text', 'e', utils.lookupGetter(@::, 'text')
		, do (_super = utils.lookupSetter @::, 'text') -> (val) ->
			expect(val).toBe.string()
			_super.call @, val
			Impl.setText.call @, val

		Dict.defineProperty @::, 'color'

		utils.defProp @::, 'color', 'e', utils.lookupGetter(@::, 'color')
		, do (_super = utils.lookupSetter @::, 'color') -> (val) ->
			expect(val).toBe.truthy().string()
			_super.call @, val
			Impl.setTextColor.call @, val

		Dict.defineProperty @::, 'lineHeight'

		utils.defProp @::, 'lineHeight', 'e', utils.lookupGetter(@::, 'lineHeight')
		, do (_super = utils.lookupSetter @::, 'lineHeight') -> (val) ->
			expect(val).toBe.truthy().float()
			_super.call @, val
			Impl.setTextLineHeight.call @, val

		utils.defProp @::, 'font', 'e', ->
			utils.defProp @, 'font', 'e', val = new Font(@)
			val
		, (val) ->
			expect(val).toBe.simpleObject()
			utils.merge @font, val
