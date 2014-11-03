'use strict'

module.exports = (impl) ->
	{items} = impl

	create: (item) ->

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

	setItemMargin: (type, val) ->

	attachItemSignal: (name, signal) ->