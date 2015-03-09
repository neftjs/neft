'use strict'

module.exports = (impl) ->
	{Item} = impl.Types

	DATA = {}

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		data.elem ?= impl.utils.createQmlObject 'Rectangle {' +
			'property alias borderItem: border;' +
			'color: "transparent";' +
			'Rectangle {' +
				'id: border;' +
				'anchors.fill: parent;' +
				'color: "transparent";' +
				'radius: parent.radius;' +
			'}' +
		'}'

		Item.create.call @, data

	setRectangleColor: (val) ->
		@_impl.elem.color = impl.utils.toQtColor val

	setRectangleRadius: (val) ->
		@_impl.elem.radius = val

	setRectangleBorderColor: (val) ->
		@_impl.elem.borderItem.border.color = impl.utils.toQtColor val

	setRectangleBorderWidth: (val) ->
		@_impl.elem.borderItem.border.width = val
