Renderer.Animation @class
=========================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) -> class Animation
		@__name__ = 'Animation'

		@DATA =
			running: false
			loop: false
			updatePending: false

*Animation* Animation([*Object* options])
-----------------------------------------

		constructor: (opts) ->
			expect().defined(opts).toBe.simpleObject()

			data = Object.create(@constructor.DATA)
			utils.defineProperty @, '_data', null, data

			utils.defineProperty @, '_impl', null, {}
			Impl.createAnimation @, @constructor.__name__

			itemUtils.fill @, opts

Animation::played()
-------------------

		signal.createLazy @::, 'played'

Animation::stopped()
--------------------

		signal.createLazy @::, 'stopped'

*Boolean* Animation::running
----------------------------

		itemUtils.defineProperty @::, 'running', null, null, (_super) -> (val) ->
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

		itemUtils.defineProperty @::, 'loop', Impl.setAnimationLoop, null, (_super) -> (val) ->
			expect(val).toBe.boolean()
			_super.call @, val

*Boolean* Animation::updatePending
----------------------------------

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