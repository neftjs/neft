'use strict'

utils = require 'utils'

# get transform CSS property name
transformProp = do ->
	prefix = do ->
		tmp = document.createElement 'div'
		return 't' if tmp.style.transform?
		return 'webkitT' if tmp.style.webkitTransform?
		return 'mozT' if tmp.style.mozTransform?
		return 'msT' if tmp.style.msTransform?

	"#{prefix}ransform"

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

rad2deg = (rad) ->
	rad * 180/Math.PI

{now} = Date

isTouch = 'ontouchstart' of window

SIGNALS =
	'pointerClicked': 'click'
	'pointerPressed': 'mousedown'
	'pointerReleased': 'mouseup'
	'pointerEntered': 'mouseover'
	'pointerExited': 'mouseout'
	'pointerMove': 'mousemove'
	'pointerWheel': (elem, func) ->
		if isFirefox
			'DOMMouseScroll'
		else
			'mousewheel'

if isTouch
	utils.merge SIGNALS,
		'pointerPressed': 'touchstart'
		'pointerReleased': 'touchend'
		'pointerEntered': null
		'pointerExited': null
		'pointerMove': 'touchmove'

SIGNALS_CURSORS =
	'pointerClicked': 'pointer'

mouseCoordsArgs = do ->
	getArgs = (e) ->
		x: e.screenX
		y: e.screenY

	if isTouch
		(e) ->
			if e.touches.length
				getArgs e.touches[0]
			else
				getArgs e.changedTouches[0]
	else
		getArgs

SIGNALS_ARGS =
	'pointerWheel': do ->
		REQUIRED_CHECKS = 200
		REQUIRED_DELTA_CHECKS = 1000
		NORMALIZED_VALUE = 120

		checks = 0
		lastX = lastY = 0

		xDeltaChecks = 1
		yDeltaChecks = 1
		averageX = NORMALIZED_VALUE
		averageY = NORMALIZED_VALUE

		getDeltas = (e) ->
			e.preventDefault()

			x = e.wheelDeltaX || 0
			y = e.wheelDelta || -e.detail

			if x isnt 0 and xDeltaChecks < REQUIRED_DELTA_CHECKS
				averageX = (averageX * xDeltaChecks + Math.abs(x)) / ++xDeltaChecks

			if y isnt 0 and yDeltaChecks < REQUIRED_DELTA_CHECKS
				averageY = (averageY * yDeltaChecks + Math.abs(y)) / ++yDeltaChecks

			x *= NORMALIZED_VALUE / averageX
			y *= NORMALIZED_VALUE / averageY

			x: x
			y: y

		normalizedWheel = (e) ->
			r = getDeltas e

			r.x = Math.max(-1, Math.min(1, r.x)) * NORMALIZED_VALUE
			r.y = Math.max(-1, Math.min(1, r.y)) * NORMALIZED_VALUE

			r

		continuousWheel = getDeltas

		(e) ->
			x = e.wheelDeltaX || 0
			y = e.wheelDelta || -e.detail

			# check whether we check it enough
			if checks < REQUIRED_CHECKS
				absX = Math.abs x
				absY = Math.abs y

				# check if it's not first validation
				if checks > 0
					# check whether values change in time
					if absX isnt lastX or absY isnt lastY
						# always use continuous wheel
						SIGNALS_ARGS.pointerWheel = continuousWheel

				# save current deltas to compare it in the next check
				lastX = absX
				lastY = absY
				checks++
			else
				# values don't change, always use normalized wheel
				SIGNALS_ARGS.pointerWheel = normalizedWheel

			# use normalized wheel temporary
			normalizedWheel e

	'pointerPressed': mouseCoordsArgs
	'pointerReleased': mouseCoordsArgs
	'pointerMove': mouseCoordsArgs

HOT_MAX_TIME = 120
HOT_MAX_ACTIONS = 100

module.exports = (impl) ->
	updateTransforms = (item) ->
		transform = ''
		if item._impl.isHot
			transform += "translate3d(#{item.x}px, #{item.y}px, 0) "
		if item.rotation
			transform += "rotate(#{rad2deg(item.rotation)}deg) "
		if item.scale isnt 1
			transform += "scale(#{item.scale}) "

		item._impl.elem.style[transformProp] = transform

	markAction = (item) ->
		storage = item._impl

		if now() - storage.lastAction < HOT_MAX_TIME
			if storage.hotActions++ > HOT_MAX_ACTIONS
				{style, id} = storage.elem
				storage.isHot = true
				style.left = style.top = '0'
				updateTransforms item
		else
			storage.lastAction = now()

	create: (item) ->
		storage = item._impl

		storage.elem ?= document.createElement 'div'

		storage.lastAction = now()
		storage.hotActions = 0
		storage.isHot = false

	setItemParent: (val) ->
		{elem} = @_impl

		unless val
			elem.parentElement?.removeChild elem
			return

		val._impl.elem.appendChild elem

	setItemVisible: (val) ->
		@_impl.elem.style.display = if val then 'inherit' else 'none'

	setItemClip: (val) ->
		@_impl.elem.style.overflow = if val then 'hidden' else 'visible'

	setItemWidth: (val) ->
		@_impl.elem.style.width = "#{val}px"

	setItemHeight: (val) ->
		@_impl.elem.style.height = "#{val}px"

	setItemX: (val) ->
		if @_impl.isHot
			updateTransforms @
		else
			@_impl.elem.style.left = "#{val}px"
			markAction @

	setItemY: (val) ->
		if @_impl.isHot
			updateTransforms @
		else
			@_impl.elem.style.top = "#{val}px"
			markAction @

	setItemZ: (val) ->
		@_impl.elem.style.zIndex = if val is 0 then 'inherit' else val

	setItemScale: (val) ->
		updateTransforms @

	setItemRotation: (val) ->
		updateTransforms @

	setItemOpacity: (val) ->
		@_impl.elem.style.opacity = val

	setItemMargin: (type, val) ->

	attachItemSignal: (name, func) ->
		{elem} = @_impl

		signal = SIGNALS[name]?(elem, func) or SIGNALS[name]

		# break if event is not supported (e.g. some events on touch devices)
		unless signal?
			return

		customFunc = (e) ->
			arg = SIGNALS_ARGS[name]? e
			func arg

		if typeof signal is 'string'
			elem.addEventListener signal, customFunc

		# cursor
		if cursor = SIGNALS_CURSORS[name]
			elem.style.cursor = cursor