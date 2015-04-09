Basic items/AmbientSound
========================

	'use strict'

	assert = require 'neft-assert'
	utils = require 'utils'
	signal = require 'signal'
	List = require 'list'

	{isArray} = Array
	SignalsEmitter = signal.Emitter

	assert = assert.scope 'Renderer.AmbientSound'

	module.exports = (Renderer, Impl, itemUtils) -> class AmbientSound extends itemUtils.Object
		@__name__ = 'AmbientSound'
		@__path__ = 'Renderer.AmbientSound'

*AmbientSound* AmbientSound()
-----------------------------

		constructor: ->
			@_impl = null
			@_when = false
			@_running = false
			@_source = ''
			@_loop = false
			super()
			Object.preventExtensions @

			Impl.createObject @, @constructor.__name__

*Signal* AmbientSound::started()
--------------------------------

		signal.Emitter.createSignal @, 'started'

*Signal* AmbientSound::stopped()
--------------------------------

		signal.Emitter.createSignal @, 'stopped'

*Boolean* AmbientSound::running
-------------------------------

### *Signal* AmbientSound::runningChanged(*Boolean* oldValue)

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
					Impl.startAmbientSound.call @
					@started()
				else
					Impl.stopAmbientSound.call @
					@stopped()
				return

*String* AmbientSound::source = ''
----------------------------------

### *Signal* AmbientSound::sourceChanged(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'source'
			implementation: Impl.setAmbientSoundSource
			developmentSetter: (val) ->
				assert.isString val, '::source setter ...'

*Boolean* AmbientSound::loop = false
------------------------------------

### *Signal* AmbientSound::loopChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'loop'
			implementation: Impl.setAmbientSoundLoop
			developmentSetter: (val) ->
				assert.isBoolean val, '::loop setter ...'

AmbientSound::start()
---------------------

		start: ->
			@running = true
			@

AmbientSound::stop()
--------------------

		stop: ->
			@running = false
			@
