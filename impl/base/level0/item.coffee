'use strict'

module.exports = (impl) ->
	{items} = impl

	DATA =
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

	attachItemSignal: (name, signal) ->