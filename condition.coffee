'use strict'

{assert} = console

module.exports = (File) -> class Condition

	@__name__ = 'Condition'
	@__path__ = 'File.Condition'

	constructor: (@node) ->

		assert node instanceof File.Element

	node: null

	execute: ->

		try

			eval unescape(@node.attrs.get('if')) + ' ? true : false'

		catch

			false