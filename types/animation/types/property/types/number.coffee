'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = (Renderer, Impl) -># class NumberAnimation extends Renderer.PropertyAnimation
	#@__name__ = 'NumberAnimation'

	return {} # TODO

	utils.defProp @::, 'from', 'e', utils.lookupGetter(Renderer.PropertyAnimation::, 'from')
	, do (_super = utils.lookupSetter(Renderer.PropertyAnimation::, 'from')) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val

	utils.defProp @::, 'to', 'e', utils.lookupGetter(Renderer.PropertyAnimation::, 'to')
	, do (_super = utils.lookupSetter(Renderer.PropertyAnimation::, 'to')) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val