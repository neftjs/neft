Renderer.NumberAnimation @class
===============================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

*NumberAnimation* NumberAnimation([*Object* options]) : Renderer.PropertyAnimation
----------------------------------------------------------------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class NumberAnimation extends Renderer.PropertyAnimation
		@__name__ = 'NumberAnimation'

		@DATA = utils.merge @DATA,
			from: 0
			to: 0

*Float* NumberAnimation::from
-----------------------------

*Float* NumberAnimation::to
---------------------------