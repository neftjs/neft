'use strict'

utils = require 'utils'

exports.Types =
	Item: require './level0/item'
	Image: require './level0/image'
	Text: require './level0/text'
	Rectangle: require './level1/rectangle'
	Grid: require './level1/grid'
	Column: require './level1/column'
	Row: require './level1/row'
	Scrollable: require './level2/scrollable'

	Animation: require './level1/animation'
	PropertyAnimation: require './level1/animation/property'
	NumberAnimation: require './level1/animation/number'

exports.Extras =
	Binding: require './level1/binding'
	Anchors: require './level2/anchors'

exports.items = {}
exports.animations = {}
exports.utils = require './utils'

exports.setWindow = (id) ->