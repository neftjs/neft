'use strict'

exports.Item = require './item'
exports.Image = require './item/image'
exports.Rectangle = require './item/rectangle'

Impl = require './impl'

if window? and window+'' is '[object Window]'
	exports.window = exports.Item.create {}
	Impl.setWindow exports.window