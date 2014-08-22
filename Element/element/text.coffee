'use strict'

[expect, signal] = ['expect', 'signal'].map require

module.exports = (Element) -> class Text extends Element

	@__name__ = 'Text'
	@__path__ = 'File.Element.Text'

	constructor: ->

		super()

		@_text = ''

	Object.defineProperties @::,

		text:

			get: -> @_text

			set: (value) ->

				expect(value).toBe.string()

				old = @_text
				return if old is value

				# set text
				@_text = value

				# call observers
				if Element.OBSERVE and @hasOwnProperty('onTextChanged')
					@onTextChanged old

	signal.defineGetter @::, 'onTextChanged'
