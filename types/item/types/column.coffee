'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Renderer, Impl, itemUtils) -> class Column extends Renderer.Item
	@__name__ = 'Column'

	@DATA = utils.merge Object.create(Renderer.Item.DATA),
		spacing: 0

	itemUtils.defineProperty @::, 'spacing', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setColumnSpacing.call @, val
