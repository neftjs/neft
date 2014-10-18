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
	{items} = impl

	create: (id, target) ->
		target.elem ?= impl.utils.createQmlObject 'Item', id
		target.mouseArea = null

	getItemChildren: (id) ->
		item = items[id]

		{elem} = item
		{children} = elem

		arr = []
		for child in children
			if id = child.uid
				arr.push id

		arr

	getItemParent: (id) ->
		items[id].elem.parent?.uid

	setItemParent: (id, val) ->
		elem = items[id].elem
		parent = items[val]

		elem.parent = parent?.elem or null

	getItemVisible: (id) ->
		items[id]?.elem.visible

	setItemVisible: (id, val) ->
		items[id]?.elem.visible = val

	getItemClip: (id) ->
		items[id]?.elem.clip

	setItemClip: (id, val) ->
		items[id]?.elem.clip = val

	getItemWidth: (id) ->
		items[id]?.elem.width

	setItemWidth: (id, val) ->
		items[id]?.elem.width = val

	getItemHeight: (id) ->
		items[id]?.elem.height

	setItemHeight: (id, val) ->
		items[id]?.elem.height = val

	getItemX: (id) ->
		items[id]?.elem.x

	setItemX: (id, val) ->
		items[id]?.elem.x = val

	getItemY: (id) ->
		items[id]?.elem.y

	setItemY: (id, val) ->
		items[id]?.elem.y = val

	getItemZ: (id) ->
		items[id]?.elem.z

	setItemZ: (id, val) ->
		items[id]?.elem.z = val

	getItemScale: (id) ->
		items[id]?.elem.scale

	setItemScale: (id, val) ->
		items[id]?.elem.scale = val

	getItemRotation: (id) ->
		items[id]?.elem.rotation

	setItemRotation: (id, val) ->
		items[id]?.elem.rotation = val

	getItemOpacity: (id) ->
		items[id]?.elem.opacity

	setItemOpacity: (id, val) ->
		items[id]?.elem.opacity = val

	# TODO: `pointerReleased` doesn't work with `pointerPressed`
	attachItemSignal: (id, name, func) ->
		item = items[id]

		# create mouse area if needed
		unless mouseArea = item.mouseArea
			mouseArea = item.mouseArea = impl.utils.createQmlObject 'MouseArea'
			mouseArea.propagateComposedEvents = true
			mouseArea.parent = item.elem

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
