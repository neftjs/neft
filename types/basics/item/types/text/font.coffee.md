Font @extension
===============

	'use strict'

	assert = require 'assert'
	utils = require 'utils'

*Alignment* Alignment()
-----------------------

	module.exports = (Renderer, Impl, itemUtils) -> (ctor) -> class Font extends itemUtils.DeepObject
		@__name__ = 'Font'

*Font* Font()
-------------

		itemUtils.defineProperty
			constructor: ctor
			name: 'font'
			defaultValue: null
			valueConstructor: Font
			developmentSetter: (val) ->
				if val?
					assert.isObject val
			setter: (_super) -> (val) ->
				_super.call @, val

				if utils.isObject(val)
					{font} = @
					font.family = val.family if val.family?
					font.pixelSize = val.pixelSize if val.pixelSize?
					font.weight = val.weight if val.weight?
					font.wordSpacing = val.wordSpacing if val.wordSpacing?
					font.letterSpacing = val.letterSpacing if val.letterSpacing?
					font.italic = val.italic if val.italic?
				return

		constructor: (ref) ->
			super ref
			@_family = 'sans-serif'
			@_pixelSize = 14
			@_weight = 0.4
			@_wordSpacing = 0
			@_letterSpacing = 0
			@_italic = false

			Object.preventExtensions @

*String* Font.family = 'sans-serif'
-----------------------------------------

### *Signal* Font.onFamilyChange(*String* oldValue)

		`//<development>`
		checkingFamily = {}
		`//</development>`
		itemUtils.defineProperty
			constructor: @
			name: 'family'
			defaultValue: 'sans-serif'
			namespace: 'font'
			parentConstructor: ctor
			implementation: Impl["set#{ctor.__name__}FontFamily"]
			developmentSetter: (val) ->
				assert.isString val

				unless checkingFamily[val]
					checkingFamily[val] = true
					setTimeout =>
						if not Renderer.FontLoader.fonts[val]
							log.warn "Font `#{@family}` is not defined; use `FontLoader` to load a font"
			setter: (_super) -> (val) ->
				if typeof val is 'string'
					_super.call @, val.toLowerCase()
				else
					_super.call @, val

*Float* Font.pixelSize = 14
---------------------------------

### *Signal* Font.onPixelSizeChange(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'pixelSize'
			defaultValue: 14
			namespace: 'font'
			parentConstructor: ctor
			implementation: Impl["set#{ctor.__name__}FontPixelSize"]
			developmentSetter: (val) ->
				assert.isFloat val

*Float* Font.weight = 0.4
-------------------------------

### *Signal* Font.onWeightChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'weight'
			defaultValue: 0.4
			namespace: 'font'
			parentConstructor: ctor
			implementation: Impl["set#{ctor.__name__}FontWeight"]
			developmentSetter: (val) ->
				assert.isFloat val
				assert.operator val, '>=', 0
				assert.operator val, '<=', 1

*Float* Font.wordSpacing = 0
----------------------------------

### *Signal* Font.onWordSpacingChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'wordSpacing'
			defaultValue: 0
			namespace: 'font'
			parentConstructor: ctor
			implementation: Impl["set#{ctor.__name__}FontWordSpacing"]
			developmentSetter: (val) ->
				assert.isFloat val

*Float* Font.letterSpacing = 0
------------------------------------

### *Signal* Font.onLetterSpacingChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'letterSpacing'
			defaultValue: 0
			namespace: 'font'
			parentConstructor: ctor
			implementation: Impl["set#{ctor.__name__}FontLetterSpacing"]
			developmentSetter: (val) ->
				assert.isFloat val

*Boolean* Font.italic = false
-----------------------------------

### *Signal* Font.onItalicChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'italic'
			defaultValue: false
			namespace: 'font'
			parentConstructor: ctor
			implementation: Impl["set#{ctor.__name__}FontItalic"]
			developmentSetter: (val) ->
				assert.isBoolean val

		toJSON: ->
			family: @family
			pixelSize: @pixelSize
			weight: @weight
			wordSpacing: @wordSpacing
			letterSpacing: @letterSpacing
			italic: @italic
