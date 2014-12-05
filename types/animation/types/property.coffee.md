Renderer.PropertyAnimation @class
=================================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

*PropertyAnimation* PropertyAnimation([*Object* options]) : Renderer.Animation
------------------------------------------------------------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class PropertyAnimation extends Renderer.Animation
		@__name__ = 'PropertyAnimation'

		@DATA = utils.merge Object.create(@DATA),
			target: null
			property: ''
			duration: 1000
			from: null
			to: null
			updateProperty: false

*Renderer.Item* PropertyAnimation::target
-----------------------------------------

### PropertyAnimation::targetChanged([*Renderer.Item* oldValue])

		itemUtils.defineProperty @::, 'target', Impl.setPropertyAnimationTarget, null, (_super) -> (val) ->
			expect().defined(val).toBe.any Renderer.Item
			_super.call @, val

*String* PropertyAnimation::property
------------------------------------

### PropertyAnimation::propertyChanged(*String* oldValue)

		itemUtils.defineProperty @::, 'property', Impl.setPropertyAnimationProperty, null, (_super) -> (val) ->
			expect(val).toBe.truthy().string()
			_super.call @, val

*Float* PropertyAnimation::duration = 1000
------------------------------------------

### PropertyAnimation::durationChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'duration', Impl.setPropertyAnimationDuration, null, (_super) -> (val) ->
			expect(val).toBe.float()
			expect(val).toBe.greaterThan 0
			_super.call @, val

*Boolean* PropertyAnimation::updateProperty = false
---------------------------------------------------

PropertyAnimation::updatePropertyChanged(*Boolean* oldValue)

		itemUtils.defineProperty @::, 'updateProperty', null, null, (_super) -> (val) ->
			expect(val).toBe.boolean()
			_super.call @, val

*Any* PropertyAnimation::from
-----------------------------

### PropertyAnimation::fromChanged(*Any* oldValue)

		itemUtils.defineProperty @::, 'from', Impl.setPropertyAnimationFrom, null, null

*Any* PropertyAnimation::to
---------------------------

### PropertyAnimation::toChanged(*Any* oldValue)

		itemUtils.defineProperty @::, 'to', Impl.setPropertyAnimationTo, null, null

*ReadOnly* *Float* PropertyAnimation::progress = 0
--------------------------------------------------

		utils.defineProperty @::, 'progress', utils.ENUMERABLE, ->
			Impl.getPropertyAnimationProgress.call @
		, null

PropertyAnimation::reverse()
----------------------------

		reverse: ->
			tmp = @to
			@to = @from
			@from = tmp
			@