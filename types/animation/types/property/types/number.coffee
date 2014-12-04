'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = (Renderer, Impl, itemUtils) -> class NumberAnimation extends Renderer.PropertyAnimation
	@__name__ = 'NumberAnimation'

	utils.defineProperty @::, 'from', utils.ENUMERABLE, utils.lookupGetter(@::, 'from')
	, do (_super = utils.lookupSetter(@::, 'from')) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val

	utils.defineProperty @::, 'to', utils.ENUMERABLE, utils.lookupGetter(@::, 'to')
	, do (_super = utils.lookupSetter(@::, 'to')) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val