'use strict'

utils = require 'utils'

exports.Types =
	Item: require './level0/item'
	Image: require './level0/image'
	Text: require './level0/text'
	Rectangle: require './level1/rectangle'
	Grid: require './level1/grid'

exports.Extras =
	Binding: require './level1/binding'
	Anchors: require './level2/anchors'

exports.items = {}

exports.setWindow = (id) ->