'use strict'

utils = require 'utils'
PIXI = require '../pixi.lib.js'

SIGNALS =
	'pointerClicked': 'click'
	'pointerPressed': 'mousedown'
	'pointerReleased': 'mouseup'
	'pointerEntered': 'mouseover'
	'pointerExited': 'mouseout'
	'pointerMove': 'mousemove'

module.exports = (impl) ->
	if utils.isEmpty PIXI
		return require('../../base/level0/item') impl

	updateMask = (item) ->
		return; # TODO
		{elem} = item._impl
		{mask} = elem

		mask.clear()
		mask.beginFill()
		mask.drawRect 0, 0, elem.width, elem.height
		mask.endFill()

	DATA = utils.merge
		bindings: null
		anchors: null
		elem: null
	, impl.utils.fill.DATA

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		elem = data.elem = new PIXI.DisplayObjectContainer
		elem._data = @
		return

	setItemParent: (val) ->
		item = @_impl.elem
		parent = val?._impl.elem

		unless parent
			item.parent.removeChild item

		parent.addChild item
		impl._dirty = true

	setItemVisible: (val) ->
		@_impl.elem.visible = val
		impl._dirty = true

	setItemClip: (val) ->
		# TODO: doesn't work with custom PIXI.DisplayObject.prototype.updateTransform
		# if val is false
		# 	# remove mask
		# 	elem.removeChild elem.mask
		# 	elem.mask = null
		# else
		# 	# add mask
		# 	mask = new PIXI.Graphics
		# 	elem.mask = mask
		# 	updateMask @
		# 	elem.addChild mask

	setItemWidth: (val) ->
		{elem} = @_impl
		# elem.width = val
		@_impl.contentElem?.width = val
		if elem.mask?
			updateMask @
		impl._dirty = true

	setItemHeight: (val) ->
		{elem} = @_impl
		# elem.height = val
		@_impl.contentElem?.height = val
		if elem.mask?
			updateMask @
		impl._dirty = true

	setItemX: (val) ->
		@_impl.elem.position.x = val
		impl._dirty = true

	setItemY: (val) ->
		@_impl.elem.position.y = val
		impl._dirty = true

	setItemZ: (val) ->
		# items[id].z = val

	setItemScale: (val) ->
		@_impl.elem.sizeScale = val
		impl._dirty = true

	setItemRotation: (val) ->
		@_impl.elem.rotation = val
		impl._dirty = true

	setItemOpacity: (val) ->
		@_impl.elem.alpha = val
		impl._dirty = true

	setItemMargin: (type, val) ->

	attachItemSignal: (ns, name) ->
		self = @
		{elem} = @_ref._impl
		uniqueName = ns + utils.capitalize(name)
		implName = SIGNALS[uniqueName]
		if implName
			elem.interactive = true
			# TODO: more listeners
			elem[implName] = (e) -> self[name] {}
		return