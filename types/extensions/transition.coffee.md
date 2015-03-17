Transition
==========

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	signal = require 'signal'
	log = require 'log'

	log = log.scope 'Renderer', 'Transition'

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
			if not @_isReady or not @running or animation.updatePending
				return

			@_to = @_target[@property]

			{progress} = animation
			animation.stop()
			animation.duration = @_duration

			if animation.from is oldVal and animation.to is @_to
				return

			animation.from = oldVal
			animation.to = @_to
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
				if val instanceof itemUtils.Object
					item = val
				else if val instanceof itemUtils.MutableDeepObject
					item = val._ref
				else
					setImmediate onTargetReady.bind(@)

				if item
					if item._isReady
						@_running = true
					else
						item.onReady onTargetReady, @

				if property
					if oldVal
						handlerName = signal.getHandlerName "#{property}Changed"
						oldVal[handlerName]?.disconnect listener, @

					if val
						if handlerName of val
							handlerName = signal.getHandlerName "#{property}Changed"
							val[handlerName] listener, @
						else
							log.error "'#{property}' property signal not found"
				return

*Renderer.Animation* Transition::animation
------------------------------------------

### Transition::animationChanged(*Renderer.Animation* oldValue)

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

				if val
					@_duration = val.duration
					val.target = @target
					val.property = @property
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

				if target and val.indexOf('.') isnt -1
					chains = val.split '.'
					n = chains.length
					for chain, i in chains when i < n-1
						target = target[chain]
						unless target
							log.error "No object found for the '#{val}' property"
							break
					val = chains[n-1]
					@target = target

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
