Item.Transitions
================

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	List = require 'list'

	module.exports = (Renderer, Impl, itemUtils) -> class Transitions extends itemUtils.DeepObject
		@__name__ = 'Transitions'

*Transitions* Transitions(*Renderer.Item* item) : *List*
--------------------------------------------------------

		constructor: (item) ->
			return; # TODO
			expect(item).toBe.any Renderer.Item

			utils.defineProperty @, '_item', null, item

			super()

			@onInserted (elem, i) ->
				expect(elem).toBe.any Renderer.Transition
				expect(elem._item).toBe null
				elem._setItem @_item

			@onPopped (elem, i) ->
				elem._setItem null

