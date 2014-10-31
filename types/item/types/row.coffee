'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Renderer, Impl, itemUtils) -> class Row extends Renderer.Item
	@__name__ = 'Row'
	@__path__ = 'Renderer.Row'

	@DATA = utils.merge Object.create(Renderer.Item.DATA),
		spacing: 0

	itemUtils.defineProperty @::, 'spacing', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setRowSpacing.call @, val
