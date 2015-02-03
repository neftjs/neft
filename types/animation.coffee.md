Renderer.Animation
==================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) -> class Animation
		@__name__ = 'Animation'

		itemUtils.initConstructor @,
			data:
				running: false
				loop: false
				updatePending: false

		@Property = require('./animation/types/property') Renderer, Impl, @, itemUtils
		@Number = require('./animation/types/property/types/number') Renderer, Impl, @, itemUtils

*Animation* Animation([*Object* options])
-----------------------------------------

		constructor: (opts) ->
			expect().defined(opts).toBe.simpleObject()

			itemUtils.initObject @, Impl.createAnimation
			itemUtils.fill @, opts

*Signal* Animation::played()
----------------------------

		signal.createLazy @::, 'played'

*Signal* Animation::stopped()
-----------------------------

		signal.createLazy @::, 'stopped'

*Boolean* Animation::running
----------------------------

		itemUtils.defineProperty
			constructor: @
			name: 'running'
			setter: (_super) -> (val) ->
				oldVal = @_data.running
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

		itemUtils.defineProperty
			constructor: @
			name: 'loop'
			implementation: Impl.setAnimationLoop
			developmentSetter: (val) ->
				expect(val).toBe.boolean()

ReadOnly *Boolean* Animation::updatePending
-------------------------------------------

		utils.defineProperty @::, 'updatePending', null, ->
			@_data.updatePending
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
