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
	DATA =
		elem: null
		mouseArea: null
		linkUri: ''
		linkUriListens: false
		bindings: null

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

	attachItemSignal: (ns, name, signalName) ->
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
