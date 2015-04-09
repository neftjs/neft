'use strict'

utils = require 'utils'
signal = require 'signal'
PIXI = require '../pixi.lib.js'

isTouch = 'ontouchstart' of window

NOP = ->

SIGNALS =
	'pointerWheel': 'wheel'

if isTouch
	utils.merge SIGNALS,
		'pointerClicked': 'tap'
		'pointerPressed': 'touchstart'
		'pointerReleased': 'touchend'
		'pointerMoved': 'touchmove'
else
	utils.merge SIGNALS,
		'pointerClicked': 'click'
		'pointerPressed': 'mousedown'
		'pointerReleased': 'mouseup'
		'pointerEntered': 'mouseover'
		'pointerExited': 'mouseout'
		'pointerMoved': 'mousemove'


lastEvent = null
mouseEvent =
	movementX: 0
	movementY: 0
getMouseMovement = (e) ->
	if isTouch and e.touches?
		if e.touches.length
			e = e.touches[0]
		else
			e = e.changedTouches[0]

	if lastEvent isnt e
		if lastEvent?
			mouseEvent.movementX = e.pageX - lastEvent.pageX
			mouseEvent.movementY = e.pageY - lastEvent.pageY

		lastEvent = e
	return

if isTouch
	window.addEventListener 'touchmove', getMouseMovement
	window.addEventListener 'touchstart', (e) ->
		if e.touches.length
			e = e.touches[0]
		else
			e = e.changedTouches[0]

		lastEvent =
			pageX: e.pageX
			pageY: e.pageY
		return
else
	window.addEventListener 'mousemove', getMouseMovement

module.exports = (impl) ->
	cssUtils = require '../../css/utils'

	if utils.isEmpty PIXI
		return require('../../base/level0/item') impl

	{round} = Math

	unless isTouch
		impl._scrollableUsePointer = false

	# interactions on mouse move
	checkInteractions = ->
		if not impl._dirty and impl._pixiStage.interactive
			impl._pixiStage.interactionManager.update()
		return

	window.addEventListener 'mousemove', checkInteractions
	window.addEventListener 'touchmove', checkInteractions

	# wheel event
	window.addEventListener cssUtils.wheelEvent.eventName, (e) ->
		event = cssUtils.wheelEvent.getDelta e
		stage = impl._pixiStage

		for item in stage.interactionManager.interactiveItems
			item.wheel? event

		return

	updateMask = (item) ->
		data = item._impl
		{elem} = data
		{mask} = elem

		mask.clear()
		mask.beginFill()
		mask.drawRect 0, 0, data.width, data.height
		mask.endFill()
		return

	updateDepthIndexes = do ->
		compare = (a, b) ->
			if a.z < b.z
				-1
			if a.z > b.z
				1
			0
		(item) ->
			item._impl.elem.children.sort compare

	mouseActiveItem = null

	window.addEventListener SIGNALS.pointerReleased, (e) ->
		mouseActiveItem ?= impl.window?.pointer
		mouseActiveItem?.released mouseEvent
		mouseActiveItem = null
		return

	window.addEventListener SIGNALS.pointerMoved, (e) ->
		mouseActiveItem ?= impl.window?.pointer
		mouseActiveItem?.moved mouseEvent
		return

	DATA = utils.merge
		bindings: null
		anchors: null
		elem: null
		linkUri: ''
		linkUriListens: false
		x: 0
		y: 0
		width: 0
		height: 0
		scale: 1
	, impl.utils.fill.DATA

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		elem = data.elem = new PIXI.DisplayObjectContainer
		elem._data = data
		elem.z = 0
		return

	setItemParent: (val) ->
		item = @_impl.elem
		parent = val?._impl.elem

		if parent
			parent.addChild item
		else
			item.parent.removeChild item

		impl._dirty = true
		return

	setItemVisible: (val) ->
		@_impl.elem.visible = val
		impl._dirty = true
		return

	setItemClip: (val) ->
		{elem} = @_impl

		if val
			# add mask
			mask = new PIXI.Graphics
			elem.mask = mask
			updateMask @
			elem.addChild mask
		else
			# remove mask
			elem.removeChild elem.mask
			elem.mask = null
		return

	setItemWidth: (val) ->
		{elem} = @_impl
		val = round val
		@_impl.width = val
		@_impl.contentElem?.width = val
		if elem.mask?
			updateMask @
		impl._dirty = true
		return

	setItemHeight: (val) ->
		{elem} = @_impl
		val = round val
		@_impl.height = val
		@_impl.contentElem?.height = val
		if elem.mask?
			updateMask @
		impl._dirty = true
		return

	setItemX: (val) ->
		val = round val
		@_impl.x = val
		# @_impl.elem.position.x = val
		impl._dirty = true
		return

	setItemY: (val) ->
		val = round val
		@_impl.y = val
		# @_impl.elem.position.y = round val
		impl._dirty = true
		return

	setItemZ: (val) ->
		@_impl.elem.z = val
		updateDepthIndexes @
		impl._dirty = true

	setItemScale: (val) ->
		@_impl.scale = val
		impl._dirty = true

	setItemRotation: (val) ->
		@_impl.elem.rotation = val
		impl._dirty = true

	setItemOpacity: (val) ->
		@_impl.elem.alpha = val
		impl._dirty = true

	setItemLinkUri: do ->
		onLinkUriClicked = ->
			{linkUri} = @_impl
			if linkUri
				if ///^([a-z]+:)///.test linkUri
					window.location.href = linkUri
				else
					window.location.neftChangePage? linkUri
				signal.STOP_PROPAGATION

		(val) ->
			@_impl.linkUri = val

			unless @_impl.linkUriListens
				@_impl.linkUriListens = true
				@pointer.onClicked onLinkUriClicked, @
			return

	setItemMargin: (type, val) ->

	attachItemSignal: (ns, name) ->
		self = @
		{elem} = @_ref._impl
		uniqueName = ns + utils.capitalize(name)
		implName = SIGNALS[uniqueName]

		# TODO: support stop propagation on different items
		if implName and uniqueName isnt 'pointerReleased'
			elem.interactive = true
			_super = elem[implName] or NOP
			elem[implName] = (e) ->
				if e instanceof PIXI.InteractionData
					e = mouseEvent
				if _super(e) isnt signal.STOP_PROPAGATION
					if self[name](e) is signal.STOP_PROPAGATION
						if uniqueName is 'pointerPressed'
							mouseActiveItem = self
						return signal.STOP_PROPAGATION
				return
						
		if uniqueName is 'pointerClicked'
			elem.buttonMode = true
			elem.defaultCursor = 'pointer'
		return

	setItemKeysFocus: cssUtils.keysEvents.setItemKeysFocus
