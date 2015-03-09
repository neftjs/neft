'use strict'

utils = require 'utils'

module.exports = (impl) ->
	{Types} = impl
	{PropertyAnimation} = Types
	{now} = Date

	reqSend = false
	pending = []
	nowTime = now()

	vsync = ->
		reqSend = false
		nowTime = now()

		i = 0; n = pending.length
		while i < n
			anim = pending[i]

			if anim._running
				updateAnimation anim
				i++
			else
				pending[i] = utils.last(pending)
				pending.pop()
				n--

		requestAnimationFrame vsync
		return
	requestAnimationFrame vsync

	updateAnimation = (anim) ->
		data = anim._impl

		progress = (nowTime - data.startTime) / anim._duration
		if progress < 0
			return
		else if progress > 1
			progress = 1
		data.progress = progress
		running = progress isnt 1 or (anim._loop && anim._when)

		val = (data.to - data.from) * progress + data.from
		target = anim._target
		if val is val and target # isNaN hack
			if not running or anim._updateProperty or not data.propertySetter
				anim._updatePending = true
				target[anim._property] = val
				anim._updatePending = false
			else
				impl[data.propertySetter].call target, val
				if anim._updateData
					target[data.internalPropertyName] = val

		if progress is 1
			if running
				data.startTime += anim._loopDelay + anim._duration
			else
				anim.running = false
		return

	DATA =
		type: 'number'
		startTime: 0
		from: 0
		to: 0

	DATA: DATA

	createData: impl.utils.createDataCloner PropertyAnimation.DATA, DATA

	create: (data) ->
		PropertyAnimation.create.call @, data

	playAnimation: do (_super = impl.playAnimation) -> ->
		_super.call @
		if @_impl.type is 'number'
			data = @_impl
			data.from = @_from
			data.to = @_to
			data.startTime = nowTime + @_playDelay
			pending.push @

			updateAnimation @
		return
