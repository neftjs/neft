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
	'pointerWheel': (elem) ->
		if isFirefox
			'DOMMouseScroll'
		else
			'mousewheel'
	'keysPressed': 'keydown'
	'keysHold': 'keydown'
	'keysReleased': 'keyup'
	'keysInput': 'keypress'

if isTouch
	utils.merge SIGNALS,
		'pointerPressed': 'touchstart'
		'pointerReleased': 'touchend'
		'pointerEntered': 'touchstart'
		'pointerExited': 'touchend'
		'pointerMove': 'touchmove'

SIGNALS_CURSORS =
	'pointerClicked': 'pointer'

getMouseCoords = do ->
	getArgs = (target, e) ->
		rect = target.getBoundingClientRect()
		x: e.pageX - rect.left
		y: e.pageY - rect.top

	if isTouch
		(e) ->
			if e.touches?
				if e.touches.length
					getArgs e.currentTarget, e.touches[0]
				else
					getArgs e.currentTarget, e.changedTouches[0]
			else
				getArgs e.currentTarget, e
	else
		(e) ->
			getArgs e.currentTarget, e

getRestrictedMouseCoords = do ->
	getArgs = (target, e) ->
		rect = target.getBoundingClientRect()
		x = e.pageX - rect.left
		y = e.pageY - rect.top

		if x >= 0 and y >= 0 and x <= rect.width and y <= rect.height
			x: x
			y: y
		else
			false

	if isTouch
		(e) ->
			if e.touches?
				if e.touches.length
					getArgs e.currentTarget, e.touches[0]
				else
					getArgs e.currentTarget, e.changedTouches[0]
			else
				getArgs e.currentTarget, e
	else
		(e) ->
			getArgs e.currentTarget, e

pressedKeys = Object.create null

SPECIAL_KEY_CODES =
	32: 'Space'
	13: 'Enter'
	9: 'Tab'
	27: 'Escape'
	8: 'Backspace'
	16: 'Shift'
	17: 'Control'
	18: 'Alt'
	20: 'Caps Lock'
	144: 'Num Lock'
	37: 'Left'
	38: 'Up'
	39: 'Right'
	40: 'Down'
	45: 'Insert'
	46: 'Delete'
	36: 'Home'
	35: 'End'
	33: 'Page Up'
	34: 'Page Down'
	112: 'F1'
	113: 'F2'
	114: 'F3'
	115: 'F4'
	116: 'F5'
	117: 'F6'
	118: 'F7'
	119: 'F8'
	120: 'F9'
	121: 'F10'
	122: 'F11'
	123: 'F12'

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

	'pointerPressed': getRestrictedMouseCoords
	'pointerReleased': getMouseCoords
	'pointerClicked': getRestrictedMouseCoords
	'pointerMove': (e) ->
		if isTouch
			e.preventDefault()

		getRestrictedMouseCoords e
	'keysPressed': (e) ->
		e.preventDefault()

		code = e.which or e.keyCode
		key = SPECIAL_KEY_CODES[code] or String.fromCharCode(code)

		if pressedKeys[key]
			return false
		pressedKeys[key] = true

		key: key
	'keysHold': (e) ->
		e.preventDefault()

		code = e.which or e.keyCode
		key = SPECIAL_KEY_CODES[code] or String.fromCharCode(code)

		key: key
	'keysReleased': (e) ->
		code = e.which or e.keyCode
		key = SPECIAL_KEY_CODES[code] or String.fromCharCode(code)

		pressedKeys[key] = false

		key: key
	'keysInput': (e) ->
		code = e.charCode or e.which or e.keyCode
		text = String.fromCharCode(code)

		text: text

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

			# position
			if item._impl.isHot and transform3dSupported
				transform = "translate3d(#{item._x}px, #{item._y}px, 0) "
			else
				markAction item
				transform = "translate(#{item._x}px, #{item._y}px) "

			# rotation
			if item._rotation
				transform += "rotate(#{rad2deg(item._rotation)}deg) "

			# scale
			if item._scale isnt 1
				transform += "scale(#{item._scale}) "

			transform

		updateItem = (item, styles) ->
			data = item._impl
			style = data.elem.style

			if data.isHidden
				if styles & STYLE_OPACITY
					data.isHidden = false
					styles |= STYLE_ALL
				else
					return

			if styles & STYLE_TRANSFORM
				style[transformProp] = getTransforms item
			if styles & STYLE_WIDTH
				style.width = "#{item._width}px"
			if styles & STYLE_HEIGHT
				style.height = "#{item._height}px"
			if styles & STYLE_OPACITY
				style.opacity = item._opacity

				if item._opacity is 0
					data.isHidden = true

			return

		updateItems = ->
			pending = false
			nowTime = now()
			while queue.length
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
		anchors: null
		elem: null
		lastAction: 0
		hotActions: 0
		isHot: false
		isHidden: false
		linkElem: null

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

	setItemLinkUri: (val) ->
		unless @_impl.linkElem
			elem = @_impl.linkElem = document.createElement 'a'
			elem.setAttribute 'class', 'link'
			@_impl.elem.appendChild elem

		if @_impl.linkElem.getAttribute('href') isnt val
			@_impl.linkElem.setAttribute 'href', val
			@_impl.linkElem.style.display = if val isnt '' then 'block' else 'none'

	setItemMargin: (type, val) ->

	attachItemSignal: (ns, name, signalName) ->
		self = @
		{elem} = @_impl

		implName = SIGNALS[name]?(elem) or SIGNALS[name]

		# break if event is not supported (e.g. some events on touch devices)
		unless implName?
			return

		customFunc = (e) ->
			arg = SIGNALS_ARGS[name]? e
			if arg is false
				return

			if self[ns][signalName](arg) is signal.STOP_PROPAGATION
				e.stopPropagation()
			return

		if typeof implName is 'string'
			if ///^keys///.test name
				window.addEventListener implName, customFunc
			else
				elem.addEventListener implName, customFunc

		# cursor
		if cursor = SIGNALS_CURSORS[name]
			elem.style.cursor = cursor
