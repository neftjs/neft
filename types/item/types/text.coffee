'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Renderer, Impl, itemUtils) ->
	class Font extends Dict
		@DATA = 
			family: 'sans-serif'
			pixelSize: 14
			weight: 0.5
			wordSpacing: 0
			letterSpacing: 0

		constructor: (item) ->
			expect(item).toBe.any Text

			utils.defineProperty @, '_item', null, item

			super Object.create Font.DATA

		itemUtils.defineProperty @::, 'family', null, (_super) -> (val) ->
			expect(val).toBe.truthy().string()
			_super.call @, val
			Impl.setTextFontFamily.call @_item, val

		itemUtils.defineProperty @::, 'pixelSize', null, (_super) -> (val) ->
			expect(val).toBe.truthy().float()
			_super.call @, val
			Impl.setTextFontPixelSize.call @_item, val

		itemUtils.defineProperty @::, 'weight', null, (_super) -> (val) ->
			expect(val).toBe.float()
			expect(val).not().toBe.greaterThan 1
			expect(val).not().toBe.lessThan 0
			_super.call @, val
			Impl.setTextFontWeight.call @_item, val

		itemUtils.defineProperty @::, 'wordSpacing', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setTextFontWordSpacing.call @_item, val

		itemUtils.defineProperty @::, 'letterSpacing', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setTextFontLetterSpacing.call @_item, val

	class Text extends Renderer.Item
		@__name__ = 'Text'
		@__path__ = 'Renderer.Text'

		@DATA = utils.merge Object.create(Renderer.Item.DATA),
			text: ''
			color: 'black'
			lineHeight: 1
			font: Font.DATA

		itemUtils.defineProperty @::, 'text', null, (_super) -> (val) ->
			expect(val).toBe.string()
			_super.call @, val
			Impl.setText.call @, val

		itemUtils.defineProperty @::, 'color', null, (_super) -> (val) ->
			expect(val).toBe.truthy().string()
			_super.call @, val
			Impl.setTextColor.call @, val

		itemUtils.defineProperty @::, 'lineHeight', null, (_super) -> (val) ->
			expect(val).toBe.truthy().float()
			_super.call @, val
			Impl.setTextLineHeight.call @, val

		Renderer.State.supportObjectProperty 'font'
		utils.defineProperty @::, 'font', utils.ENUMERABLE, ->
			utils.defineProperty @, 'font', utils.ENUMERABLE, val = new Font(@)
			val
		, (val) ->
			expect(val).toBe.simpleObject()
			utils.merge @font, Font.DATA
			utils.merge @font, val
