'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Renderer, Impl) -> class Row extends Renderer.Item
	@__name__ = 'Row'

	@DATA = utils.merge Object.create(Renderer.Item.DATA),
		spacing: 0

	Dict.defineProperty @::, 'spacing'

	utils.defProp @::, 'spacing', 'e', utils.lookupGetter(@::, 'spacing')
	, do (_super = utils.lookupSetter @::, 'spacing') -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setRowSpacing.call @, val
