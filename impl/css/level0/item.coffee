'use strict'

utils = require 'utils'
log = require 'log'
signal = require 'signal'

log = log.scope 'Renderer', 'CSS Implementation'

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
	'pointerMoved': 'mousemove'
	'pointerWheel': do ->
		if 'onwheel' of document.createElement("div")
			'wheel'
		else if document.onmousewheel isnt undefined
			'mousewheel'
		else
			'MozMousePixelScroll'
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
		'pointerMoved': 'touchmove'

SIGNALS_CURSORS =
	'pointerClicked': 'pointer'

lastEvent = null
movementX = movementY = 0
getMouseEvent = (e) ->
	if isTouch and e.touches?
		if e.touches.length
			e = e.touches[0]
		else
			e = e.changedTouches[0]

	if lastEvent isnt e
		if lastEvent?
			movementX = e.pageX - lastEvent.pageX
			movementY = e.pageY - lastEvent.pageY

		lastEvent = e

	movementX: movementX
	movementY: movementY

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
		NORMALIZED_VALUE = 3

		isSlowContinuous = false

		getDeltas = (e) ->
			console.log e.wheelDeltaY, -e.deltaY*3, e.wheelDelta, -e.detail*3
			x = e.wheelDeltaX ? -e.deltaX*3 or 0
			y = e.wheelDeltaY ? -e.deltaY*3 or e.wheelDelta ? -e.detail*3 or 0

			if isFirefox and e.deltaMode is e.DOM_DELTA_LINE
				x *= 25
				y *= 25

			deltaX: x
			deltaY: y

		(e) ->
			deltas = getDeltas e

			# MAGIC!
			# It looks that Chrome on MacBook never gives values in range (-3, 3) as
			# it does Firefox which always sends lower values
			if not isSlowContinuous
				delta = deltas.x or deltas.y or 3

				if (delta > 0 and delta < 3) or (delta < 0 and delta > -3)
					isSlowContinuous = true

			if isSlowContinuous
				deltas.x *= NORMALIZED_VALUE
				deltas.y *= NORMALIZED_VALUE

			deltas

	'pointerPressed': getMouseEvent
	'pointerReleased': getMouseEvent
	'pointerClicked': getMouseEvent
	'pointerMoved': getMouseEvent
	'keysPressed': (e) ->
		code = e.which or e.keyCode
		key = SPECIAL_KEY_CODES[code] or String.fromCharCode(code)

		if pressedKeys[key] and pressedKeys[key] isnt e
			return false
		pressedKeys[key] = e

		key: key
	'keysHold': (e) ->
		code = e.which or e.keyCode
		key = SPECIAL_KEY_CODES[code] or String.fromCharCode(code)

		key: key
	'keysReleased': (e) ->
		code = e.which or e.keyCode
		key = SPECIAL_KEY_CODES[code] or String.fromCharCode(code)

		pressedKeys[key] = null

		key: key
	'keysInput': (e) ->
		code = e.charCode or e.which or e.keyCode
		text = String.fromCharCode(code)

		text: text

HOT_MAX_TIME = 1000
HOT_MAX_ACTIONS = 4
USE_GPU = true

# if ///^mac///i.test(navigator.platform) and devicePixelRatio > 1
# 	USE_GPU = false

