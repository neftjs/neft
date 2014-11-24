File.Element.Text
=================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

	module.exports = (Element) -> class Text extends Element

		@__name__ = 'Text'
		@__path__ = 'File.Element.Text'

*Text* Text()
-------------

**Extends:** `File.Element`

		constructor: ->
			utils.defineProperty @, '_text', utils.WRITABLE, ''

			super()

*String* Text::text
-------------------

		utils.defineProperty @::, 'text', null, ->
			@_text
		, (value) ->
			expect(value).toBe.string()

			old = @_text
			return if old is value

			# set text
			@_text = value

			# trigger event
			@trigger 'textChanged', old
