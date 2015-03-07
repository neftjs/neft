Animation/NumberAnimation
=========================

	'use strict'

	utils = require 'utils'

*NumberAnimation* NumberAnimation() : *Renderer.PropertyAnimation*
-------------------------------------------------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class NumberAnimation extends Renderer.PropertyAnimation
		@__name__ = 'NumberAnimation'

		constructor: ->
			@_from = 0
			@_to = 0
			super()

*Float* NumberAnimation::from
-----------------------------

*Float* NumberAnimation::to
---------------------------