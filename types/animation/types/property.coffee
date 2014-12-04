'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = (Renderer, Impl, itemUtils) -> class PropertyAnimation extends Renderer.Animation
	@__name__ = 'PropertyAnimation'

	itemUtils.defineProperty @::, 'target', null, (_super) -> (val) ->
		expect(val).toBe.any Renderer.Item
		_super.call @, val
		Impl.setPropertyAnimationTarget.call @, val

	itemUtils.defineProperty @::, 'property', null, (_super) -> (val) ->
		expect(val).toBe.truthy().string()
		_super.call @, val
		Impl.setPropertyAnimationProperty.call @, val

	itemUtils.defineProperty @::, 'duration', null, (_super) -> (val) ->
		expect(val).toBe.integer()
		expect(val).toBe.greaterThan 0
		_super.call @, val
		Impl.setPropertyAnimationDuration.call @, val

	itemUtils.defineProperty @::, 'from', null, (_super) -> (val) ->
		_super.call @, val
		Impl.setPropertyAnimationFrom.call @, val

	itemUtils.defineProperty @::, 'to', null, (_super) -> (val) ->
		_super.call @, val
		Impl.setPropertyAnimationTo.call @, val