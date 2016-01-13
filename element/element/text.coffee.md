Text @virtual_dom
=================

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'

	{emitSignal} = signal.Emitter

	assert = assert.scope 'View.Element.Text'

	module.exports = (Element) -> class Text extends Element
		@__name__ = 'Text'
		@__path__ = 'File.Element.Text'

		JSON_ID = @JSON_ID = Element.JSON_CTORS.push(Text) - 1

		i = Element.JSON_LENGTH
		JSON_TEXT = i++
		JSON_LENGTH = @JSON_LENGTH = i

		@fromJSONArray = (arr, obj=new Text) ->
			Element.fromJSONArray arr, obj
			obj.text = arr[JSON_TEXT]
			obj

*Text* Text() : *Element*
-------------------------

		constructor: ->
			Element.call this

			@_text = ''

			`//<development>`
			if @constructor is Text
				Object.preventExtensions @
			`//</development>`

		clone: ->
			clone = new Text
			clone._text = @_text
			clone

*Signal* Text::onTextChange(*String* oldValue)
----------------------------------------------

		signal.Emitter.createSignal @, 'onTextChange'

*String* Text::text
-------------------

		opts = utils.CONFIGURABLE
		utils.defineProperty @::, 'text', opts, ->
			@_text
		, (value) ->
			assert.isString value

			old = @_text
			if old is value
				return false

			# set text
			@_text = value

			# trigger event
			emitSignal @, 'onTextChange', old
			Element.Tag.query.checkWatchersDeeply @

			true

		toJSON: (arr) ->
			unless arr
				arr = new Array JSON_LENGTH
				arr[0] = JSON_ID
			super arr
			arr[JSON_TEXT] = @text
			arr
