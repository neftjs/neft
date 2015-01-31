Renderer.NumberAnimation
========================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

*NumberAnimation* NumberAnimation([*Object* options]) : Renderer.PropertyAnimation
----------------------------------------------------------------------------------

	module.exports = (Renderer, Impl, Animation, itemUtils) -> class NumberAnimation extends Animation.Property
		@__name__ = 'NumberAnimation'

		itemUtils.initConstructor @,
			extends: Animation.Property
			data:
				from: 0
				to: 0

*Float* NumberAnimation::from
-----------------------------

*Float* NumberAnimation::to
---------------------------