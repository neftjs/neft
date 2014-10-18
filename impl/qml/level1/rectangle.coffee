'use strict'

toQtColor = (color) ->

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

module.exports = (impl) ->
	{items} = impl
	{Item} = impl.Types

	create: (id, target) ->
		target.elem ?= impl.utils.createQmlObject 'Rectangle', id

		Item.create id, target

	getRectangleColor: (id) ->
		items[id].elem.color

	setRectangleColor: (id, val) ->
		items[id].elem.color = toQtColor val

	getRectangleRadius: (id) ->
		items[id].elem.radius

	setRectangleRadius: (id, val) ->
		items[id].elem.radius = val

	getRectangleBorderColor: (id) ->
		items[id].elem.border.color

	setRectangleBorderColor: (id, val) ->
		items[id].elem.border.color = val

	getRectangleBorderWidth: (id) ->
		items[id].elem.border.width

	setRectangleBorderWidth: (id, val) ->
		items[id].elem.border.width = val
