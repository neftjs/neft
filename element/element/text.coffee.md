Text @virtual_dom
=================

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'

	{emitSignal} = signal.Emitter

	assert = assert.scope 'View.Element.Text'

	module.exports = (Element) ->

		class Text extends Element
			@__name__ = 'Text'
			@__path__ = 'File.Element.Text'

*Text* Text() : *Element*
-------------------------

			constructor: ->
				@_text = ''

				super()

			clone: ->
				clone = super()
				clone._text = @_text
				clone

*Signal* Text::onTextChange(*String* oldValue)
----------------------------------------------

			signal.Emitter.createSignal @, 'onTextChange'

*String* Text::text
-------------------

			utils.defineProperty @::, 'text', null, ->
				@_text
			, (value) ->
				assert.isString value

				old = @_text
				return if old is value

				# set text
				@_text = value

				# trigger event
				emitSignal @, 'onTextChange', old
