'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = (Renderer, Impl, itemUtils) -> class NumberAnimation extends Renderer.PropertyAnimation
	@__name__ = 'NumberAnimation'

	@DATA = utils.merge @DATA,
		from: 0
		to: 0