'use strict'

module.exports = (impl) ->
	getNormalizedEvent = do ->
		NORMALIZED_VALUE = 3

		isSlowContinuous = false

		event =
			deltaX: 0
			deltaY: 0

		getDeltas = (e) ->
			x = -e.deltaX*3 or e.wheelDeltaX ? 0
			y = -e.deltaY*3 or e.wheelDeltaY ? e.wheelDelta ? -e.detail*3 or 0

			if impl.utils.isFirefox and e.deltaMode is e.DOM_DELTA_LINE
				x *= 10
				y *= 10

			event.deltaX = x
			event.deltaY = y

		(e) ->
			getDeltas e

			# MAGIC!
			# It looks that Chrome on MacBook never gives values in range (-3, 3) as
			# it does Firefox which always send lower values
			if not isSlowContinuous
				delta = event.deltaX or event.deltaY or 3

				if (delta > 0 and delta < 3) or (delta < 0 and delta > -3)
					isSlowContinuous = true

			if isSlowContinuous
				event.deltaX *= NORMALIZED_VALUE
				event.deltaY *= NORMALIZED_VALUE

			event

	initDeviceNamespace: ->
		device = this
		{pointer} = this

		@_pixelRatio = window.devicePixelRatio or 1
		@_desktop = not ('ontouchstart' of window)
		@_phone = 'ontouchstart' of window and Math.min(@_width, @_height)/Math.max(@_width, @_height) < 0.75

		@_platform = do ->
			{userAgent} = navigator
			switch true
				when /Android/i.test(userAgent)
					'Android'
				when /iPhone|iPad|iPod/i.test(userAgent)
					'iOS'
				when /BlackBerry/i.test(userAgent)
					'BlackBerry'
				when /IEMobile|WPDesktop/i.test(userAgent)
					'WindowsPhone'
				when /Linux|X11/i.test(userAgent)
					'Linux'
				when /Windows/i.test(userAgent)
					'Windows'
				when /Mac_PowerPC|Macintosh/i.test(userAgent)
					'OSX'
				else
					'Unix'

		updatePointerEvent = (event) ->
			obj = event.touches?[0] or event.changedTouches?[0] or event

			pointer.x = obj.pageX
			pointer.y = obj.pageY
			return

		do ->
			touchEvents = 0
			onPointerPress = (e) ->
				if e instanceof TouchEvent
					touchEvents++
				else if e instanceof MouseEvent
					if touchEvents > 0
						touchEvents--
						return
				updatePointerEvent e
				device.onPointerPress.emit pointer
				return

			window.addEventListener 'mousedown', onPointerPress
			window.addEventListener 'touchstart', onPointerPress

		do ->
			touchEvents = 0
			onPointerRelease = (e) ->
				if e instanceof TouchEvent
					touchEvents++
				else if e instanceof MouseEvent
					if touchEvents > 0
						touchEvents--
						return
				updatePointerEvent e
				device.onPointerRelease.emit pointer
				return

			window.addEventListener 'mouseup', onPointerRelease
			window.addEventListener 'touchend', onPointerRelease

		do ->
			touchEvents = 0
			onPointerMove = (e) ->
				if e instanceof TouchEvent
					touchEvents++
				else if e instanceof MouseEvent
					if touchEvents > 0
						touchEvents--
						return
				updatePointerEvent e
				device.onPointerMove.emit pointer
				return

			window.addEventListener 'mousemove', onPointerMove
			window.addEventListener 'touchmove', onPointerMove

		onPointerWheel = (e) ->
			e.stopPropagation()
			event = getNormalizedEvent e
			pointer.deltaX = event.deltaX
			pointer.deltaY = event.deltaY
			device.onPointerWheel.emit pointer

		window.addEventListener impl.utils.pointerWheelEventName, onPointerWheel
