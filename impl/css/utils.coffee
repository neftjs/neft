'use strict'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

exports.getFontWeight = (val) ->
	Math.round(val * 8) * 100 + 100

exports.prependElement = (parent, child) ->
	if first = parent.firstChild
		parent.insertBefore child, first
	else
		parent.appendChild child

exports.encodeImageSrc = do ->
	DATA_URI_RE = ///^data:([a-z+/]+)///

	(val) ->
		if DATA_URI_RE.test(val)
			val.replace ///\#///g, encodeURIComponent('#')
		else
			val

exports.wheelEvent =
	eventName: do ->
		if 'onwheel' of document.createElement("div")
			'wheel'
		else if document.onmousewheel isnt undefined
			'mousewheel'
		else
			'MozMousePixelScroll'
	getDelta: do ->
		NORMALIZED_VALUE = 3

		isSlowContinuous = false

		getDeltas = (e) ->
			x = -e.deltaX*3 or e.wheelDeltaX ? 0
			y = -e.deltaY*3 or e.wheelDeltaY ? e.wheelDelta ? -e.detail*3 or 0

			if isFirefox and e.deltaMode is e.DOM_DELTA_LINE
				x *= 10
				y *= 10

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

exports.keysEvents = do ->
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

	pressedKeys = Object.create null

	# pressed
	window.addEventListener 'keydown', (e) ->
		code = e.which or e.keyCode
		key = SPECIAL_KEY_CODES[code] or String.fromCharCode(code)

		if pressedKeys[key] and pressedKeys[key] isnt e
			return false
		pressedKeys[key] = e

		keysEvents.focusedKeys?.pressed key: key

	# hold
	window.addEventListener 'keydown', (e) ->
		code = e.which or e.keyCode
		key = SPECIAL_KEY_CODES[code] or String.fromCharCode(code)

		keysEvents.focusedKeys?.hold key: key

	# released
	window.addEventListener 'keyup', (e) ->
		code = e.which or e.keyCode
		key = SPECIAL_KEY_CODES[code] or String.fromCharCode(code)

		pressedKeys[key] = null

		keysEvents.focusedKeys?.released key: key

	# input
	window.addEventListener 'keypress', (e) ->
		code = e.charCode or e.which or e.keyCode
		text = String.fromCharCode(code)

		keysEvents.focusedKeys?.input text: text

	keysEvents =
	focusedKeys: null
	setItemKeysFocus: (val) ->
		{keys} = @
		if val is true
			keysEvents.focusedKeys = keys
		else if keysEvents.focusedKeys is keys
			keysEvents.focusedKeys = null
		return
