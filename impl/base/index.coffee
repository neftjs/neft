'use strict'

utils = require 'utils'

exports.Types =
	Item: require './level0/item'
	Image: require './level0/image'
	Rectangle: require './level1/rectangle'

exports.Extras =
	Binding: require './level1/binding'
	Anchors: require './level2/anchors'

exports.items = {}

exports.setWindow = (id) ->