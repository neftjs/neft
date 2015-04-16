exports.DATA_URI_RE = ///^data:([a-z+/]+),(.*)$///

exports.createQmlObject = do ->
	components = {}

	createItemComponent = (type) ->
		qmlStr = "import QtQuick 2.3; Component { #{type} }"
		components[type] = Qt.createQmlObject qmlStr, __stylesHatchery

	(type, parent=null) ->
		component = components[type] or createItemComponent(type)
		component.createObject(parent)

RAD = 180 / Math.PI
exports.radToDeg = (val) ->
	val * RAD

DEG = Math.PI / 180
exports.degToRad = (val) ->
	val * DEG

exports.toQtColor = (color) ->
	# hash
	if color[0] is '#'
		color

	# rgba
	else if rgba = color.match ///^rgba\(([\d]+),\s?([\d]+),\s?([\d]+),\s?([\d.]+)\)$///
		Qt.rgba rgba[1]/255, rgba[2]/255, rgba[3]/255, rgba[4]

	# rgb
	else if rgb = color.match ///^rgb\(([\d]+),\s?([\d]+),\s?([\d]+)\)$///
		Qt.rgba rgb[1]/255, rgb[2]/255, rgb[3]/255, 1

	# hsla
	else if hsla = color.match ///^hsla\(([\d]+),\s?([\d]+)%,\s?([\d]+)%,\s?([\d.]+)\)$///
		Qt.hsla hsla[1]/360, hsla[2]/100, hsla[3]/100, hsla[4]

	# hsl
	else if hsl = color.match ///^hsl\(([\d]+),\s?([\d]+)%,\s?([\d]+)%\)$///
		Qt.hsla hsl[1]/360, hsl[2]/100, hsl[3]/100, 1

	else
		color

exports.toUrl = (url) ->
	if typeof url isnt 'string' or ///^[a-zA-Z]+?:\/\////.test(url)
		url
	else
		if url[0] isnt '/'
			url = "/#{url}"
		require('renderer').serverUrl + url
