'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Renderer, Impl) -> class Scrollable extends Renderer.Item
	@__name__ = 'Scrollable'

	@DATA = utils.merge Object.create(Renderer.Item.DATA),
		contentX: 0
		contentY: 0

	Dict.defineProperty @::, 'contentX'

	utils.defProp @::, 'contentX', 'e', utils.lookupGetter(@::, 'contentX')
	, do (_super = utils.lookupSetter @::, 'contentX') -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setScrollableContentX.call @, val

	Dict.defineProperty @::, 'contentY'

	utils.defProp @::, 'contentY', 'e', utils.lookupGetter(@::, 'contentY')
	, do (_super = utils.lookupSetter @::, 'contentY') -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setScrollableContentY.call @, val