'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = (Scope, Impl) -> class NumberAnimation extends Scope.PropertyAnimation
	@__name__ = 'NumberAnimation'

	utils.defProp @::, 'from', 'e', utils.lookupGetter(Scope.PropertyAnimation::, 'from')
	, do (_super = utils.lookupSetter(Scope.PropertyAnimation::, 'from')) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val

	utils.defProp @::, 'to', 'e', utils.lookupGetter(Scope.PropertyAnimation::, 'to')
	, do (_super = utils.lookupSetter(Scope.PropertyAnimation::, 'to')) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val