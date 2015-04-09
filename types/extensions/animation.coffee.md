Animation
=========

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) -> class Animation extends Renderer.Extension
		@__name__ = 'Animation'

*Animation* Animation()
-----------------------

		constructor: ->
			@_loop = false
			@_updatePending = false
			@_paused = false
			super()

			Impl.createObject @, @constructor.__name__

*Boolean* Animation::when
-------------------------

### *Signal* Animation::whenChanged(*Boolean* oldValue)

*Signal* Animation::started()
-----------------------------

		signal.Emitter.createSignal @, 'started'

*Signal* Animation::stopped()
-----------------------------

		signal.Emitter.createSignal @, 'stopped'

*Boolean* Animation::running
----------------------------

### *Signal* Animation::runningChanged(*Boolean* oldValue)

		setRunningOnReady = ->
			@running = @_when

		itemUtils.defineProperty
			constructor: @
			name: 'running'
			setter: (_super) -> (val) ->
				@_when = val
				unless @_isReady
					@onReady setRunningOnReady
					return

				oldVal = @_running
				if oldVal is val
					return

				assert.isBoolean val
				_super.call @, val

				if val
					Impl.startAnimation.call @
					@started()
					if @_paused
						Impl.pauseAnimation.call @
				else
					if @_paused
						@paused = false
					Impl.stopAnimation.call @
					@stopped()
				return

*Boolean* Animation::paused
---------------------------

### *Signal* Animation::pausedChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'paused'
			setter: (_super) -> (val) ->
				oldVal = @_paused
				if oldVal is val
					return

				assert.isBoolean val
				_super.call @, val

				if val
					Impl.pauseAnimation.call @
				else
					Impl.resumeAnimation.call @
				return

*Boolean* Animation::loop
-------------------------

### *Signal* Animation::loopChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'loop'
			implementation: Impl.setAnimationLoop
			developmentSetter: (val) ->
				assert.isBoolean val

ReadOnly *Boolean* Animation::updatePending
-------------------------------------------

		utils.defineProperty @::, 'updatePending', null, ->
			@_updatePending
		, null

Animation::start()
------------------

		start: ->
			@running = true
			@

Animation::stop()
-----------------

		stop: ->
			@running = false
			@

Animation::pause()
------------------

		pause: ->
			if @running
				@paused = true
			@

Animation::resume()
-------------------

		resume: ->
			@paused = false
			@

		enable: ->
			@running = true
			super()

		disable: ->
			@running = false
			super()
