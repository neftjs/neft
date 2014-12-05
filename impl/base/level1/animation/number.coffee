'use strict'

utils = require 'utils'

{now} = Date

module.exports = (impl) ->
	{Types} = impl
	{PropertyAnimation} = Types

	reqSend = false
	pending = []

	vsync = ->
		reqSend = false

		i = 0; n = pending.length
		while i < n
			animation = pending[i]
			abstractData = animation.animation._data

			unless animation.running
				animation.progress = 0
				animation.animation.running = false
				pending[i] = utils.last(pending)
				pending.pop()
				n--
				continue

			animation.progress = Math.min 1, (now()-animation.startTime) / animation.duration

			if animation.progress is 1
				if animation.loop
					animation.startTime = now()
				else
					animation.running = false

			val = (animation.to - animation.from) * animation.progress + animation.from
			target = animation.target
			if not isNaN(val) and target
				setter = impl.utils.SETTER_METHODS_NAMES[animation.property]
				if not abstractData.updateProperty and setter
					impl[setter].call target, val
				else
					abstractData.updatePending = true
					target[animation.property] = val
					abstractData.updatePending = false

			i++

		if pending.length
			update()

	update = ->
		return if reqSend
		reqSend = true
		requestAnimationFrame vsync

	create: (animation) ->
		PropertyAnimation.create animation

		target = animation._impl
		target.startTime = 0
		target.play = ->
			pending.push @
			@startTime = now()
			update()