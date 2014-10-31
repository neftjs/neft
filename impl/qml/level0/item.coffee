'use strict'

SIGNALS =
	'pointerClicked': 'onClicked'
	'pointerPressed': 'onPressed'
	'pointerReleased': 'onReleased'
	'pointerEntered': 'onEntered'
	'pointerExited': 'onExited'
	'pointerMove': 'onPositionChanged'
	'pointerWheel': 'onWheel'

HOVER_SIGNALS =
	'pointerEntered': true
	'pointerExited': true
	'pointerMove': true

SIGNALS_CURSORS =
	'pointerClicked': Qt.PointingHandCursor

mouseCoordsArgs = (e) ->
	x: e.x
	y: e.y

SIGNALS_ARGS =
	'pointerPressed': mouseCoordsArgs
	'pointerReleased': mouseCoordsArgs
	'pointerMove': mouseCoordsArgs
	'pointerWheel': (e) ->
		x: e.angleDelta.x
		y: e.angleDelta.y

module.exports = (impl) ->
	create: (item) ->
		storage = item._impl
		storage.elem ?= impl.utils.createQmlObject 'Item'
		storage.id = stylesWindow.items.push(storage) - 1
		storage.mouseArea = null

	setItemParent: (val) ->
		@_impl.elem.parent = val._impl.elem or null

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

	# TODO: `pointerReleased` doesn't work with `pointerPressed`
	attachItemSignal: (name, func) ->
		storage = @_impl

		# create mouse area if needed
		unless mouseArea = storage.mouseArea
			mouseArea = storage.mouseArea = impl.utils.createQmlObject 'MouseArea'
			mouseArea.propagateComposedEvents = true
			mouseArea.parent = storage.elem

			{id} = storage
			qmlUtils.createBinding mouseArea, 'width', "stylesWindow.items['#{id}'].elem.width"
			qmlUtils.createBinding mouseArea, 'height', "stylesWindow.items['#{id}'].elem.height"

		# hover
		if HOVER_SIGNALS[name]
			mouseArea.hoverEnabled = true

		# listen on an event
		signal = SIGNALS[name]

		customFunc = (e) ->
			arg = SIGNALS_ARGS[name]? e
			func arg

		mouseArea[signal].connect customFunc

		# cursor
		if cursor = SIGNALS_CURSORS[name]
			mouseArea.cursorShape = cursor
