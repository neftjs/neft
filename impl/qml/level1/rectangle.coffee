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
	{Item} = impl.Types

	create: (item) ->
		elem = item._impl.elem ?= impl.utils.createQmlObject 'Rectangle'

		Item.create item

		elem.color = 'transparent'

	setRectangleColor: (val) ->
		@_impl.elem.color = toQtColor val

	setRectangleRadius: (val) ->
		@_impl.elem.radius = val

	setRectangleBorderColor: (val) ->
		@_impl.elem.border.color = val

	setRectangleBorderWidth: (val) ->
		@_impl.elem.border.width = val
