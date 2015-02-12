Basic elements/Text
===================

```style
Text {
  font.pixelSize: 30
  font.family: 'monospace'
  text: '<strong>Neft</strong> Renderer'
  color: 'blue'
}
```

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	signal = require 'signal'
	log = require 'log'

	log = log.scope 'Renderer', 'Text'

	module.exports = (Renderer, Impl, itemUtils) ->

*Text* Text([*Object* options, *Array* children]) : *Renderer.Item*
-------------------------------------------------------------------

		class Text extends Renderer.Item
			@__name__ = 'Text'
			@__path__ = 'Renderer.Text'

			SUPPORTED_HTML_TAGS = @SUPPORTED_HTML_TAGS =
				__proto__: null
				b: true
				strong: true
				em: true
				br: true
				font: true
				i: true
				s: true
				u: true
				a: true

			itemUtils.initConstructor @,
				extends: Renderer.Item
				data:
					text: ''
					color: 'black'
					lineHeight: 1

*String* Text::text
-------------------

### *Signal* Text::textChanged(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'text'
				implementation: Impl.setText
				developmentSetter: (val) ->
					expect(val).toBe.string()

*String* Text::color = 'black'
------------------------------

### *Signal* Text::colorChanged(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'color'
				implementation: Impl.setTextColor
				developmentSetter: (val) ->
					expect(val).toBe.string()

*Float* Text::lineHeight = 1
----------------------------

### *Signal* Text::lineHeightChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'lineHeight'
				implementation: Impl.setTextLineHeight
				developmentSetter: (val) ->
					expect(val).toBe.truthy().float()

*Font* Text::font
-----------------

### *Signal* Text::fontChanged(*Font* font)

		class Font extends itemUtils.DeepObject
			@__name__ = 'Font'

			itemUtils.initConstructor @,
				data:
					family: 'sans-serif'
					pixelSize: 14
					weight: 0.4
					wordSpacing: 0
					letterSpacing: 0
					italic: false

			itemUtils.defineProperty
				constructor: Text
				name: 'font'
				valueConstructor: Font

*String* Text::font.family = 'sans-serif'
-----------------------------------------

### *Signal* Text::font.familyChanged(*String* oldValue)

			`//<development>`
			checkingFamily = {}
			`//</development>`
			itemUtils.defineProperty
				constructor: @
				name: 'family'
				namespace: 'font'
				implementation: Impl.setTextFontFamily
				developmentSetter: (val) ->
					expect(val).toBe.truthy().string()

					unless checkingFamily[val]
						checkingFamily[val] = true
						setTimeout =>
							if not Renderer.Loader.Font.fonts[val]
								log.warn "Font `#{@family}` is not loaded; use `Loader.Font` to load a font"
				setter: (_super) -> (val) ->
					if typeof val is 'string'
						_super.call @, val.toLowerCase()
					else
						_super.call @, val

*Float* Text::font.pixelSize = 14
---------------------------------

### *Signal* Text::font.pixelSizeChanged(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'pixelSize'
				namespace: 'font'
				implementation: Impl.setTextFontPixelSize
				developmentSetter: (val) ->
					expect(val).toBe.truthy().float()

*Float* Text::font.weight = 0.4
-------------------------------

### *Signal* Text::font.weightChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'weight'
				namespace: 'font'
				implementation: Impl.setTextFontWeight
				developmentSetter: (val) ->
					expect(val).toBe.float()
					expect(val).not().toBe.greaterThan 1
					expect(val).not().toBe.lessThan 0

*Float* Text::font.wordSpacing = 0
----------------------------------

### *Signal* Text::font.wordSpacingChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'wordSpacing'
				namespace: 'font'
				implementation: Impl.setTextFontWordSpacing
				developmentSetter: (val) ->
					expect(val).toBe.float()

*Float* Text::font.letterSpacing = 0
------------------------------------

### *Signal* Text::font.letterSpacingChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'letterSpacing'
				namespace: 'font'
				implementation: Impl.setTextFontLetterSpacing
				developmentSetter: (val) ->
					expect(val).toBe.float()

*Boolean* Text::font.italic = false
-----------------------------------

### *Signal* Text::font.italicChanged(*Boolean* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'italic'
				namespace: 'font'
				implementation: Impl.setTextFontItalic
				developmentSetter: (val) ->
					expect(val).toBe.boolean()

		Text
