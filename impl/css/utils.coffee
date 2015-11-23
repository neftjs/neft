'use strict'

signal = require 'signal'

isFirefox = exports.isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

# get transform CSS property name
transformProp = exports.transformProp = do ->
	prefix = do ->
		tmp = document.createElement 'div'
		return 't' if tmp.style.transform?
		return 'webkitT' if tmp.style.webkitTransform?
		return 'mozT' if tmp.style.mozTransform?
		return 'msT' if tmp.style.msTransform?

	"#{prefix}ransform"

transformCSSProp = exports.transformCSSProp = do ->
	if transformProp.indexOf('T') isnt -1
		'-' + transformProp.replace('T', '-t')
	else
		transformProp

exports.transform3dSupported = do ->
	tmp = document.createElement 'div'
	tmp.style[transformProp] = 'translate3d(1px,1px,0)'
	tmp.style[transformProp].indexOf('translate3d') isnt -1

exports.rad2deg = (rad) ->
	rad * 180/Math.PI

exports.getFontWeight = (val) ->
	Math.round(val * 8) * 100 + 100

exports.prependElement = (parent, child) ->
	if first = parent.firstChild
		parent.insertBefore child, first
	else
		parent.appendChild child

exports.insertAfter = (child, afterElem) ->
	if afterElem.nextElement
		afterElem.parentElement.insertBefore child, afterElem.nextElement
	else
		afterElem.parentElement.appendChild child

exports.encodeImageSrc = do ->
	DATA_URI_RE = ///^data:([a-z+/]+)///

	(val) ->
		if DATA_URI_RE.test(val)
			val.replace ///\#///g, encodeURIComponent('#')
		else
			val

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

		keysEvents.focusedKeys?.onPress.emit key: key

	# hold
	window.addEventListener 'keydown', (e) ->
		code = e.which or e.keyCode
		key = SPECIAL_KEY_CODES[code] or String.fromCharCode(code)

		keysEvents.focusedKeys?.onHold.emit key: key

	# released
	window.addEventListener 'keyup', (e) ->
		code = e.which or e.keyCode
		key = SPECIAL_KEY_CODES[code] or String.fromCharCode(code)

		pressedKeys[key] = null

		keysEvents.focusedKeys?.onRelease.emit key: key

	# input
	window.addEventListener 'keypress', (e) ->
		code = e.charCode or e.which or e.keyCode
		text = String.fromCharCode(code)

		keysEvents.focusedKeys?.onInput.emit text: text

	keysEvents =
		focusedKeys: null
		setItemKeysFocus: (val) ->
			{keys} = @
			if val is true
				keysEvents.focusedKeys = keys
			else if keysEvents.focusedKeys is keys
				keysEvents.focusedKeys = null
			return

signal.create exports, 'onFontLoaded'
exports.loadingFonts = Object.create null
exports.loadedFonts = Object.create null

exports.DEFAULT_FONTS =
	__proto__: null
	'sans': 'neft-sans-4-normal'
	'sans-serif': 'neft-sans-serif-4-normal'
	'monospace': 'neft-monospace-4-normal'
