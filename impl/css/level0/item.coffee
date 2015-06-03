'use strict'

utils = require 'utils'
implUtils = require '../utils'
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
	'pointerWheel': implUtils.wheelEvent.eventName

if isTouch
	utils.merge SIGNALS,
		'pointerPressed': 'touchstart'
		'pointerReleased': 'touchend'
		'pointerEntered': 'touchstart'
		'pointerExited': 'touchend'
		'pointerMoved': 'touchmove'

SIGNALS_CURSORS =
	'pointerClicked': 'pointer'

lastEventCoords =
	x: -1
	y: -1
mouseInitialized = false
movementX = movementY = 0
getMouseEvent = (e) ->
	if isTouch and e.touches?
		if e.touches.length
			e = e.touches[0]
		else
			e = e.changedTouches[0]

	if e.pageX isnt lastEventCoords.x or e.pageY isnt lastEventCoords.y
		if mouseInitialized
			movementX = e.pageX - lastEventCoords.x
			movementY = e.pageY - lastEventCoords.y
		else
			mouseInitialized = true

		lastEventCoords.x = e.pageX
		lastEventCoords.y = e.pageY

	movementX: movementX
	movementY: movementY

SIGNALS_ARGS =
	'pointerWheel': implUtils.wheelEvent.getDelta
	'pointerPressed': getMouseEvent
	'pointerReleased': getMouseEvent
	'pointerClicked': getMouseEvent
	'pointerMoved': getMouseEvent

HOT_MAX_TIME = 1000
HOT_MAX_ACTIONS = 4
USE_GPU = true

# if ///^mac///i.test(navigator.platform) and devicePixelRatio > 1
# 	USE_GPU = false

module.exports = (impl) ->
	LAYER_MIN_OPERATIONS = 2
	LAYER_GC_DELAY = 1000
	layers = []

	impl._SIGNALS = SIGNALS

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

	# window.addEventListener 'touchstart', (e) ->
	# 	e.preventDefault()
	# , true

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
		@_impl.elemStyle.width = "#{val}px"
		@_parent?._impl.update.call @_parent
		@_impl.update.call @
		return

	setItemHeight: (val) ->
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
				if e.cancelable and implName isnt 'touchend' and implName isnt 'touchstart'
					e.preventDefault()
			return

		if typeof implName is 'string'
			if name isnt 'pointerReleased'
				elem.addEventListener implName, customFunc, false

		# cursor
		if cursor = SIGNALS_CURSORS[name]
			data.elemStyle.cursor = cursor
		return

	setItemKeysFocus: impl.utils.keysEvents.setItemKeysFocus
