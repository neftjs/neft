'use strict'

module.exports = (impl) ->
	{items} = impl

	create: (id, target) ->
		target.id = id
		target.parent = null
		target.visible = true
		target.clip = false
		target.width = 0
		target.height = 0
		target.x = 0
		target.y = 0
		target.z = 0
		target.scale = 1
		target.rotation = 0
		target.opacity = 1

	getItemParent: (id) ->
		items[id].parent?.id

	setItemParent: (id, val) ->
		items[id].parent = items[val]

	getItemVisible: (id) ->
		items[id].visible

	setItemVisible: (id, val) ->
		items[id].visible = val

	getItemClip: (id) ->
		items[id].clip

	setItemClip: (id, val) ->
		items[id].clip = val

	getItemWidth: (id) ->
		items[id].width

	setItemWidth: (id, val) ->
		items[id].width = val

	getItemHeight: (id) ->
		items[id].height

	setItemHeight: (id, val) ->
		items[id].height = val

	getItemX: (id) ->
		items[id].x

	setItemX: (id, val) ->
		items[id].x = val

	getItemY: (id) ->
		items[id].y

	setItemY: (id, val) ->
		items[id].y = val

	getItemZ: (id) ->
		items[id].z

	setItemZ: (id, val) ->
		items[id].z = val

	getItemScale: (id) ->
		items[id].scale

	setItemScale: (id, val) ->
		items[id].scale = val

	getItemRotation: (id) ->
		items[id].rotation

	setItemRotation: (id, val) ->
		items[id].rotation = val

	getItemOpacity: (id) ->
		items[id].opacity

	setItemOpacity: (id, val) ->
		items[id].opacity = val

	attachItemSignal: (id, name, signal) ->