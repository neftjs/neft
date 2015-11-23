Animation @modifier
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
			super()
			@_loop = false
			@_updatePending = false
			@_paused = false

*Boolean* Animation::when
-------------------------

### *Signal* Animation::onWhenChange(*Boolean* oldValue)

*Signal* Animation::onStart()
-----------------------------

		signal.Emitter.createSignal @, 'onStart'

*Signal* Animation::onStop()
----------------------------

		signal.Emitter.createSignal @, 'onStop'

*Boolean* Animation::running
----------------------------

### *Signal* Animation::onRunningChange(*Boolean* oldValue)

		# setRunningOnReady = ->
		# 	@running = @_when

		itemUtils.defineProperty
			constructor: @
			name: 'running'
			setter: (_super) -> (val) ->
				@_when = val
				# unless @_isReady
				# 	@onReady setRunningOnReady
				# 	return

				oldVal = @_running
				if oldVal is val
					return

				assert.isBoolean val
				_super.call @, val

				if val
					Impl.startAnimation.call @
					@onStart.emit()
					if @_paused
						Impl.pauseAnimation.call @
				else
					if @_paused
						@paused = false
					Impl.stopAnimation.call @
					@onStop.emit()
				return

*Boolean* Animation::paused
---------------------------

### *Signal* Animation::onPausedChange(*Boolean* oldValue)

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

### *Signal* Animation::onLoopChange(*Boolean* oldValue)

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
