Transition
==========

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) -> class Transition extends Renderer.Extension
		@__name__ = 'Transition'

*Transition* Transition()
-------------------------

		constructor: ->
			@_animation = null
			@_property = ''
			@_duration = 0
			@_to = 0
			super()

		listener = (oldVal) ->
			{animation} = @
			if not @running or animation.updatePending
				return

			{progress} = animation
			animation.stop()
			animation.duration = @_duration

			animation.from = oldVal
			@_to = animation.to = @_target[@property]
			if progress > 0
				animation.duration = @_duration * progress

			animation.start()
			return

*Boolean* Transition::when
--------------------------

### *Signal* Transition::whenChanged(*Boolean* oldValue)

*Renderer.Item* Transition::target
----------------------------------

### *Signal* Transition::targetChanged([*Renderer.Item* oldValue])

		onTargetReady = ->
			@_running = true

		itemUtils.defineProperty
			constructor: @
			name: 'target'
			developmentSetter: (val) ->
				assert.instanceOf val, Renderer.Item if val?
			setter: (_super) -> (val) ->
				oldVal = @target
				if oldVal is val
					return

				{animation, property} = @

				if animation
					animation.target = val
					animation.stop()

				_super.call @, val

				@_running = false
				val.onReady onTargetReady, @

				if property
					if oldVal
						handlerName = signal.getHandlerName "#{property}Changed"
						oldVal[handlerName].disconnect listener, @

					if val
						handlerName = signal.getHandlerName "#{property}Changed"
						val[handlerName] listener, @
				return

*Renderer.Animation* Transition::animation
------------------------------------------

### Transition::animationChanged(*Renderer.Animation* oldValue)

		onAnimationStopped = ->
			@_target?[@property] = @_to
			return

		itemUtils.defineProperty
			constructor: @
			name: 'animation'
			developmentSetter: (val) ->
				assert.instanceOf val, Renderer.Animation if val?
			setter: (_super) -> (val) ->
				oldVal = @animation
				if oldVal is val
					return

				_super.call @, val

				if oldVal
					oldVal.stop()
					val.onStopped.disconnect onAnimationStopped, @

				if val
					@_duration = val.duration
					val.target = @target
					val.property = @property
					val.onStopped onAnimationStopped, @
				return

*String* Transition::property
-----------------------------

### Transition::propertyChanged(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'property'
			setter: (_super) -> (val) ->
				oldVal = @property
				if oldVal is val
					return

				{animation, target} = @

				if animation
					animation.stop()
					animation.property = val

				_super.call @, val

				if target
					if oldVal
						handlerName = signal.getHandlerName "#{oldVal}Changed"
						target[handlerName].disconnect listener, @

					if val
						handlerName = signal.getHandlerName "#{val}Changed"
						target[handlerName] listener, @
				return
