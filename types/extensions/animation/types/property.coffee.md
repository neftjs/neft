Animation/PropertyAnimation @modifier
===========================

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	log = require 'log'

	log = log.scope 'Renderer', 'PropertyAnimation'

*PropertyAnimation* PropertyAnimation() : *Renderer.Animation*
--------------------------------------------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class PropertyAnimation extends Renderer.Animation
		@__name__ = 'PropertyAnimation'

		constructor: (component) ->
			super component
			@_target = null
			@_property = ''
			@_autoFrom = true
			@_duration = 250
			@_startDelay = 0
			@_loopDelay = 0
			@_updateData = false
			@_updateProperty = false
			@_easing = null

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

### *Signal* PropertyAnimation::onTargetChange(*Renderer.Item* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'target'
			defaultValue: null
			implementation: Impl.setPropertyAnimationTarget
			setter: (_super) -> (val) ->
				oldVal = @_target

				if oldVal
					utils.remove oldVal._extensions, @

				if val
					val._extensions.push @

				_super.call @, val
				return

*String* PropertyAnimation::property
------------------------------------

### *Signal* PropertyAnimation::onPropertyChange(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'property'
			defaultValue: ''
			implementation: Impl.setPropertyAnimationProperty
			developmentSetter: (val) ->
				assert.isString val

*Float* PropertyAnimation::duration = 250
-----------------------------------------

### *Signal* PropertyAnimation::onDurationChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'duration'
			defaultValue: 250
			implementation: Impl.setPropertyAnimationDuration
			developmentSetter: (val) ->
				assert.isFloat val
			setter: (_super) -> (val) ->
				if val < 0
					_super.call @, 0
				else
					_super.call @, val
				return

*Float* PropertyAnimation::startDelay = 0
-----------------------------------------

### *Signal* PropertyAnimation::onStartDelayChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'startDelay'
			defaultValue: 0
			implementation: Impl.setPropertyAnimationStartDelay
			developmentSetter: (val) ->
				assert.isFloat val

*Float* PropertyAnimation::loopDelay = 0
----------------------------------------

### *Signal* PropertyAnimation::onLoopDelayChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'loopDelay'
			defaultValue: 0
			implementation: Impl.setPropertyAnimationLoopDelay
			developmentSetter: (val) ->
				assert.isFloat val

*Float* PropertyAnimation::delay = 0
------------------------------------

### *Signal* PropertyAnimation::onDelayChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'delay'
			defaultValue: 0
			developmentSetter: (val) ->
				assert.isFloat val
			getter: (_super) -> (val) ->
				if @_startDelay is @_loopDelay
					@_startDelay
				else
					throw new Error "startDelay and loopDelay are different"
			setter: (_super) -> (val) ->
				@startDelay = val
				@loopDelay = val
				_super.call @, val
				return

*Boolean* PropertyAnimation::updateData = false
-----------------------------------------------

### *Signal* PropertyAnimation::onUpdateDataChange(*Boolean* oldValue)

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

### *Signal* PropertyAnimation::onUpdatePropertyChange(*Boolean* oldValue)

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

### *Signal* PropertyAnimation::onFromChange(*Any* oldValue)

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

### *Signal* PropertyAnimation::onToChange(*Any* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'to'
			implementation: Impl.setPropertyAnimationTo

ReadOnly *Float* PropertyAnimation::progress = 0
------------------------------------------------

		utils.defineProperty @::, 'progress', null, ->
			Impl.getPropertyAnimationProgress.call @
		, null

*Easing* PropertyAnimation::easing
----------------------------------

### *Signal* PropertyAnimation::onEasingChange(*Easing* value)
	
		utils.defineProperty @::, 'easing', null, ->
			@_easing ||= new Easing(@)
		, (val) ->
			if typeof val is 'string'
				@easing.type = val
			else if utils.isObject(val)
				utils.merge @easing, val
			else if not val
				@easing.type = 'Linear'

*Easing* Easing()
-----------------

		class Easing extends itemUtils.DeepObject
			constructor: (ref) ->
				@_type = 'Linear'
				super ref

*String* Easing::type = 'Linear'
--------------------------------

Supported easing functions:
*Linear*, *InQuad*, *OutQuad*, *InOutQuad*, *InCubic*, *OutCubic*,
*InOutCubic*, *InQuart*, *OutQuart*, *InOutQuart*, *InQuint*, *OutQuint*,
*InOutQuint*, *InSine*, *OutSine*, *InOutSine*, *InExpo*, *OutExpo*,
*InOutExpo*, *InCirc*, *OutCirc*, *InOutCirc*, *InElastic*, *OutElastic*,
*InOutElastic*, *InBack*, *OutBack*, *InOutBack*, *InBounce*, *OutBounce*,
*InOutBounce*.

			EASINGS = ['Linear', 'InQuad', 'OutQuad', 'InOutQuad', 'InCubic', 'OutCubic',
				'InOutCubic', 'InQuart', 'OutQuart', 'InOutQuart', 'InQuint', 'OutQuint',
				'InOutQuint', 'InSine', 'OutSine', 'InOutSine', 'InExpo', 'OutExpo',
				'InOutExpo', 'InCirc', 'OutCirc', 'InOutCirc', 'InElastic', 'OutElastic',
				'InOutElastic', 'InBack', 'OutBack', 'InOutBack', 'InBounce', 'OutBounce',
				'InOutBounce']

			EASING_ALIASES = Object.create(null)
			for easing in EASINGS
				EASING_ALIASES[easing] = easing
				EASING_ALIASES[easing.toLowerCase()] = easing

### *Signal* Easing::onTypeChange(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'type'
				defaultValue: 'Linear'
				namespace: 'easing'
				parentConstructor: PropertyAnimation
				implementation: Impl.setPropertyAnimationEasingType
				developmentSetter: (val) ->
					if val
						assert.isString val
				setter: (_super) -> (val) ->
					unless val
						val = 'Linear'

					type = EASING_ALIASES[val]
					type ||= EASING_ALIASES[val.toLowerCase()]
					unless type
						log.warn "Easing type not recognized; '#{val}' given"
						type = 'Linear'
					_super.call @, type
					return
