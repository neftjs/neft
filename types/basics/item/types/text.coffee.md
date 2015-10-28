Text @class
====

#### Render a text @snippet

```style
Text {
  font.pixelSize: 30
  font.family: 'monospace'
  text: '<strong>Neft</strong> Renderer'
  color: 'blue'
}
```

	'use strict'

	assert = require 'assert'
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

			constructor: (component, opts) ->
				@_text = ''
				@_color = 'black'
				@_linkColor = 'blue'
				@_lineHeight = 1
				@_font = null
				@_alignment = null
				super component, opts

*String* Text::text
-------------------

#### @todo

HTML code in WebGL implementation

### *Signal* Text::onTextChange(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'text'
				defaultValue: ''
				implementation: Impl.setText
				setter: (_super) -> (val) ->
					_super.call @, val+''

*String* Text::color = 'black'
------------------------------

### *Signal* Text::onColorChange(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'color'
				defaultValue: 'black'
				implementation: Impl.setTextColor
				developmentSetter: (val) ->
					assert.isString val

*String* Text::linkColor = 'blue'
---------------------------------

### *Signal* Text::onLinkColorChange(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'linkColor'
				defaultValue: 'blue'
				implementation: Impl.setTextLinkColor
				developmentSetter: (val) ->
					assert.isString val

*Float* Text::lineHeight = 1
----------------------------

### *Signal* Text::onLineHeightChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'lineHeight'
				defaultValue: 1
				implementation: Impl.setTextLineHeight
				developmentSetter: (val) ->
					assert.isFloat val

*Alignment* Text::alignment
---------------------------

### *Signal* Text::onAlignmentChange(*Alignment* alignment)

			Renderer.Item.Alignment Text

*Font* Text::font
-----------------

### *Signal* Text::onFontChange(*String* property, *Any* oldValue)

			@Font = require('./text/font') Renderer, Impl, itemUtils
			@Font Text

		Text
