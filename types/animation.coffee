'use strict'

utils = require 'utils'
expect = require 'expect'

# TODO: use Dict
module.exports = (Renderer, Impl) -># class Animation
	#@__name__ = 'Animation'

	return {} # TODO

	constructor: (opts) ->
		expect(opts).toBe.simpleObject()

		utils.defProp @, '_uid', '', uid = utils.uid()
		Impl.createAnimation.call @, @constructor.__name__
		utils.merge @, opts

		Object.freeze @

	utils.defProp @::, 'name', 'e', null, (val) ->
		expect(val).toBe.truthy().string()

		utils.defProp @, 'name', 'e', val

	utils.defProp @::, 'running', 'e', ->
		Impl.getAnimationRunning @_uid
	, (val) ->
		expect(val).toBe.boolean()

		if val
			Impl.playAnimation @_uid
		else
			Impl.stopAnimation @_uid

	utils.defProp @::, 'loop', 'e', ->
		Impl.getAnimationLoop @_uid
	, (val) ->
		expect(val).toBe.boolean()
		Impl.setAnimationLoop @_uid, val

	play: ->
		Impl.playAnimation @_uid
		@

	stop: ->
		Impl.stopAnimation @_uid
		@