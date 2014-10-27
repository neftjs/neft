'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = (Renderer, Impl) -> class PropertyAnimation extends Renderer.Animation
	@__name__ = 'PropertyAnimation'

	utils.defProp @::, 'target', 'e', ->
		Impl.getPropertyAnimationTarget @_uid
	, (val) ->
		expect(val).toBe.any Renderer.Item
		Impl.setPropertyAnimationTarget @_uid, val._uid

	utils.defProp @::, 'property', 'e', ->
		Impl.getPropertyAnimationProperty @_uid
	, (val) ->
		expect(val).toBe.truthy().string()
		Impl.setPropertyAnimationProperty @_uid, val

	utils.defProp @::, 'duration', 'e', ->
		Impl.getPropertyAnimationDuration @_uid
	, (val) ->
		expect(val).toBe.integer()
		expect(val).toBe.greaterThan 0
		Impl.setPropertyAnimationDuration @_uid, val

	utils.defProp @::, 'from', 'e', ->
		Impl.getPropertyAnimationFrom @_uid
	, (val) ->
		Impl.setPropertyAnimationFrom @_uid, val

	utils.defProp @::, 'to', 'e', ->
		Impl.getPropertyAnimationTo @_uid
	, (val) ->
		Impl.setPropertyAnimationTo @_uid, val