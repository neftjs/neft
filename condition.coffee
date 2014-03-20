'use strict'

[assert, utils] = ['assert', 'utils'].map require

module.exports = (File) -> class Condition

	constructor: (@node) ->

		assert node instanceof File.Element

	node: null

	execute: ->

		try

			eval unescape(@node.attrs.get('if')) + ' ? true : false'

		catch

			false