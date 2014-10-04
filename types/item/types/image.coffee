'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope, Impl) -> class Image extends Scope.Item
	@__name__ = 'Image'

	utils.defProp @::, 'source', 'e', ->
		Impl.getImageSource @_uid
	, (val) ->
		expect(val).toBe.truthy().string()
		Impl.setImageSource @_uid, val
