'use strict'

utils = require 'utils'

module.exports = (impl) ->
	{items} = impl

	DATA = utils.merge
		parent: null
		visible: true
		clip: false
		width: 0
		height: 0
		x: 0
		y: 0
		z: 0
		scale: 1
		rotation: 0
		opacity: 1
		linkUri: ''
		bindings: null
		anchors: null
	, impl.utils.fill.DATA

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->

	setItemParent: (val) ->
		@_impl.parent = items[val]

	setItemVisible: (val) ->
		@_impl.visible = val

	setItemClip: (val) ->
		@_impl.clip = val

	setItemWidth: (val) ->
		@_impl.width = val

	setItemHeight: (val) ->
		@_impl.height = val

	setItemX: (val) ->
		@_impl.x = val

	setItemY: (val) ->
		@_impl.y = val

	setItemZ: (val) ->
		@_impl.z = val

	setItemScale: (val) ->
		@_impl.scale = val

	setItemRotation: (val) ->
		@_impl.rotation = val

	setItemOpacity: (val) ->
		@_impl.opacity = val

	setItemLinkUri: (val) ->
		@_impl.linkUri = val

	setItemMargin: (type, val) ->

	doItemOverlap: (item) ->
		a = @
		b = item
		tmp = null

		x1 = a._x; y1 = a._y
		x2 = b._x; y2 = b._y

		parent1 = a
		while tmp = parent1._parent
			x1 += tmp._x
			y1 += tmp._y
			parent1 = tmp

		parent2 = b
		while tmp = parent2._parent
			x1 += tmp._x
			y1 += tmp._y
			parent2 = tmp

		parent1 is parent2 and
		x1 + a._width > x2 and
		y1 + a._height > y2 and
		x1 < x2 + b._width and
		y1 < y2 + b._height

	attachItemSignal: (name, signal) ->

	setItemFill: (type, val) ->
		unless @_impl.disableFill
			if @_fillWidth isnt @_fillHeight
				impl.utils.fill.enable @
			else if val is false
				impl.utils.fill.disable @
		return
