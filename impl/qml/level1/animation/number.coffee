'use strict'

utils = require 'utils'

module.exports = (impl) ->
	{now} = Date

	createElem = do ->
		QML_ANIMATORS =
			x: 'XAnimator'
			y: 'YAnimator'
			scale: 'ScaleAnimator'
			rotation: 'RotationAnimator'
			opacity: 'OpacityAnimator'

		(anim) ->
			if anim.updateProperty
				qmlType = 'NumberAnimation'
			else
				qmlType = QML_ANIMATORS[anim.property] or 'NumberAnimation'
			isAnimation = qmlType is 'NumberAnimation'

			qmlStr =
				"SequentialAnimation {" +
					"id: main;" +
					"property var target: null;" +
					"property real from;" +
					"property real to;" +
					"property real playDelay: 0;" +
					"property real loopDelay: 0;" +
					"property var duration: 0;" +
					"property bool loop: false;" +
					"PauseAnimation { duration: main.playDelay }" +
					"SequentialAnimation {" +
						"loops: main.loop ? Animation.Infinite : 1;" +
						"#{qmlType} {" +
							"id: animation;" +
							"target: main.target;" +
							(if isAnimation then "property: '#{anim._property}';" else "") +
							"duration: main.duration;" +
							"from: main.from;" +
							"to: main.to;" +
						"}" +
						"PauseAnimation { duration: main.loopDelay }" +
					"}" +
				"}"

			impl.utils.createQmlObject qmlStr, __stylesWindow

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
			data.progress = 1
			return
		else if progress > 1
			progress = 1
		data.progress = progress
		running = progress isnt 1 or (anim._running and anim._loop && anim._when)

		target = anim._target
		if anim._updateData
			val = (data.to - data.from) * progress + data.from

			if anim._updateProperty
				anim._updatePending = true
				target[anim._property] = val
				anim._updatePending = false
			else
				target[data.internalPropertyName] = val

		if progress is 1
			if running
				data.startTime += anim._loopDelay + anim._duration
		return

	onStarted = ->
		@_impl.startTime = nowTime + @_playDelay
		updateAnimation @
		pending.push @
	onStopped = ->
		@running = false
		updateAnimation @

	DATA =
		type: 'number'
		accepts: false
		running: false
		startTime: 0
		from: 0
		to: 0

	DATA: DATA

	createData: impl.utils.createDataCloner 'PropertyAnimation', DATA

	create: (data) ->
		impl.Types.PropertyAnimation.create.call @, data

	playAnimation: do (_super = impl.playAnimation) -> ->
		data = @_impl
		if data.type isnt 'number' or not data.propertySetter
			data.accepts = false
			_super.call @
			return

		data.accepts = true

		if data.dirty
			data.dirty = false
			data.elem?.destroy()
			data.elem = createElem @
			data.elem.started.connect @, onStarted
			data.elem.stopped.connect @, onStopped
		{elem} = data

		elem.target = @_target._impl.elem
		elem.playDelay = @_playDelay
		elem.loopDelay = @_loopDelay
		elem.duration = @_duration
		elem.loop = @_loop
		if @_property is 'rotation'
			elem.from = impl.utils.radToDeg @_from
			elem.to = impl.utils.radToDeg @_to
		else
			elem.from = @_from
			elem.to = @_to

		impl[data.propertySetter].call @_target, elem.from

		data.startTime = nowTime + @_playDelay
		data.from = @_from
		data.to = @_to
		elem.start()

		return

	stopAnimation: do (_super = impl.stopAnimation) -> ->
		data = @_impl
		if not data.accepts or data.type isnt 'number'
			_super.call @
			return

		data.elem?.stop()
		return
