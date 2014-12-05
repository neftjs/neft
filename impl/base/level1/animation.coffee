'use strict'

module.exports = (impl) ->
	create: (animation) ->
		target = animation._impl
		target.animation = animation
		target.running = false
		target.loop = false

	setAnimationLoop: (val) ->
		@_impl.loop = val

	playAnimation: (id) ->
		@_impl.running = true
		@_impl.play()

	stopAnimation: (id) ->
		@_impl.running = false
