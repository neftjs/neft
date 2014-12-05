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

			unless animation.running
				animation.animation.running = false
				animation.progress = 0
				pending[i] = utils.last(pending)
				pending.pop()
				n--
				break if i+1 is n

			animation.progress = Math.min 1, (now()-animation.startTime) / animation.duration

			if animation.progress is 1
				if animation.loop
					animation.startTime = now()
				else
					animation.running = false

			val = (animation.to - animation.from) * animation.progress + animation.from
			if not isNaN(val)
				animation.target[animation.property] = val

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
		target.progress = 0
		target.startTime = 0
		target.play = ->
			pending.push @
			@startTime = now()
			update()