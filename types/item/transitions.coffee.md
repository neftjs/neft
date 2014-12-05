Item.Transitions
================

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	List = require 'list'

	module.exports = (Renderer) -> class Transitions extends List
		@__name__ = 'Transitions'

*Transitions* Transitions(*Renderer.Item* item) @low-level
----------------------------------------------------------

		constructor: (item) ->
			expect(item).toBe.any Renderer.Item

			utils.defineProperty @, '_item', null, item

			super()

			@onInserted (i, elem) ->
				expect(elem).toBe.any Renderer.Transition
				expect(elem._item).toBe null
				elem._setItem @_item

			@onPopped (i, elem) ->
				elem._setItem null

