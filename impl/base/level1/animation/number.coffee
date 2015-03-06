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

			if animation.running
				updateAnimation animation

				i++
			else
				animation.progress = 0
				animation.animation.running = false
				pending[i] = utils.last(pending)
				pending.pop()
				n--

		if pending.length
			update()

	updateAnimation = (animation) ->
		abstractAnimation = animation.animation

		progress = animation.progress = Math.max 0, Math.min 1, (now()-animation.startTime) / animation.duration

		if progress is 1
			if animation.loop && abstractAnimation._when
				animation.startTime = now()
			else
				animation.running = false
				abstractAnimation.running = false

		val = (animation.to - animation.from) * progress + animation.from
		target = animation.target
		if not isNaN(val) and target
			setter = impl.utils.SETTER_METHODS_NAMES[animation.property]
			if progress isnt 1 and not abstractAnimation._updateProperty and setter
				impl[setter].call target, val
			else
				abstractAnimation._updatePending = true
				target[animation.property] = val
				abstractAnimation._updatePending = false
		return

	update = ->
		return if reqSend
		reqSend = true
		requestAnimationFrame vsync

	DATA =
		from: 0
		to: 0
		startTime: 0
		play: null

	DATA: DATA

	createData: impl.utils.createDataCloner PropertyAnimation.DATA, DATA

	create: (data) ->
		PropertyAnimation.create.call @, data

		data.play = ->
			pending.push @
			@startTime = now() + @delay
			update()
			updateAnimation @
