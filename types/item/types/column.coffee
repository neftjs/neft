'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Renderer, Impl) -> class Column extends Renderer.Item
	@__name__ = 'Column'

	@DATA = utils.merge Object.create(Renderer.Item.DATA),
		spacing: 0

	Dict.defineProperty @::, 'spacing'

	utils.defProp @::, 'spacing', 'e', utils.lookupGetter(@::, 'spacing')
	, do (_super = utils.lookupSetter @::, 'spacing') -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setColumnSpacing.call @, val
