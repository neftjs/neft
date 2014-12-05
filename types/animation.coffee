'use strict'

utils = require 'utils'
expect = require 'expect'
Dict = require 'dict'

module.exports = (Renderer, Impl, itemUtils) -> class Animation extends Dict
	@__name__ = 'Animation'

	@DATA =
		running: false
		loop: false

	constructor: (opts) ->
		expect().defined(opts).toBe.simpleObject()

		utils.defineProperty @, '_impl', null, {}
		super Object.create(@constructor.DATA)
		Impl.createAnimation @, @constructor.__name__
		itemUtils.fill @, opts

	itemUtils.defineProperty @::, 'running', null, (_super) -> (val) ->
		expect(val).toBe.boolean()
		_super.call @, val
		if val
			Impl.playAnimation.call @
		else
			Impl.stopAnimation.call @

	itemUtils.defineProperty @::, 'loop', null, (_super) -> (val) ->
		expect(val).toBe.boolean()
		_super.call @, val
		Impl.setAnimationLoop.call @, val

	play: ->
		@running = true
		return

	stop: ->
		@running = false
		return