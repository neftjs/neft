TextInput @class
=========

#### @todo

Qml and WebGL implementations

	'use strict'

	assert = require 'assert'
	utils = require 'utils'
	signal = require 'signal'
	log = require 'log'

	log = log.scope 'Renderer', 'TextInput'

	module.exports = (Renderer, Impl, itemUtils) ->

*TextInput* TextInput() : *Renderer.Item*
-----------------------------------------

		class TextInput extends Renderer.Item
			@__name__ = 'TextInput'
			@__path__ = 'Renderer.TextInput'

			constructor: (component, opts) ->
				@_text = ''
				@_color = 'black'
				@_lineHeight = 1
				@_multiLine = false
				@_echoMode = 'normal'
				@_alignment = null
				@_font = null
				super component, opts
				@_width = 100
				@_height = 50

*Float* TextInput::width = 100
------------------------------

*Float* TextInput::height = 50
------------------------------

*String* TextInput::text
------------------------

### *Signal* TextInput::onTextChange(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'text'
				defaultValue: ''
				implementation: Impl.setTextInputText
				setter: (_super) -> (val) ->
					_super.call @, val+''

*String* TextInput::color = 'black'
-----------------------------------

### *Signal* TextInput::onColorChange(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'color'
				defaultValue: 'black'
				implementation: Impl.setTextInputColor
				developmentSetter: (val) ->
					assert.isString val

*Float* TextInput::lineHeight = 1
---------------------------------

### *Signal* TextInput::onLineHeightChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'lineHeight'
				defaultValue: 1
				implementation: Impl.setTextInputLineHeight
				developmentSetter: (val) ->
					assert.isFloat val

*Boolean* TextInput::multiLine = false
--------------------------------------

### *Signal* TextInput::onMultiLineChange(*Boolean* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'multiLine'
				defaultValue: false
				implementation: Impl.setTextInputMultiLine
				developmentSetter: (val) ->
					assert.isBoolean val

*String* TextInput::echoMode = 'normal'
---------------------------------------

Accepts 'normal' and 'password'.

### *Signal* TextInput::onEchoModeChange(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'echoMode'
				defaultValue: 'normal'
				implementation: Impl.setTextInputEchoMode
				developmentSetter: (val) ->
					assert.isString val
					assert.ok val in ['', 'normal', 'password']
				setter: (_super) -> (val) ->
					val ||= 'normal'
					val = val.toLowerCase()
					_super.call @, val

*Alignment* TextInput::alignment
--------------------------------

### *Signal* TextInput::onAlignmentChange(*Alignment* alignment)

			Renderer.Item.Alignment TextInput

*Font* TextInput::font
----------------------

### *Signal* TextInput::onFontChange(*String* property, *Any* oldValue)

			Renderer.Text.Font TextInput

		TextInput
