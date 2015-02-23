Animation/NumberAnimation
=========================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

*NumberAnimation* NumberAnimation() : *Renderer.Animation.Property*
-------------------------------------------------------------------

	module.exports = (Renderer, Impl, Animation, itemUtils) -> class NumberAnimation extends Animation.Property
		@__name__ = 'NumberAnimation'

		constructor: ->
			@_from = 0
			@_to = 0
			super()

*Float* NumberAnimation::from
-----------------------------

*Float* NumberAnimation::to
---------------------------