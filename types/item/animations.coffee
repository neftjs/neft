'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope) -> class Animations
	constructor: (item) ->
		expect(item).toBe.any Scope.Item

		utils.defProp @, '_item', '', item

	initialize: ->
		for name, animation of @ when @hasOwnProperty name
			if animation instanceof Scope.Animation
				@append animation
		null

	append: (animation) ->
		animation.target = @_item
		@[animation.name] = animation