'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = (Renderer, Impl, itemUtils) -> class Animation
	@__name__ = 'Animation'

	@DATA =
		running: false
		loop: false

	constructor: (opts) ->
		expect().defined(opts).toBe.simpleObject()

		data = Object.create(@constructor.DATA)
		utils.defineProperty @, '_data', null, data

		utils.defineProperty @, '_impl', null, {}
		Impl.createAnimation @, @constructor.__name__

		itemUtils.fill @, opts

	itemUtils.defineProperty @::, 'running', null, null, (_super) -> (val) ->
		expect(val).toBe.boolean()
		_super.call @, val
		if val
			Impl.playAnimation.call @
		else
			Impl.stopAnimation.call @

	itemUtils.defineProperty @::, 'loop', Impl.setAnimationLoop, null, (_super) -> (val) ->
		expect(val).toBe.boolean()
		_super.call @, val

	play: ->
		@running = true
		return

	stop: ->
		@running = false
		return