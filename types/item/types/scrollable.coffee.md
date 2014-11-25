Renderer.Scrollable
===================

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	Dict = require 'dict'

*Scrollable* Scrollable([*Object* options, *Array* children])
-------------------------------------------------------------

**Extends:** `Renderer.Item`

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
			@onChildrenChanged ->
				{contentItem} = @
				if contentItem
					expect().some(@children).toBe contentItem
			`//</development>`

*[Renderer.Item]* Scrollable::contentItem
-----------------------------------------

### Scrollable::contentItemChanged(*[Renderer.Item]* oldValue)

		itemUtils.defineProperty @::, 'contentItem', null, (_super) -> (val) ->
			expect(val).toBe.any Renderer.Item
			oldVal = @contentItem
			val.parent = @
			_super.call @, val
			oldVal?.parent = null
			Impl.setScrollableContentItem.call @, val

*Float* Scrollable::contentX
----------------------------

### Scrollable::contentXChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'contentX', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setScrollableContentX.call @, val

*Float* Scrollable::contentY
----------------------------

### Scrollable::contentYChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'contentY', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setScrollableContentY.call @, val