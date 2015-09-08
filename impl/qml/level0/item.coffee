'use strict'

utils = require 'utils'
signal = require 'signal'

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

SIGNALS =
	'pointerOnClick': 'onClicked'
	'pointerOnPress': 'onPressed'
	'pointerOnRelease': 'onReleased'
	'pointerOnEnter': 'onEntered'
	'pointerOnExit': 'onExited'
	'pointerOnMove': 'onPositionChanged'
	'pointerOnWheel': 'onWheel'
	'pointerOnDragEnter': 'onEntered'
	'pointerOnDragExit': 'onExited'
	'pointerOnDrop': 'onDropped'
	'keysOnPress': 'onPressed'
	'keysOnHold': 'onPressed'
	'keysOnRelease': 'onReleased'
	'keysOnInput': 'onPressed'

HOVER_SIGNALS =
	'pointerOnEnter': true
	'pointerOnExit': true
	'pointerOnMove': true

DRAG_SIGNALS =
	'pointerOnDragEnter': true
	'pointerOnDragExit': true
	'pointerOnDrop': true

SIGNALS_CURSORS =
	'pointerOnClick': Qt.PointingHandCursor

lastMouseEvent = ready: false, x: 0, y: 0
movementX = movementY = 0
mouseCoordsArgs = (e) ->
	coords = @mapToItem null, e.x, e.y

	if lastMouseEvent.ready and e isnt lastMouseEvent
		movementX = coords.x - lastMouseEvent.x
		movementY = coords.y - lastMouseEvent.y

	if e isnt lastMouseEvent
		lastMouseEvent.ready = true
		lastMouseEvent.x = coords.x
		lastMouseEvent.y = coords.y

	movementX: movementX
	movementY: movementY

SIGNALS_ARGS =
	'pointerOnPress': mouseCoordsArgs
	'pointerOnRelease': mouseCoordsArgs
	'pointerOnMove': mouseCoordsArgs
	'pointerOnEnter': ->
		lastMouseEvent.ready = false
	'pointerOnExit': ->
		lastMouseEvent.ready = false
	'pointerOnWheel': (e) ->
		deltaX: e.angleDelta.x
		deltaY: e.angleDelta.y
	'keysOnPress': (e) ->
		if pressedKeys[e.key] and pressedKeys[e.key] isnt e
			return false
		pressedKeys[e.key] = e
		key: KEY_CODES[e.key] || e.text.toUpperCase()
	'keysOnHold': (e) ->
		key: KEY_CODES[e.key] || e.text.toUpperCase()
	'keysOnRelease': (e) ->
		pressedKeys[e.key] = null
		key: KEY_CODES[e.key] || e.text.toUpperCase()
	'keysOnInput': (e) ->
		text: e.text

