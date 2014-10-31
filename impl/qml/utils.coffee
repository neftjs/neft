exports.createQmlObject = do ->
	components = {}

	createItemComponent = (type) ->
		qmlStr = "import QtQuick 2.3; Component { #{type} {} }"
		components[type] = Qt.createQmlObject qmlStr, stylesHatchery

	(type) ->
		component = components[type] or createItemComponent(type)
		component.createObject()

exports.radToDeg = (val) ->
	val * (180/Math.PI)