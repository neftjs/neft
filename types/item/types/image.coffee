'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Scope, Impl) -> class Image extends Scope.Item
	@__name__ = 'Image'

	@DATA = utils.merge Object.create(Scope.Item.DATA),
		source: ''

	Dict.defineProperty @::, 'source'

	utils.defProp @::, 'source', 'e', utils.lookupGetter(@::, 'source')
	, do (_super = utils.lookupSetter @::, 'source') -> (val) ->
		expect(val).toBe.truthy().string()
		_super.call @, val
		Impl.setImageSource.call @, val