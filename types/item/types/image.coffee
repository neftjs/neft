'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

module.exports = (Renderer, Impl, itemUtils) -> class Image extends Renderer.Item
	@__name__ = 'Image'
	@__path__ = 'Renderer.Image'

	@DATA = utils.merge Object.create(Renderer.Item.DATA),
		source: ''

	itemUtils.defineProperty @::, 'source', null, (_super) -> (val) ->
		expect(val).toBe.string()
		_super.call @, val
		Impl.setImageSource.call @, val