module.exports = (impl) ->
	LAYER_MIN_OPERATIONS = 2
	LAYER_GC_DELAY = 1000
	layers = []

	mouseActiveItem = null

	# window.addEventListener SIGNALS.pointerWheel, (e) ->
	# 	e.preventDefault()
	# , true

	window.addEventListener SIGNALS.pointerReleased, (e) ->
		mouseActiveItem ?= impl.window?.pointer
		event = getMouseEvent e
		mouseActiveItem?.released event
		mouseActiveItem = null
		document.body.setAttribute 'class', ''
		return

	window.addEventListener SIGNALS.pointerMoved, (e) ->
		mouseActiveItem ?= impl.window?.pointer
		event = getMouseEvent e
		mouseActiveItem?.moved event
		return

	# window.addEventListener 'touchmove', (e) ->
	# 	e.preventDefault()
	# , true

	window.addEventListener SIGNALS.keysReleased, SIGNALS_ARGS.keysReleased

	if USE_GPU
		setInterval ->
			i = 0
			n = layers.length
			while i < n
				layer = layers[i]
				layer.operations = (layer.operations * 0.5)|0

				if layer.operations < LAYER_MIN_OPERATIONS
					layer.operations = 0

					if i is n-1
						layers.pop()
					else
						layers[i] = layers.pop()
					n--

					if layer.isLayer
						layer.elem.setAttribute 'class', ''
						layer.isLayer = false
						updateTransforms layer
						layer.operations = 0
						console.assert layer.isLayer is false

					layer.isInLayers = false
				else
					i++
			return
		, LAYER_GC_DELAY

	{round} = Math

	updateTransforms = (data) ->
		transform = ''

		if USE_GPU
			unless data.isInLayers
				layers.push data
				data.isInLayers = true

			if data.operations >= LAYER_MIN_OPERATIONS and not data.isLayer
				data.elem.setAttribute 'class', 'layer'
				data.isLayer = true
			else
				data.operations++

		# position
		if data.isLayer
			transform = "translate3d(#{data.x}px, #{data.y}px, 0) "
		else
			transform = "translate(#{data.x}px, #{data.y}px) "

		# rotation
		if data.rotation
			transform += "rotate(#{rad2deg(data.rotation)}deg) "

		# scale
		if data.scale isnt 1
			transform += "scale(#{data.scale}) "

		data.elemStyle[transformProp] = transform
		return

	NOP = ->

	DATA = utils.merge
		bindings: null
		anchors: null
		elem: null
		elemStyle: null
		linkElem: null
		x: 0
		y: 0
		rotation: 0
		scale: 1
		parent: null
		update: null
		mozFontSubpixel: true
		isLayer: false
		isInLayers: false
		operations: 0
	, impl.utils.fill.DATA

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		data.update ?= NOP
		data.elem ?= document.createElement 'div'
		data.elemStyle = data.elem.style

	setItemParent: (val) ->
		self = @
		{elem} = @_impl

		@_impl.parent?._impl.update.call @_impl.parent

		if val
			val._impl.elem.appendChild elem
			val._impl.update.call val
		else
			elem.parentElement?.removeChild elem
		@_impl.parent = val

		return

	setItemVisible: (val) ->
		@_impl.elemStyle.display = if val then 'inline' else 'none'
		@_parent?._impl.update.call @_parent
		return

	setItemClip: (val) ->
		@_impl.elemStyle.overflow = if val then 'hidden' else 'visible'
		return

	setItemWidth: (val) ->
		val = round val
		@_impl.elemStyle.width = "#{val}px"
		@_parent?._impl.update.call @_parent
		@_impl.update.call @
		return

	setItemHeight: (val) ->
		val = round val
		@_impl.elemStyle.height = "#{val}px"
		@_parent?._impl.update.call @_parent
		@_impl.update.call @
		return

	setItemX: (val) ->
		@_impl.x = round val
		updateTransforms @_impl
		return

	setItemY: (val) ->
		@_impl.y = round val
		updateTransforms @_impl
		return

	setItemZ: (val) ->
		@_impl.elemStyle.zIndex = if val is 0 then 'auto' else val
		return

	setItemScale: (val) ->
		@_impl.scale = val
		updateTransforms @_impl
		return

	setItemRotation: (val) ->
		@_impl.rotation = val
		updateTransforms @_impl
		return

	setItemOpacity: (val) ->
		@_impl.elemStyle.opacity = val
		return

	setItemLinkUri: (val) ->
		unless @_impl.linkElem
			elem = @_impl.linkElem = document.createElement 'a'
			elem.setAttribute 'class', 'link'
			@_impl.elem.appendChild elem

		if @_impl.linkElem.getAttribute('href') isnt val
			@_impl.linkElem.setAttribute 'href', val
			@_impl.linkElem.style.display = if val isnt '' then 'block' else 'none'
		return

	setItemMargin: (type, val) ->
		@_parent?._impl.update.call @_parent

	attachItemSignal: (ns, signalName) ->
		self = @
		data = @_ref?._impl or @_impl
		{elem} = data

		name = ns + utils.capitalize(signalName)

		implName = SIGNALS[name]?(elem) or SIGNALS[name]

		# break if event is not supported (e.g. some events on touch devices)
		unless implName?
			return

		customFunc = (e) ->
			arg = SIGNALS_ARGS[name]? e
			if arg is false or e._accepted
				return

			if name is 'pointerMoved'
				e._accepted = true

			if self[signalName](arg) is signal.STOP_PROPAGATION
				if name is 'pointerPressed'
					document.body.setAttribute 'class', 'unselectable'
					mouseActiveItem = self
				e.stopPropagation()
			return

		if typeof implName is 'string'
			if ///^keys///.test name
				window.addEventListener implName, customFunc
			else
				if name isnt 'pointerReleased'
					elem.addEventListener implName, customFunc, false

		# cursor
		if cursor = SIGNALS_CURSORS[name]
			data.elemStyle.cursor = cursor
		return
