'use strict'

signal = require 'signal'

SIGNALS =
	'pointerClicked': 'onClicked'
	'pointerPressed': 'onPressed'
	'pointerReleased': 'onReleased'
	'pointerEntered': 'onEntered'
	'pointerExited': 'onExited'
	'pointerMove': 'onPositionChanged'
	'pointerWheel': 'onWheel'
	'keysPressed': 'onPressed'
	'keysHold': 'onPressed'
	'keysReleased': 'onReleased'
	'keysInput': 'onPressed'

HOVER_SIGNALS =
	'pointerEntered': true
	'pointerExited': true
	'pointerMove': true

SIGNALS_CURSORS =
	'pointerClicked': Qt.PointingHandCursor

mouseCoordsArgs = (e) ->
	x: e.x
	y: e.y

KEY_CODES = {}
KEY_CODES[Qt.Key_Escape] = 'Escape'
KEY_CODES[Qt.Key_Tab] = 'Tab'
KEY_CODES[Qt.Key_Backspace] = 'Backspace'
KEY_CODES[Qt.Key_Return] = 'Enter'
KEY_CODES[Qt.Key_Enter] = 'Enter'
KEY_CODES[Qt.Key_Insert] = 'Insert'
KEY_CODES[Qt.Key_Delete] = 'Delete'
KEY_CODES[Qt.Key_Pause] = 'Pause'
KEY_CODES[Qt.Key_Home] = 'Home'
KEY_CODES[Qt.Key_End] = 'End'
KEY_CODES[Qt.Key_Left] = 'Left'
KEY_CODES[Qt.Key_Up] = 'Up'
KEY_CODES[Qt.Key_Right] = 'Right'
KEY_CODES[Qt.Key_Down] = 'Down'
KEY_CODES[Qt.Key_PageUp] = 'Page Up'
KEY_CODES[Qt.Key_PageDown] = 'Page Down'
KEY_CODES[Qt.Key_Shift] = 'Shift'
KEY_CODES[Qt.Key_Control] = 'Control'
KEY_CODES[Qt.Key_Meta] = 'Meta'
KEY_CODES[Qt.Key_Alt] = 'Alt'
KEY_CODES[Qt.Key_AltGr] = 'Alt'
KEY_CODES[Qt.Key_CapsLock] = 'Caps Lock'
KEY_CODES[Qt.Key_NumLock] = 'Num Lock'
KEY_CODES[Qt.Key_ScrollLock] = 'Scroll Lock'
KEY_CODES[Qt.Key_F1] = 'F1'
KEY_CODES[Qt.Key_F2] = 'F2'
KEY_CODES[Qt.Key_F3] = 'F3'
KEY_CODES[Qt.Key_F4] = 'F4'
KEY_CODES[Qt.Key_F5] = 'F5'
KEY_CODES[Qt.Key_F6] = 'F6'
KEY_CODES[Qt.Key_F7] = 'F7'
KEY_CODES[Qt.Key_F8] = 'F8'
KEY_CODES[Qt.Key_F9] = 'F9'
KEY_CODES[Qt.Key_F10] = 'F10'
KEY_CODES[Qt.Key_F11] = 'F11'
KEY_CODES[Qt.Key_F12] = 'F12'
KEY_CODES[Qt.Key_Menu] = 'Menu'
KEY_CODES[Qt.Key_Space] = 'Space'
KEY_CODES[Qt.Key_0] = '0'
KEY_CODES[Qt.Key_1] = '1'
KEY_CODES[Qt.Key_2] = '2'
KEY_CODES[Qt.Key_3] = '3'
KEY_CODES[Qt.Key_4] = '4'
KEY_CODES[Qt.Key_5] = '5'
KEY_CODES[Qt.Key_6] = '6'
KEY_CODES[Qt.Key_7] = '7'
KEY_CODES[Qt.Key_8] = '8'
KEY_CODES[Qt.Key_9] = '9'
KEY_CODES[Qt.Key_A] = 'A'
KEY_CODES[Qt.Key_B] = 'B'
KEY_CODES[Qt.Key_C] = 'C'
KEY_CODES[Qt.Key_D] = 'D'
KEY_CODES[Qt.Key_E] = 'E'
KEY_CODES[Qt.Key_F] = 'F'
KEY_CODES[Qt.Key_G] = 'G'
KEY_CODES[Qt.Key_H] = 'H'
KEY_CODES[Qt.Key_I] = 'I'
KEY_CODES[Qt.Key_J] = 'J'
KEY_CODES[Qt.Key_K] = 'K'
KEY_CODES[Qt.Key_L] = 'L'
KEY_CODES[Qt.Key_M] = 'M'
KEY_CODES[Qt.Key_N] = 'N'
KEY_CODES[Qt.Key_O] = 'O'
KEY_CODES[Qt.Key_P] = 'P'
KEY_CODES[Qt.Key_Q] = 'Q'
KEY_CODES[Qt.Key_R] = 'R'
KEY_CODES[Qt.Key_S] = 'S'
KEY_CODES[Qt.Key_T] = 'T'
KEY_CODES[Qt.Key_U] = 'U'
KEY_CODES[Qt.Key_V] = 'V'
KEY_CODES[Qt.Key_W] = 'W'
KEY_CODES[Qt.Key_X] = 'X'
KEY_CODES[Qt.Key_Y] = 'Y'
KEY_CODES[Qt.Key_Z] = 'Z'

