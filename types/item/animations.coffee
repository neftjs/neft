'use strict'

module.exports = (Scope) -> class Animations
	item: ''

	initialize: ->
		for name, animation of @ when @hasOwnProperty name
			if animation instanceof Scope.Animation
				@append animation
		null

	append: (animation) ->
		animation.target = @item
		@[animation.name] = animation