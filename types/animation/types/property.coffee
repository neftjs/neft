'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = (Renderer, Impl, itemUtils) -> class PropertyAnimation extends Renderer.Animation
	@__name__ = 'PropertyAnimation'

	@DATA = utils.merge Object.create(@DATA),
		target: null
		property: ''
		duration: 1000
		from: null
		to: null
		updateProperty: false

	itemUtils.defineProperty @::, 'target', Impl.setPropertyAnimationTarget, null, (_super) -> (val) ->
		expect().defined(val).toBe.any Renderer.Item
		_super.call @, val

	itemUtils.defineProperty @::, 'property', Impl.setPropertyAnimationProperty, null, (_super) -> (val) ->
		expect(val).toBe.truthy().string()
		_super.call @, val

	itemUtils.defineProperty @::, 'duration', Impl.setPropertyAnimationDuration, null, (_super) -> (val) ->
		expect(val).toBe.float()
		expect(val).toBe.greaterThan 0
		_super.call @, val

	itemUtils.defineProperty @::, 'updateProperty', null, null, (_super) -> (val) ->
		expect(val).toBe.boolean()
		_super.call @, val

	utils.defineProperty @::, 'progress', utils.ENUMERABLE, ->
		Impl.getPropertyAnimationProgress.call @
	, null

	itemUtils.defineProperty @::, 'from', Impl.setPropertyAnimationFrom, null, null

	itemUtils.defineProperty @::, 'to', Impl.setPropertyAnimationTo, null, null
