TextInput @class
=========

#### @todo

Qml and WebGL implementations

#### @todo

*alignment.vertical* other than *top* looks broken at CSS implementation

	'use strict'

	assert = require 'assert'
	utils = require 'utils'
	signal = require 'signal'
	log = require 'log'

	log = log.scope 'Renderer', 'TextInput'

	module.exports = (Renderer, Impl, itemUtils) ->

*TextInput* TextInput() : *Renderer.Text*
-----------------------------------------

		class TextInput extends Renderer.Text
			@__name__ = 'TextInput'
			@__path__ = 'Renderer.TextInput'

			constructor: ->
				@_multiLine = false
				super()
				@_width = 200
				@_height = 100

*Float* TextInput::width = 200
------------------------------

*Float* TextInput::height = 50
------------------------------

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
