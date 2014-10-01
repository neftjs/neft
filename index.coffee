'use strict'

exports.Item = require './item'
exports.Image = require './item/types/image'
exports.Text = require './item/types/text'
exports.Rectangle = require './item/types/rectangle'

Impl = require './impl'

if window? and window+'' is '[object Window]'
	exports.window = exports.Item.create {}
	Impl.setWindow exports.window