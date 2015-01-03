Renderer.Scrollable
===================

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

*Scrollable* Scrollable([*Object* options, *Array* children]) : Renderer.Item
-----------------------------------------------------------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class Scrollable extends Renderer.Item
		@__name__ = 'Scrollable'
		@__path__ = 'Renderer.Scrollable'

		@DATA = utils.merge Object.create(Renderer.Item.DATA),
			contentX: 0
			contentY: 0
			contentItem: null
			clip: true

		constructor: ->
			super

			`//<development>`
			@onReady ->
				{contentItem} = @
				expect().some(@children).toBe contentItem
			`//</development>`

[*Renderer.Item*] Scrollable::contentItem
-----------------------------------------

### *Signal* Scrollable::contentItemChanged([*Renderer.Item* oldValue])

		itemUtils.defineProperty @::, 'contentItem', Impl.setScrollableContentItem, null, (_super) -> (val) ->
			expect(val).toBe.any Renderer.Item
			oldVal = @contentItem
			val.parent = @
			_super.call @, val
			oldVal?.parent = null

*Float* Scrollable::contentX
----------------------------

### *Signal* Scrollable::contentXChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'contentX', Impl.setScrollableContentX, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val

*Float* Scrollable::contentY
----------------------------

### *Signal* Scrollable::contentYChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'contentY', Impl.setScrollableContentY, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