pressedKeys = Object.create null

SIGNALS_ARGS =
	'pointerPressed': mouseCoordsArgs
	'pointerReleased': mouseCoordsArgs
	'pointerMove': mouseCoordsArgs
	'pointerWheel': (e) ->
		x: e.angleDelta.x
		y: e.angleDelta.y
	'keysPressed': (e) ->
		if pressedKeys[e.key]
			return false
		pressedKeys[e.key] = true
		key: KEY_CODES[e.key] || e.text.toUpperCase()
	'keysHold': (e) ->
		key: KEY_CODES[e.key] || e.text.toUpperCase()
	'keysReleased': (e) ->
		pressedKeys[e.key] = false
		key: KEY_CODES[e.key] || e.text.toUpperCase()
	'keysInput': (e) ->
		text: e.text

module.exports = (impl) ->
	DATA =
		elem: null
		mouseArea: null
		linkUri: ''
		linkUriListens: false
		bindings: null
		anchors: null

	exports =
	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		data.elem ?= impl.utils.createQmlObject 'Item {}'

	setItemParent: (val) ->
		@_impl.elem.parent = val?._impl.elem or null

	setItemVisible: (val) ->
		@_impl.elem.visible = val

	setItemClip: (val) ->
		@_impl.elem.clip = val

	setItemWidth: (val) ->
		@_impl.elem.width = val

	setItemHeight: (val) ->
		@_impl.elem.height = val

	setItemX: (val) ->
		@_impl.elem.x = val

	setItemY: (val) ->
		@_impl.elem.y = val

	setItemZ: (val) ->
		@_impl.elem.z = val

	setItemScale: (val) ->
		@_impl.elem.scale = val

	setItemRotation: (val) ->
		@_impl.elem.rotation = impl.utils.radToDeg val

	setItemOpacity: (val) ->
		@_impl.elem.opacity = val

	setItemLinkUri: do ->
		onLinkUriClicked = ->
			{linkUri} = @_impl
			if linkUri
				__location.append linkUri
				signal.STOP_PROPAGATION

		(val) ->
			@_impl.linkUri = val

			unless @_impl.linkUriListens
				@_impl.linkUriListens = true
				@pointer.onClicked onLinkUriClicked

	setItemMargin: (val) ->

	attachItemSignal: do ->
		attachPointer = (ns, name, signalName) ->
			self = @
			storage = @_impl

			# create mouse area if needed
			unless mouseArea = storage.mouseArea
				mouseArea = storage.mouseArea = impl.utils.createQmlObject(
					'MouseArea {' +
						'propagateComposedEvents: true;' +
						'anchors.fill: parent;' +
					'}'
				, storage.elem)

			# hover
			if HOVER_SIGNALS[name]
				mouseArea.hoverEnabled = true

			# listen on an event
			signal = SIGNALS[name]

			customFunc = (e) ->
				if e?
					if e._stopPropagation
						return
					e.accepted = false

				arg = SIGNALS_ARGS[name]? e
				if self[ns][signalName](arg) is signal.STOP_PROPAGATION and e?
					e._stopPropagation = true
				return

			mouseArea[signal].connect customFunc

			# cursor
			if cursor = SIGNALS_CURSORS[name]
				mouseArea.cursorShape = cursor
			return

		attachKeys = (ns, name, signalName) ->
			self = @
			signal = SIGNALS[name]
			stylesWindow.Keys[signal].connect (e) ->
				arg = SIGNALS_ARGS[name] e
				if self[ns][signalName](arg) is signal.STOP_PROPAGATION
					e.accepted = true
				return
			return

		(ns, name, signalName) ->
			if ///^keys///.test name
				attachKeys.call @, ns, name, signalName
			else
				attachPointer.call @, ns, name, signalName
