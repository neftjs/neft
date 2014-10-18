'use strict'

module.exports = (impl) ->
	{items} = impl

	create: (id, target) ->
		target.elem ?= impl.utils.createQmlObject 'Item', id

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

	attachItemSignal: (id, name, func) ->
		elem = items[id]?.elem
		return unless elem

		# TODO