'use strict'

module.exports = (impl) ->
	{Item} = impl.Types

	DATA = {}

	DATA: DATA

	createData: impl.utils.createDataCloner Item.DATA, DATA

	create: (data) ->
		elem = data.elem ?= impl.utils.createQmlObject 'Rectangle { color: "transparent" }'

		Item.create.call @, data

	setRectangleColor: (val) ->
		@_impl.elem.color = impl.utils.toQtColor val

	setRectangleRadius: (val) ->
		@_impl.elem.radius = val

	setRectangleBorderColor: (val) ->
		@_impl.elem.border.color = impl.utils.toQtColor val

	setRectangleBorderWidth: (val) ->
		@_impl.elem.border.width = val
