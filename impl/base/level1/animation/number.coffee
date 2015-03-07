'use strict'

utils = require 'utils'

{now} = Date

module.exports = (impl) ->
	{Types} = impl
	{PropertyAnimation} = Types

	reqSend = false
	pending = []
	nowTime = 0

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

		if pending.length
			update()
		return

	updateAnimation = (anim) ->
		data = anim._impl

		progress = (nowTime - data.startTime) / anim._duration
		if progress < 0
			progress = 0
		else if progress > 1
			progress = 1
		data.progress = progress

		val = (anim._to - anim._from) * progress + anim._from
		target = anim._target
		if val is val and target # isNaN hack
			if progress is 1 or anim._updateProperty or not data.propertySetter
				anim._updatePending = true
				target[anim._property] = val
				anim._updatePending = false
			else
				impl[data.propertySetter].call target, val
				if anim._updateData
					target[data.internalPropertyName] = val

		if progress is 1
			if anim._loop && anim._when
				data.startTime = nowTime + anim._delay
			else
				anim.running = false
		return

	update = ->
		return if reqSend
		reqSend = true
		requestAnimationFrame vsync

	playAnimation = (anim) ->
		nowTime = now()

		data = anim._impl
		pending.push anim
		data.startTime = nowTime + anim._delay
		update()

		updateAnimation anim

	DATA =
		type: 'number'
		startTime: 0

	DATA: DATA

	createData: impl.utils.createDataCloner PropertyAnimation.DATA, DATA

	create: (data) ->
		PropertyAnimation.create.call @, data

	playAnimation: do (_super = impl.playAnimation) -> ->
		_super.call @
		if @_impl.type is 'number'
			playAnimation @
		return
