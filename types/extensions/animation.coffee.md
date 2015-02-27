Animation
=========

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) -> class Animation extends Renderer.Extension
		@__name__ = 'Animation'

*Animation* Animation()
-----------------------

		constructor: ->
			@_impl = null
			@_loop = false
			@_updatePending = false
			super()

			Impl.createAnimation @, @constructor.__name__

*Boolean* Animation::when
-------------------------

### *Signal* Animation::whenChanged(*Boolean* oldValue)

*Signal* Animation::played()
----------------------------

		signal.Emitter.createSignal @, 'played'

*Signal* Animation::stopped()
-----------------------------

		signal.Emitter.createSignal @, 'stopped'

*Boolean* Animation::running
----------------------------

### *Signal* Animation::runningChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'running'
			setter: (_super) -> (val) ->
				oldVal = @_running
				if oldVal is val
					return

				expect(val).toBe.boolean()
				_super.call @, val

				if val
					Impl.playAnimation.call @
					@played?()
				else
					Impl.stopAnimation.call @
					@stopped?()

*Boolean* Animation::loop
-------------------------

### *Signal* Animation::loopChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'loop'
			implementation: Impl.setAnimationLoop
			developmentSetter: (val) ->
				expect(val).toBe.boolean()

ReadOnly *Boolean* Animation::updatePending
-------------------------------------------

		utils.defineProperty @::, 'updatePending', null, ->
			@_updatePending
		, null

Animation::play()
-----------------

		play: ->
			@running = true
			@

Animation::stop()
-----------------

		stop: ->
			@running = false
			@

		enable: ->
			@running = true
			super()

		disable: ->
			super()
