'use strict'

PIXI = require '../pixi.lib.js'

module.exports = (impl) ->
	{items} = impl

	updateMask = (id) ->
		{elem} = items[id]
		{mask} = elem

		mask.clear()
		mask.beginFill()
		mask.drawRect 0, 0, elem.width, elem.height
		mask.endFill()

	create: (id, target) ->
		elem = target.elem ?= new PIXI.DisplayObjectContainer
		target.parent = ''
		target.elem.sizeScale = 1

	getItemParent: (id) ->
		items[id].parent

	setItemParent: (id, val) ->
		item = items[id]
		item.parent = val
		items[val].elem.addChild item.elem

	getItemVisible: (id) ->
		items[id].elem.visible

	setItemVisible: (id, val) ->
		items[id].elem.visible = val

	getItemClip: (id) ->
		items[id].elem.mask?

	setItemClip: (id, val) ->
		item = items[id]
		{elem} = item

		# TODO: doesn't work with custom PIXI.DisplayObject.prototype.updateTransform
		# if val is false
		# 	# remove mask
		# 	elem.removeChild elem.mask
		# 	elem.mask = null
		# else
		# 	# add mask
		# 	mask = new PIXI.Graphics
		# 	elem.mask = mask
		# 	updateMask id
		# 	elem.addChild mask

	getItemWidth: (id) ->
		items[id].elem.width

	setItemWidth: (id, val) ->
		{elem} = items[id]
		elem.width = val
		if elem.mask?
			updateMask id

	getItemHeight: (id) ->
		items[id].elem.height

	setItemHeight: (id, val) ->
		{elem} = items[id]
		elem.height = val
		if elem.mask?
			updateMask id

	getItemX: (id) ->
		item = items[id]
		{elem} = item
		elem.position.x

	setItemX: (id, val) ->
		item = items[id]
		{elem} = item
		elem.position.x = val

	getItemY: (id) ->
		item = items[id]
		{elem} = item
		elem.position.y

	setItemY: (id, val) ->
		item = items[id]
		{elem} = item
		elem.position.y = val

	getItemZ: (id) ->
		# items[id].z

	setItemZ: (id, val) ->
		# items[id].z = val

	getItemScale: (id) ->
		items[id].elem.sizeScale

	setItemScale: (id, val) ->
		items[id].elem.sizeScale = val

	getItemRotation: (id) ->
		items[id].elem.rotation

	setItemRotation: (id, val) ->
		items[id].elem.rotation = val

	getItemOpacity: (id) ->
		items[id].elem.alpha

	setItemOpacity: (id, val) ->
		items[id].elem.alpha = val

