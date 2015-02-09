File.Element.Text
=================

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	signal = require 'signal'

	SignalsEmitter = signal.Emitter

	assert = assert.scope 'View.Element.Text'

	module.exports = (Element) ->

		class Text extends Element
			@__name__ = 'Text'
			@__path__ = 'File.Element.Text'

*Text* Text() : *File.Element*
------------------------------

			constructor: ->
				@_text = ''

				super()

			clone: ->
				clone = super()
				clone._text = @_text
				clone

*String* Text::text
-------------------

			SignalsEmitter.createSignal @, 'textChanged'

			utils.defineProperty @::, 'text', null, ->
				@_text
			, (value) ->
				assert.isString value

				old = @_text
				return if old is value

				# set text
				@_text = value

				# trigger event
				@textChanged old
