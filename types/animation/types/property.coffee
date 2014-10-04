'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = (Scope, Impl) -> class PropertyAnimation extends Scope.Animation
	@__name__ = 'PropertyAnimation'

	utils.defProp @::, 'target', 'e', ->
		Impl.getPropertyAnimationTarget @_id
	, (val) ->
		# expect(val).toBe.any Scope.Item
		Impl.setPropertyAnimationTarget @_id, val

	utils.defProp @::, 'property', 'e', ->
		Impl.getPropertyAnimationProperty @_id
	, (val) ->
		expect(val).toBe.truthy().string()
		Impl.setPropertyAnimationProperty @_id, val

	utils.defProp @::, 'duration', 'e', ->
		Impl.getPropertyAnimationDuration @_id
	, (val) ->
		expect(val).toBe.integer()
		expect(val).toBe.greaterThan 0
		Impl.setPropertyAnimationDuration @_id, val

	utils.defProp @::, 'from', 'e', ->
		Impl.getPropertyAnimationFrom @_id
	, (val) ->
		Impl.setPropertyAnimationFrom @_id, val

	utils.defProp @::, 'to', 'e', ->
		Impl.getPropertyAnimationTo @_id
	, (val) ->
		Impl.setPropertyAnimationTo @_id, val