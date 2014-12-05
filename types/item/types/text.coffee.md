Renderer.Text
=============

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	signal = require 'signal'
	Dict = require 'dict'

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

			itemUtils.defineProperty @::, 'text', null, (_super) -> (val) ->
				expect(val).toBe.string()
				_super.call @, val
				Impl.setText.call @, val

*String* Text::color
--------------------

### Text::colorChanged(*String* oldValue)

			itemUtils.defineProperty @::, 'color', null, (_super) -> (val) ->
				expect(val).toBe.string()
				_super.call @, val
				Impl.setTextColor.call @, val

*Float* Text::lineHeight
------------------------

### Text::lineHeightChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'lineHeight', null, (_super) -> (val) ->
				expect(val).toBe.truthy().float()
				_super.call @, val
				Impl.setTextLineHeight.call @, val

*Font* Text::font
-----------------

### Text::fontChanged(*Font* font)

			Renderer.State.supportObjectProperty 'font'
			itemUtils.defineProperty @::, 'font', ((_super) -> ->
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

		class Font extends Dict
			@DATA = Text.DATA.font =
				family: 'sans-serif'
				pixelSize: 14
				weight: 0.5
				wordSpacing: 0
				letterSpacing: 0

			constructor: (item) ->
				expect(item).toBe.any Text

				utils.defineProperty @, '_item', null, item

				super Object.create Font.DATA

*String* Font::family
---------------------

### Font::familyChanged(*String* oldValue)

			itemUtils.defineProperty @::, 'family', null, (_super) -> (val) ->
				expect(val).toBe.truthy().string()
				_super.call @, val
				@_item.fontChanged? @
				Impl.setTextFontFamily.call @_item, val

*Float* Font::pixelSize
-----------------------

### Font::pixelSizeChanged(*String* oldValue)

			itemUtils.defineProperty @::, 'pixelSize', null, (_super) -> (val) ->
				expect(val).toBe.truthy().float()
				_super.call @, val
				@_item.fontChanged? @
				Impl.setTextFontPixelSize.call @_item, val

*Float* Font::weight
--------------------

### Font::weightChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'weight', null, (_super) -> (val) ->
				expect(val).toBe.float()
				expect(val).not().toBe.greaterThan 1
				expect(val).not().toBe.lessThan 0
				_super.call @, val
				@_item.fontChanged? @
				Impl.setTextFontWeight.call @_item, val

*Float* Font::wordSpacing
-------------------------

### Font::wordSpacingChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'wordSpacing', null, (_super) -> (val) ->
				expect(val).toBe.float()
				_super.call @, val
				@_item.fontChanged? @
				Impl.setTextFontWordSpacing.call @_item, val

*Float* Font::letterSpacing
---------------------------

### Font::letterSpacingChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'letterSpacing', null, (_super) -> (val) ->
				expect(val).toBe.float()
				_super.call @, val
				@_item.fontChanged? @
				Impl.setTextFontLetterSpacing.call @_item, val

		Text