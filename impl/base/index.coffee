'use strict'

utils = require 'utils'

exports.Types =
	Item: require './level0/item'
	Image: require './level0/image'
	Rectangle: require './level1/rectangle'

exports.items = {}

exports.setWindow = (id) ->