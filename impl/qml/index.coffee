'use strict'

utils = require 'utils'

module.exports = (impl) ->
	utils.merge impl.utils, require('./utils')

	resize = ->
		item = impl.window
		return unless item

		item.width = __stylesWindow.width
		item.height = __stylesWindow.height

	__stylesWindow.widthChanged.connect resize
	__stylesWindow.heightChanged.connect resize

	Types:
		Screen: require './level0/screen'
		Item: require './level0/item'
		Image: require './level0/image'
		Text: require './level0/text'
		FontLoader: require './level0/fontLoader'

		Rectangle: require './level1/rectangle'
		Animation: require './level1/animation'
		PropertyAnimation: require './level1/animation/property'
		NumberAnimation: require './level1/animation/number'

	setWindow: (item) ->
		while child = __stylesBody.children[0]
			child.parent = null

		item._impl.elem.parent = __stylesBody
		resize()