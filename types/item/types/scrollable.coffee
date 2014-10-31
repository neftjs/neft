'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Renderer, Impl, itemUtils) -> class Scrollable extends Renderer.Item
	@__name__ = 'Scrollable'

	@DATA = utils.merge Object.create(Renderer.Item.DATA),
		contentX: 0
		contentY: 0
		contentItem: null
		clip: true

	constructor: ->
		super

		`//<development>`
		@onChildrenChanged ->
			if @contentItem
				expect().some(@children).toBe @contentItem
		`//</development>`

	itemUtils.defineProperty @::, 'contentItem', null, (_super) -> (val) ->
		expect(val).toBe.any Renderer.Item
		oldVal = @contentItem
		val.parent = @
		_super.call @, val
		oldVal?.parent = null
		Impl.setScrollableContentItem.call @, val

	itemUtils.defineProperty @::, 'contentX', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setScrollableContentX.call @, val

	itemUtils.defineProperty @::, 'contentY', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setScrollableContentY.call @, val