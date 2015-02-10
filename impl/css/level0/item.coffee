'use strict'

utils = require 'utils'
signal = require 'signal'

# get transform CSS property name
transformProp = do ->
	prefix = do ->
		tmp = document.createElement 'div'
		return 't' if tmp.style.transform?
		return 'webkitT' if tmp.style.webkitTransform?
		return 'mozT' if tmp.style.mozTransform?
		return 'msT' if tmp.style.msTransform?

	if prefix
		"#{prefix}ransform"

transform3dSupported = do ->
	tmp = document.createElement 'div'
	tmp.style[transformProp] = 'translate3d(1px,1px,0)'
	tmp.style[transformProp].indexOf('translate3d') isnt -1

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

rad2deg = (rad) ->
	rad * 180/Math.PI

{now} = Date

isTouch = 'ontouchstart' of window

SIGNALS =
	'pointerClicked': 'click'
	'pointerPressed': 'mousedown'
	'pointerReleased': 'mouseup'
	'pointerEntered': 'mouseenter'
	'pointerExited': 'mouseleave'
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
		'pointerEntered': 'touchstart'
		'pointerExited': 'touchend'
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
		NORMALIZED_VALUE = 260

		checks = 0
		lastX = lastY = 0

		isSlowContinuous = false

		getDeltas = (e) ->
			e.preventDefault()

			x = e.wheelDeltaX || 0
			y = e.wheelDelta || -e.detail

			x: x
			y: y

		normalizedWheel = (e) ->
			r = getDeltas e

			r.x = Math.max(-1, Math.min(1, r.x)) * NORMALIZED_VALUE
			r.y = Math.max(-1, Math.min(1, r.y)) * NORMALIZED_VALUE

			r

		continuousWheel = (e) ->
			deltas = getDeltas e

			# MAGIC!
			# It looks that Chrome on MacBook never gives values in range (-3, 3) as
			# it does Firefox which always sends lower values
			if not isSlowContinuous
				delta = deltas.x or deltas.y or 3

				if (delta > 0 and delta < 3) or (delta < 0 and delta > -3)
					isSlowContinuous = true

			if isSlowContinuous
				deltas.x *= 25
				deltas.y *= 25

			deltas

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
						return continuousWheel e

				# save current deltas to compare it in the next check
				lastX = absX
				lastY = absY
				checks++
			else
				# values don't change, always use normalized wheel
				SIGNALS_ARGS.pointerWheel = normalizedWheel
				return normalizedWheel e

			# use normalized wheel temporary
			event = normalizedWheel e

			# smooth first events
			if checks < 4
				event = normalizedWheel e
				event.x /= 10
				event.y /= 10
				event
			else
				event

	'pointerPressed': (e) ->
		if isTouch
			e.preventDefault()

		mouseCoordsArgs e
	'pointerReleased': mouseCoordsArgs
	'pointerClicked': mouseCoordsArgs
	'pointerEntered': mouseCoordsArgs
	'pointerExited': mouseCoordsArgs
	'pointerMove': (e) ->
		if isTouch
			e.preventDefault()

		mouseCoordsArgs e

HOT_MAX_TIME = 1000
HOT_MAX_ACTIONS = 4

module.exports = (impl) ->

	STYLE_TRANSFORM = 1<<0
	STYLE_WIDTH = 1<<1
	STYLE_HEIGHT = 1<<2
	STYLE_OPACITY = 1<<3
	STYLE_ALL = (1<<4)-1

	nowTime = now()

	updateStyles = do ->
		pending = false
		queue = []
		queueItems = {}

		getTransforms = (item) ->
			transform = ''
			data = item._data
			target = item._impl

			# position
			if item._impl.isHot and transform3dSupported
				transform = "translate3d(#{data.x}px, #{data.y}px, 0) "
			else
				markAction item
				transform = "translate(#{data.x}px, #{data.y}px) "

			# rotation
			if data.rotation
				transform += "rotate(#{rad2deg(data.rotation)}deg) "

			# scale
			if data.scale isnt 1
				transform += "scale(#{data.scale}) "

			transform

		updateItem = (item, styles) ->
			data = item._data
			target = item._impl
			style = target.elem.style

			if target.isHidden
				if styles & STYLE_OPACITY
					target.isHidden = false
					styles |= STYLE_ALL
				else
					return

			if styles & STYLE_TRANSFORM
				style[transformProp] = getTransforms item
			if styles & STYLE_WIDTH
				style.width = "#{data.width}px"
			if styles & STYLE_HEIGHT
				style.height = "#{data.height}px"
			if styles & STYLE_OPACITY
				style.opacity = data.opacity

				if data.opacity is 0
					target.isHidden = true

			return

		updateItems = ->
			pending = false
			nowTime = now()
			n = queue.length
			while n--
				item = queue.pop()
				updateItem item, queueItems[item.__hash__]
				queueItems[item.__hash__] = 0
			return

		(elem, style) ->
			styles = queueItems[elem.__hash__]

			unless styles
				queue.push elem

			queueItems[elem.__hash__] = (styles |= style)

			unless pending
				pending = true
				if isTouch
					requestAnimationFrame updateItems
				else
					setTimeout updateItems, 8
			return

	markAction = (item) ->
		storage = item._impl

		if nowTime - storage.lastAction < HOT_MAX_TIME
			if storage.hotActions++ > HOT_MAX_ACTIONS
				{style, id} = storage.elem
				storage.isHot = true
		else
			storage.hotActions = 0
			storage.lastAction = nowTime

	DATA =
		bindings: null
		elem: null
		lastAction: 0
		hotActions: 0
		isHot: false
		isHidden: false

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		data.elem ?= document.createElement 'div'
		data.lastAction = nowTime

	setItemParent: (val) ->
		{elem} = @_impl

		unless val
			elem.parentElement?.removeChild elem
			return

		val._impl.elem.appendChild elem

	setItemVisible: (val) ->
		@_impl.elem.style.display = if val then 'inline' else 'none'

	setItemClip: (val) ->
		@_impl.elem.style.overflow = if val then 'hidden' else 'visible'

	setItemWidth: (val) ->
		updateStyles @, STYLE_WIDTH

	setItemHeight: (val) ->
		updateStyles @, STYLE_HEIGHT

	setItemX: (val) ->
		updateStyles @, STYLE_TRANSFORM

	setItemY: (val) ->
		updateStyles @, STYLE_TRANSFORM

	setItemZ: (val) ->
		@_impl.elem.style.zIndex = if val is 0 then 'auto' else val

	setItemScale: (val) ->
		updateStyles @, STYLE_TRANSFORM

	setItemRotation: (val) ->
		updateStyles @, STYLE_TRANSFORM

	setItemOpacity: (val) ->
		updateStyles @, STYLE_OPACITY

	setItemMargin: (type, val) ->

	attachItemSignal: (name, func) ->
		{elem} = @_impl

		signalName = SIGNALS[name]?(elem, func) or SIGNALS[name]

		# break if event is not supported (e.g. some events on touch devices)
		unless signalName?
			return

		customFunc = (e) =>
			arg = SIGNALS_ARGS[name]? e
			result = func.call @, arg
			if result is signal.STOP_PROPAGATION
				e.stopPropagation()
			result

		if typeof signalName is 'string'
			elem.addEventListener signalName, customFunc

		# cursor
		if cursor = SIGNALS_CURSORS[name]
			elem.style.cursor = cursor
