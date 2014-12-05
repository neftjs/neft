Renderer.Text
=============

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) ->

*Text* Text([*Object* options, *Array* children])
-------------------------------------------------

**Extends:** `Renderer.Item`

		class Text extends Renderer.Item
			@__name__ = 'Text'
			@__path__ = 'Renderer.Text'

			@DATA = utils.merge Object.create(Renderer.Item.DATA),
				text: ''
				color: 'black'
				lineHeight: 1

*String* Text::text
-------------------

### Text::textChanged(*String* oldValue)

			itemUtils.defineProperty @::, 'text', Impl.setText, null, (_super) -> (val) ->
				expect(val).toBe.string()
				_super.call @, val

*String* Text::color
--------------------

### Text::colorChanged(*String* oldValue)

			itemUtils.defineProperty @::, 'color', Impl.setTextColor, null, (_super) -> (val) ->
				expect(val).toBe.string()
				_super.call @, val

*Float* Text::lineHeight
------------------------

### Text::lineHeightChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'lineHeight', Impl.setTextLineHeight, null, (_super) -> (val) ->
				expect(val).toBe.truthy().float()
				_super.call @, val

*Font* Text::font
-----------------

### Text::fontChanged(*Font* font)

			Renderer.State.supportObjectProperty 'font'
			itemUtils.defineProperty @::, 'font', null, ((_super) -> ->
				if @_data.font is Text.DATA.font
					@_data.font = new Font(@)
				_super.call @
			), (_super) -> (val) ->
				if val instanceof Font
					val = val._data

				{font} = @
				_super.call @, font

				if utils.isObject(val)
					utils.merge font, Font.DATA
					utils.merge font, val

*Font* Font()
-------------

**Extends:** `Dict`

		class Font
			@DATA = Text.DATA.font =
				family: 'sans-serif'
				pixelSize: 14
				weight: 0.5
				wordSpacing: 0
				letterSpacing: 0

			constructor: (item) ->
				expect(item).toBe.any Text

				utils.defineProperty @, '_item', null, item

				data = Object.create Font.DATA
				utils.defineProperty @, '_data', null, data

*String* Font::family
---------------------

### Font::familyChanged(*String* oldValue)

			itemUtils.defineProperty @::, 'family', Impl.setTextFontFamily, null, (_super) -> (val) ->
				expect(val).toBe.truthy().string()
				_super.call @, val
				@_item.fontChanged? @

*Float* Font::pixelSize
-----------------------

### Font::pixelSizeChanged(*String* oldValue)

			itemUtils.defineProperty @::, 'pixelSize', Impl.setTextFontPixelSize, null, (_super) -> (val) ->
				expect(val).toBe.truthy().float()
				_super.call @, val
				@_item.fontChanged? @

*Float* Font::weight
--------------------

### Font::weightChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'weight', Impl.setTextFontWeight, null, (_super) -> (val) ->
				expect(val).toBe.float()
				expect(val).not().toBe.greaterThan 1
				expect(val).not().toBe.lessThan 0
				_super.call @, val
				@_item.fontChanged? @

*Float* Font::wordSpacing
-------------------------

### Font::wordSpacingChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'wordSpacing', Impl.setTextFontWordSpacing, null, (_super) -> (val) ->
				expect(val).toBe.float()
				_super.call @, val
				@_item.fontChanged? @

*Float* Font::letterSpacing
---------------------------

### Font::letterSpacingChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'letterSpacing', Impl.setTextFontLetterSpacing, null, (_super) -> (val) ->
				expect(val).toBe.float()
				_super.call @, val
				@_item.fontChanged? @

		Text