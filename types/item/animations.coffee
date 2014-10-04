'use strict'

expect = require 'expect'

module.exports = (Scope) -> class Animations
	constructor: (@item) ->
		expect(@item).toBe.any Scope.Item

	initialize: ->
		for name, animation of @ when @hasOwnProperty name
			if animation instanceof Scope.Animation
				@append animation
		null

	append: (animation) ->
		animation.target = @item
		@[animation.name] = animation