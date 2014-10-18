'use strict'

utils = require 'utils'

module.exports = (impl) ->
	items = impl.items = stylesWindow.items
	
	utils.merge impl.utils, require('./utils')

	resize = ->
		id = impl.window
		return unless id

		impl.setItemWidth id, stylesWindow.width
		impl.setItemHeight id, stylesWindow.height

	stylesWindow.widthChanged.connect resize
	stylesWindow.heightChanged.connect resize

	Types:
		Item: require './level0/item'
		Image: require './level0/image'
		Text: require './level0/text'

		Rectangle: require './level1/rectangle'

	setWindow: (id) ->
		while child = stylesBody.children[0]
			child.parent = null

		items[id].elem.parent = stylesBody
		resize()