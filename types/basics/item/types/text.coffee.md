Basic items/Text
================

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

*Text* Text() : *Renderer.Item*
-------------------------------

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

			constructor: ->
				@_text = ''
				@_color = 'black'
				@_fontPixelSize = 14
				super()

*String* Text::text
-------------------

### *Signal* Text::textChanged(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'text'
				defaultValue: ''
				implementation: Impl.setText
				developmentSetter: (val) ->
					expect(val).toBe.string()

*String* Text::color = 'black'
------------------------------

### *Signal* Text::colorChanged(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'color'
				defaultValue: 'black'
				implementation: Impl.setTextColor
				developmentSetter: (val) ->
					expect(val).toBe.string()

*Float* Text::lineHeight = 1
----------------------------

### *Signal* Text::lineHeightChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'lineHeight'
				defaultValue: 1
				implementation: Impl.setTextLineHeight
				developmentSetter: (val) ->
					expect(val).toBe.truthy().float()

*Font* Text::font
-----------------

### *Signal* Text::fontChanged(*Font* font)

		class Font extends itemUtils.DeepObject
			@__name__ = 'Font'

			itemUtils.defineProperty
				constructor: Text
				name: 'font'
				valueConstructor: Font

			constructor: ->
				super()

*String* Text::font.family = 'sans-serif'
-----------------------------------------

### *Signal* Text::font.familyChanged(*String* oldValue)

			`//<development>`
			checkingFamily = {}
			`//</development>`
			itemUtils.defineProperty
				constructor: @
				name: 'family'
				defaultValue: 'sans-serif'
				namespace: 'font'
				parentConstructor: Text
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
				defaultValue: 14
				namespace: 'font'
				parentConstructor: Text
				implementation: Impl.setTextFontPixelSize
				developmentSetter: (val) ->
					expect(val).toBe.truthy().float()

*Float* Text::font.weight = 0.4
-------------------------------

### *Signal* Text::font.weightChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'weight'
				defaultValue: 0.4
				namespace: 'font'
				parentConstructor: Text
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
				defaultValue: 0
				namespace: 'font'
				parentConstructor: Text
				implementation: Impl.setTextFontWordSpacing
				developmentSetter: (val) ->
					expect(val).toBe.float()

*Float* Text::font.letterSpacing = 0
------------------------------------

### *Signal* Text::font.letterSpacingChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'letterSpacing'
				defaultValue: 0
				namespace: 'font'
				parentConstructor: Text
				implementation: Impl.setTextFontLetterSpacing
				developmentSetter: (val) ->
					expect(val).toBe.float()

*Boolean* Text::font.italic = false
-----------------------------------

### *Signal* Text::font.italicChanged(*Boolean* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'italic'
				defaultValue: false
				namespace: 'font'
				parentConstructor: Text
				implementation: Impl.setTextFontItalic
				developmentSetter: (val) ->
					expect(val).toBe.boolean()

		Text
