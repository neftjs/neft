Animation/PropertyAnimation
===========================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

*PropertyAnimation* PropertyAnimation() : *Renderer.Animation*
--------------------------------------------------------------

	module.exports = (Renderer, Impl, Animation, itemUtils) -> class PropertyAnimation extends Animation
		@__name__ = 'PropertyAnimation'

		constructor: ->
			@_target = null
			@_property = ''
			super()

*Renderer.Item* PropertyAnimation::target
-----------------------------------------

### *Signal* PropertyAnimation::targetChanged(*Renderer.Item* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'target'
			defaultValue: null
			implementation: Impl.setPropertyAnimationTarget
			developmentSetter: (val) ->
				expect().defined(val).toBe.any Renderer.Item

*String* PropertyAnimation::property
------------------------------------

### *Signal* PropertyAnimation::propertyChanged(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'property'
			defaultValue: ''
			implementation: Impl.setPropertyAnimationProperty
			developmentSetter: (val) ->
				expect(val).toBe.truthy().string()

*Float* PropertyAnimation::duration = 1000
------------------------------------------

### *Signal* PropertyAnimation::durationChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'duration'
			defaultValue: 1000
			implementation: Impl.setPropertyAnimationDuration
			developmentSetter: (val) ->
				expect(val).toBe.float()
				expect(val).toBe.greaterThan 0

*Float* PropertyAnimation::delay = 0
------------------------------------

### *Signal* PropertyAnimation::delayChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'delay'
			defaultValue: 0
			implementation: Impl.setPropertyAnimationDelay
			developmentSetter: (val) ->
				expect(val).toBe.float()
				expect(val).not().toBe.lessThan 0

*Boolean* PropertyAnimation::updateProperty = true
---------------------------------------------------

### *Signal* PropertyAnimation::updatePropertyChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'updateProperty'
			defaultValue: true
			developmentSetter: (val) ->
				expect(val).toBe.boolean()

*Any* PropertyAnimation::from
-----------------------------

### *Signal* PropertyAnimation::fromChanged(*Any* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'from'
			implementation: Impl.setPropertyAnimationFrom

*Any* PropertyAnimation::to
---------------------------

### *Signal* PropertyAnimation::toChanged(*Any* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'to'
			implementation: Impl.setPropertyAnimationTo

ReadOnly *Float* PropertyAnimation::progress = 0
------------------------------------------------

		utils.defineProperty @::, 'progress', null, ->
			Impl.getPropertyAnimationProgress.call @
		, null

PropertyAnimation::reverse()
----------------------------

		reverse: ->
			tmp = @to
			@to = @from
			@from = tmp
			@
