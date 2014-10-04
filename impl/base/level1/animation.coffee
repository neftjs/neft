'use strict'

module.exports = (impl) ->
	{animations} = impl

	create: (id, target) ->
		target.running = false
		target.loop = false

	getAnimationRunning: (id) ->
		animations[id].running

	getAnimationLoop: (id) ->
		animations[id].loop

	setAnimationLoop: (id, val) ->
		animations[id].loop = val

	playAnimation: (id) ->
		animation = animations[id]
		animation.running = true
		animation.play()

	stopAnimation: (id) ->
		animations[id].running = false