module.exports = (impl) ->
	mouseActivePointer = null

	# always accepts pointer on impl.window
	__stylesMouseArea.onPressed.connect (e) ->
		e.accepted = true

	__stylesMouseArea.onPositionChanged.connect (e) ->
		target = mouseActivePointer or impl.window?.pointer
		if target and (mouseArea = target._ref._impl.mouseArea)
			event = SIGNALS_ARGS.pointerOnMove.call mouseArea, e
			target.onMove.emit event

	__stylesMouseArea.onReleased.connect (e) ->
		mouseActivePointer ?= impl.window?.pointer
		if mouseActivePointer and (mouseArea = mouseActivePointer._ref._impl.mouseArea)
			event = SIGNALS_ARGS.pointerOnRelease.call mouseArea, e
			mouseActivePointer.onRelease.emit event
		mouseActivePointer = null

	getMouseArea = do ->
		onActiveChanged = ->
			targetDrag = @_impl.elem.Drag
			if targetDrag.active = @pointer.dragging = @_impl.mouseArea.drag.active
				@pointer.onDragStart.emit()
				targetDrag.hotSpot.x = @_impl.mouseArea.mouseX
				targetDrag.hotSpot.y = @_impl.mouseArea.mouseY
			else
				@pointer.onDragEnd.emit()

		(item) ->
			unless mouseArea = item._impl.mouseArea
				mouseArea = item._impl.mouseArea = impl.utils.createQmlObject(
					'MouseArea {' +
						'property bool accepts: false;' +
						'onPressed: mouse.accepted = this.accepts || this.drag.target;' +
						'onReleased: { if (this.drag.active) { this.drag.target.Drag.drop(); } }' +
						'anchors.fill: parent;' +
					'}'
				, item._impl.elem)
				mouseArea.drag.onActiveChanged.connect item, onActiveChanged
			mouseArea

	getDropArea = (item) ->
		unless dropArea = item._impl.dropArea
			dropArea = item._impl.dropArea = impl.utils.createQmlObject(
				'DropArea {' +
					'anchors.fill: parent;' +
				'}'
			, item._impl.elem)
		dropArea

	DATA =
		elem: null
		mouseArea: null
		dropArea: null
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
		@_impl.elem.parent = val?._impl.elem or __stylesHatchery or null

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
				if ///^([a-z]+:)///.test linkUri
					Qt.openUrlExternally linkUri
				else
					__location.append linkUri
				signal.STOP_PROPAGATION

		(val) ->
			@_impl.linkUri = val

			unless @_impl.linkUriListens
				@_impl.linkUriListens = true
				@pointer.onClick onLinkUriClicked, @
			return

	attachItemSignal: do ->
		attachPointerDrag = (ns, name, uniqueName, qmlName) ->
			self = @
			data = @_ref._impl

			# create mouse area if needed
			dropArea = getDropArea @_ref

			# listen on an event
			customFunc = (e) ->
				arg = SIGNALS_ARGS[uniqueName]?.call dropArea, e
				self[name].emit arg
				return

			dropArea[qmlName].connect @, customFunc
			return

		attachPointerMouse = (ns, name, uniqueName, qmlName) ->
			self = @
			data = @_ref._impl

			# create mouse area if needed
			mouseArea = getMouseArea @_ref

			# hover
			if HOVER_SIGNALS[uniqueName]
				mouseArea.hoverEnabled = true

			# listen on an event
			customFunc = (e) ->
				arg = SIGNALS_ARGS[uniqueName]?.call mouseArea, e
				e?.accepted = false
				if self[name].emit(arg) is signal.STOP_PROPAGATION and e? and uniqueName is 'pointerOnPress'
					mouseActivePointer = @
					e.accepted = true
				return

			if uniqueName is 'pointerOnClick'
				mouseArea.accepts = true

			mouseArea[qmlName].connect @, customFunc

			# cursor
			if cursor = SIGNALS_CURSORS[uniqueName]
				mouseArea.cursorShape = cursor
			return

		attachKeys = (ns, name, uniqueName, qmlName) ->
			self = @
			__stylesWindow.Keys[qmlName].connect (e) ->
				arg = SIGNALS_ARGS[uniqueName] e
				if self[name].emit(arg) is signal.STOP_PROPAGATION
					e.accepted = true
				return
			return

		(ns, name) ->
			uniqueName = ns + utils.capitalize(name)
			unless qmlName = SIGNALS[uniqueName]
				return

			if ns is 'keys'
				attachKeys.call @, ns, name, uniqueName, qmlName
			else if DRAG_SIGNALS[uniqueName]
				attachPointerDrag.call @, ns, name, uniqueName, qmlName
			else
				attachPointerMouse.call @, ns, name, uniqueName, qmlName

	setItemPointerCaptureEvents: (val) ->
		mouseArea = getMouseArea @
		mouseArea.enabled = val
		return

	setItemPointerDraggable: (val) ->
		mouseArea = getMouseArea @
		mouseArea.drag.target = if val then mouseArea.parent else null
		return

	setItemPointerDragging: (val) ->
		mouseArea = getMouseArea @
		@_impl.elem.Drag.active = val
		return
