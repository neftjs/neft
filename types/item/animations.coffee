'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Renderer) -> class Animations
	@__name__ = 'Animations'

	constructor: (item) ->
		expect(item).toBe.any Renderer.Item

		utils.defineProperty @, '_item', null, item

		item.onReady ->
			for name, animation of @animations
				animation.target = @