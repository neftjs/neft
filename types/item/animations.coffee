'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Renderer) -> class Animations
	constructor: (item) ->
		expect(item).toBe.any Renderer.Item

		utils.defProp @, '_item', '', item

	initialize: ->
		for name, animation of @ when @hasOwnProperty name
			if animation instanceof Renderer.Animation
				@append animation
		null

	append: (animation) ->
		animation.target = @_item
		@[animation.name] = animation