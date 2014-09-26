'use strict'

PIXI = require '../pixi.lib.js'

module.exports = (impl) ->
	{items} = impl

	create: (id, target) ->
		elem = target.elem ?= new PIXI.DisplayObjectContainer
		# elem.pivot.x = elem.pivot.y = 0.5
		target.parent = ''
		target.scale = 1

	getItemParent: (id) ->
		items[id].parent

	setItemParent: (id, val) ->
		items[id].parent = val
		items[val].elem.addChild items[id].elem

	getItemVisible: (id) ->
		items[id].elem.visible

	setItemVisible: (id, val) ->
		items[id].elem.visible = val

	getItemClip: (id) ->
		# items[id].clip

	setItemClip: (id, val) ->
		# items[id].clip = val

	getItemWidth: (id) ->
		items[id].elem.width

	setItemWidth: (id, val) ->
		{elem} = items[id]
		elem.width = val
		# elem.pivot.x = val/2

	getItemHeight: (id) ->
		items[id].elem.height

	setItemHeight: (id, val) ->
		{elem} = items[id]
		elem.height = val
		# elem.pivot.y = val/2

	getItemX: (id) ->
		item = items[id]
		{elem} = item
		elem.position.x# / item.scale

	setItemX: (id, val) ->
		item = items[id]
		{elem} = item
		elem.position.x = val# * item.scale

	getItemY: (id) ->
		item = items[id]
		{elem} = item
		elem.position.y# / item.scale

	setItemY: (id, val) ->
		item = items[id]
		{elem} = item
		elem.position.y = val# * item.scale

	getItemZ: (id) ->
		# items[id].z

	setItemZ: (id, val) ->
		# items[id].z = val

	getItemScale: (id) ->
		items[id].elem.scale

	setItemScale: (id, val) ->
		item = items[id]
		{elem} = item
		{scale, width, height, position} = elem

		baseScaleX = scale.x / item.scale
		baseScaleY = scale.y / item.scale
		basePositionX = position.x / item.scale
		basePositionY = position.y / item.scale

		item.scale = val

		scale.x = baseScaleX * val
		scale.y = baseScaleY * val
		# position.x = basePositionX - elem.width*item.scale/2
		# position.y = basePositionY - elem.height*item.scale/2

	getItemRotation: (id) ->
		items[id].elem.rotation

	setItemRotation: (id, val) ->
		items[id].elem.rotation = val

	getItemOpacity: (id) ->
		items[id].elem.alpha

	setItemOpacity: (id, val) ->
		items[id].elem.alpha = val

