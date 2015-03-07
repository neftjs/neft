Animation/PropertyAnimation
===========================

	'use strict'

	utils = require 'utils'
	assert = require 'assert'

*PropertyAnimation* PropertyAnimation() : *Renderer.Animation*
--------------------------------------------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class PropertyAnimation extends Renderer.Animation
		@__name__ = 'PropertyAnimation'

		constructor: ->
			@_target = null
			@_property = ''
			@_autoFrom = true
			super()

		getter = utils.lookupGetter @::, 'running'
		setter = utils.lookupSetter @::, 'running'
		utils.defineProperty @::, 'running', null, getter, do (_super = setter) -> (val) ->
			if val and @_autoFrom and @_target
				@from = @_target[@_property]
				@_autoFrom = true
			_super.call @, val
			return

*Renderer.Item* PropertyAnimation::target
-----------------------------------------

### *Signal* PropertyAnimation::targetChanged(*Renderer.Item* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'target'
			defaultValue: null
			implementation: Impl.setPropertyAnimationTarget
			developmentSetter: (val) ->
				if val?
					assert.instanceOf val, Renderer.Item

*String* PropertyAnimation::property
------------------------------------

### *Signal* PropertyAnimation::propertyChanged(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'property'
			defaultValue: ''
			implementation: Impl.setPropertyAnimationProperty
			developmentSetter: (val) ->
				assert.isString val

*Float* PropertyAnimation::duration = 1000
------------------------------------------

### *Signal* PropertyAnimation::durationChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'duration'
			defaultValue: 1000
			implementation: Impl.setPropertyAnimationDuration
			developmentSetter: (val) ->
				assert.isFloat val
			setter: (_super) -> (val) ->
				if val < 0
					_super.call @, 0
				else
					_super.call @, val
				return

*Float* PropertyAnimation::delay = 0
------------------------------------

### *Signal* PropertyAnimation::delayChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'delay'
			defaultValue: 0
			implementation: Impl.setPropertyAnimationDelay
			developmentSetter: (val) ->
				assert.isFloat val
			setter: (_super) -> (val) ->
				if val < 0
					_super.call @, 0
				else
					_super.call @, val
				return

*Boolean* PropertyAnimation::updateData = false
-----------------------------------------------

### *Signal* PropertyAnimation::updateDataChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'updateData'
			defaultValue: false
			implementation: Impl.setPropertyAnimationUpdateData
			developmentSetter: (val) ->
				assert.isBoolean val
			setter: (_super) -> (val) ->
				unless val
					@updateProperty = false
				_super.call @, val
				return

*Boolean* PropertyAnimation::updateProperty = false
---------------------------------------------------

### *Signal* PropertyAnimation::updatePropertyChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'updateProperty'
			defaultValue: false
			implementation: Impl.setPropertyAnimationUpdateProperty
			developmentSetter: (val) ->
				assert.isBoolean val
			setter: (_super) -> (val) ->
				@updateData = true
				_super.call @, val
				return

*Any* PropertyAnimation::from
-----------------------------

### *Signal* PropertyAnimation::fromChanged(*Any* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'from'
			implementation: Impl.setPropertyAnimationFrom
			setter: (_super) -> (val) ->
				@_autoFrom = false;
				_super.call @, val
				return

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
