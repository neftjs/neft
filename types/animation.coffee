'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = (Scope, Impl) -> class Animation
	@__name__ = 'Animation'

	@create = (scopeId, opts) ->
		animation = new @
		Impl.createAnimation @__name__, animation._id
		utils.merge animation, opts
		animation

	constructor: ->
		utils.defProp @, '_id', 'w', utils.uid()
		utils.defProp @, '_name', 'w', ''

		Object.seal @

	utils.defProp @::, 'name', 'e', ->
		@_name
	, (val) ->
		@_name = val

	utils.defProp @::, 'running', 'e', ->
		Impl.getAnimationRunning @_id
	, (val) ->
		expect(val).toBe.boolean()

		if val
			Impl.playAnimation @_id
		else
			Impl.stopAnimation @_id

	utils.defProp @::, 'loop', 'e', ->
		Impl.getAnimationLoop @_id
	, (val) ->
		expect(val).toBe.boolean()
		Impl.setAnimationLoop @_id, val

	play: ->
		Impl.playAnimation @_id
		@

	stop: ->
		Impl.stopAnimation @_id
		@