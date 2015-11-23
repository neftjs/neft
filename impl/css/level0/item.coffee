'use strict'

utils = require 'utils'
implUtils = require '../utils'
log = require 'log'
signal = require 'signal'

log = log.scope 'Renderer', 'CSS Implementation'

{now} = Date

isTouch = 'ontouchstart' of window

SIGNALS_CURSORS =
	pointer:
		onClick: 'pointer'

module.exports = (impl) ->
	LAYER_MIN_OPERATIONS = 8
	LAYER_GC_DELAY = 1000
	USE_GPU = impl.utils.transform3dSupported
	layers = []

	{transformProp, rad2deg} = impl.utils

	implUtils = impl.utils

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

			if not data.isLayer and data.operations >= LAYER_MIN_OPERATIONS
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
		mozFontSubpixel: true
		isLayer: false
		isInLayers: false
		operations: 0
	, impl.pointer.DATA

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		data.elem ?= document.createElement 'div'
		data.elemStyle = data.elem.style

	setItemParent: (val) ->
		self = @
		{elem} = @_impl

		if val
			val._impl.elem.appendChild elem
		else
			elem.parentElement?.removeChild elem

		impl.pointer.setItemParent.call @, val

		return

	setItemIndex: (val) ->
		if childAtIndex = @_parent._children[val]
			@_impl.elem.parentElement.insertBefore @_impl.elem, childAtIndex._impl.elem
		else
			@_impl.elem.parentElement.appendChild @_impl.elem
		return

	setItemBackground: (val) ->
		if (oldElem = @_background?._impl.elem)?.parentNode is @_impl.elem
			@_impl.elem.removeChild oldElem
		if val
			implUtils.prependElement @_impl.elem, val._impl.elem
		return

	setItemVisible: (val) ->
		@_impl.elemStyle.display = if val then 'inline' else 'none'
		return

	setItemClip: (val) ->
		@_impl.elemStyle.overflow = if val then 'hidden' else 'visible'
		return

	setItemWidth: (val) ->
		@_impl.elemStyle.width = "#{val}px"
		return

	setItemHeight: (val) ->
		@_impl.elemStyle.height = "#{val}px"
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

	attachItemSignal: (ns, signalName) ->
		if ns is 'pointer'
			impl.pointer.attachItemSignal.call @, signalName

		# cursor
		if cursor = SIGNALS_CURSORS[ns]?[signalName]
			@_ref._impl.elemStyle.cursor = cursor
		return

	setItemKeysFocus: impl.utils.keysEvents.setItemKeysFocus
