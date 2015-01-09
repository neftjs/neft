File.Element.Text
=================

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	Emitter = require '../emitter'

	assert = assert.scope 'View.Element.Text'

	module.exports = (Element) -> class Text extends Element
		@__name__ = 'Text'
		@__path__ = 'File.Element.Text'

*Text* Text()
-------------

**Extends:** `File.Element`

		constructor: ->
			@_text = ''

			super()

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
			Emitter.trigger @, Emitter.TEXT_CHANGED, old
