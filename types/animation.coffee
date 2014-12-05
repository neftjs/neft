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

	constructor: (opts) ->
		expect().defined(opts).toBe.simpleObject()

		data = Object.create(@constructor.DATA)
		utils.defineProperty @, '_data', null, data

		utils.defineProperty @, '_impl', null, {}
		Impl.createAnimation @, @constructor.__name__

		itemUtils.fill @, opts

	signal.createLazy @::, 'played'
	signal.createLazy @::, 'stopped'

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

	itemUtils.defineProperty @::, 'loop', Impl.setAnimationLoop, null, (_super) -> (val) ->
		expect(val).toBe.boolean()
		_super.call @, val

	utils.defineProperty @::, 'updatePending', null, ->
		@_data.updatePending
	, null

	play: ->
		@running = true
		return

	stop: ->
		@running = false
		return