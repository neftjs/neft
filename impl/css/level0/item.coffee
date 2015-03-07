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
createGetMouseCoords = (type) -> (target, e) ->
	if e is undefined
		e = target
		target = e.currentTarget

	if isTouch and e.touches?
		if e.touches.length
			e = e.touches[0]
		else
			e = e.changedTouches[0]

	rect = target.getBoundingClientRect()
	x = e.pageX - rect.left
	y = e.pageY - rect.top
	if lastEvent? and lastEvent isnt e
		movementX = e.pageX - lastEvent.pageX
		movementY = e.pageY - lastEvent.pageY

	if lastEvent isnt e
		lastEvent = e

	if type is 'inner'
		if x < 0 or y < 0 or x > rect.width or y > rect.height
			return false
	else if type is 'outer'
		if x >= 0 and y >= 0 and x <= rect.width and y <= rect.height
			return false

	x: x
	y: y
	movementX: movementX
	movementY: movementY

getMouseCoords = createGetMouseCoords ''
getInnerMouseCoords = createGetMouseCoords 'inner'

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
			e.preventDefault()

			x = e.wheelDeltaX or -e.deltaX or 0
			y = e.wheelDelta or -e.deltaY or -e.detail or 0

			if isFirefox and e.deltaMode is e.DOM_DELTA_LINE
				x *= 25
				y *= 25

			x: x
			y: y

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

	'pointerPressed': getInnerMouseCoords
	'pointerReleased': getMouseCoords
	'pointerClicked': getInnerMouseCoords
	'pointerMoved': (e) ->
		if isTouch
			e.preventDefault()

		getInnerMouseCoords e
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

mouseActiveItem = null
getOuterMouseCoords = createGetMouseCoords 'outer'

window.addEventListener SIGNALS.pointerReleased, (e) ->
	if mouseActiveItem
		coords = getMouseCoords mouseActiveItem._impl.elem, e
		mouseActiveItem.pointer.released coords
		mouseActiveItem = null
	document.body.setAttribute 'class', ''
	return
window.addEventListener SIGNALS.pointerMoved, (e) ->
	if mouseActiveItem
		coords = getOuterMouseCoords mouseActiveItem._impl.elem, e
		if coords
			mouseActiveItem.pointer.moved coords
	return

HOT_MAX_TIME = 1000
HOT_MAX_ACTIONS = 4

module.exports = (impl) ->
	STYLE_TRANSFORM = 1<<0
	STYLE_WIDTH = 1<<1
	STYLE_HEIGHT = 1<<2
	STYLE_OPACITY = 1<<3
	STYLE_SCROLL = impl.STYLE_SCROLL = 1<<4
	STYLE_ALL = (1<<5)-1

	nowTime = now()

	updateQueueItems = Object.create null
	updateItem = do ->
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

		(item, styles) ->
			data = item._impl
			style = data.elemStyle

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
				if (style.opacity = item._opacity) is 0
					data.isHidden = true
			if styles & STYLE_SCROLL and data.scrollElem
				data.scrollElem.scrollLeft = item._contentX
				data.scrollElem.scrollTop = item._contentY

			return

	updateStyles = impl.updateStyles = do ->
		pending = false
		queue = []
		queueItems = updateQueueItems

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
		data = item._impl

		if data.hotActions isnt -1
			if nowTime - data.lastAction < HOT_MAX_TIME
				if data.hotActions++ > HOT_MAX_ACTIONS
					{style, id} = data.elem
					data.isHot = true
					return true
			else
				data.hotActions = 0
				data.lastAction = nowTime

		false

	DATA =
		bindings: null
		anchors: null
		elem: null
		elemStyle: null
		lastAction: 0
		hotActions: 0
		isHot: false
		isHidden: false
		linkElem: null

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		data.elem ?= document.createElement 'div'
		data.elemStyle = data.elem.style
		data.lastAction = nowTime

	setItemParent: (val) ->
		{elem} = @_impl

		updateItem @, (updateQueueItems[@__hash__] or 0)

		if val
			val._impl.elem.appendChild elem
		else
			elem.parentElement?.removeChild elem

		return

	setItemVisible: (val) ->
		@_impl.elemStyle.display = if val then 'inline' else 'none'
		return

	setItemClip: (val) ->
		@_impl.elemStyle.overflow = if val then 'hidden' else 'visible'
		return

	setItemWidth: (val) ->
		updateStyles @, STYLE_WIDTH
		return

	setItemHeight: (val) ->
		updateStyles @, STYLE_HEIGHT
		return

	setItemX: (val) ->
		updateStyles @, STYLE_TRANSFORM
		return

	setItemY: (val) ->
		updateStyles @, STYLE_TRANSFORM
		return

	setItemZ: (val) ->
		@_impl.elemStyle.zIndex = if val is 0 then 'auto' else val
		return

	setItemScale: (val) ->
		updateStyles @, STYLE_TRANSFORM
		return

	setItemRotation: (val) ->
		updateStyles @, STYLE_TRANSFORM
		return

	setItemOpacity: (val) ->
		updateStyles @, STYLE_OPACITY
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

	attachItemSignal: (ns, name, signalName) ->
		self = @
		{elem} = @_impl

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

			if self[ns][signalName](arg) is signal.STOP_PROPAGATION
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
			@_impl.elemStyle.cursor = cursor
		return
