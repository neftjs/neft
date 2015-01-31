Renderer.PropertyAnimation
==========================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

*PropertyAnimation* PropertyAnimation([*Object* options]) : *Renderer.Animation*
--------------------------------------------------------------------------------

	module.exports = (Renderer, Impl, Animation, itemUtils) -> class PropertyAnimation extends Animation
		@__name__ = 'PropertyAnimation'

		itemUtils.initConstructor @,
			extends: Animation
			data:
				target: null
				property: ''
				duration: 1000
				delay: 0
				from: null
				to: null
				updateProperty: false

*Renderer.Item* PropertyAnimation::target
-----------------------------------------

### *Signal* PropertyAnimation::targetChanged([*Renderer.Item* oldValue])

		itemUtils.defineProperty
			constructor: @
			name: 'target'
			implementation: Impl.setPropertyAnimationTarget
			developmentSetter: (val) ->
				expect().defined(val).toBe.any Renderer.Item

*String* PropertyAnimation::property
------------------------------------

### *Signal* PropertyAnimation::propertyChanged(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'property'
			implementation: Impl.setPropertyAnimationProperty
			developmentSetter: (val) ->
				expect(val).toBe.truthy().string()

*Float* PropertyAnimation::duration = 1000
------------------------------------------

### *Signal* PropertyAnimation::durationChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'duration'
			implementation: Impl.setPropertyAnimationDuration
			developmentSetter: (val) ->
				expect(val).toBe.float()
				expect(val).toBe.greaterThan 0

*Float* PropertyAnimation::delay
--------------------------------

### *Signal* PropertyAnimation::delayChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'delay'
			implementation: Impl.setPropertyAnimationDelay
			developmentSetter: (val) ->
				expect(val).toBe.float()
				expect(val).not().toBe.lessThan 0

*Boolean* PropertyAnimation::updateProperty = false
---------------------------------------------------

### *Signal* PropertyAnimation::updatePropertyChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'updateProperty'
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

*ReadOnly* *Float* PropertyAnimation::progress = 0
--------------------------------------------------

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
