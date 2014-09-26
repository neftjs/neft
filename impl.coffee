'use strict'

utils = require 'utils'

impl = require './impl/base'

platformImpl = switch true
	when utils.isBrowser and window.HTMLCanvasElement?
		require('./impl/pixi') impl
	when utils.isBrowser
		require('./impl/css') impl
	when utils.isQml
		require('./impl/qml') impl

if platformImpl
	utils.mergeDeep impl, platformImpl

for name, type of impl.Types
	type = impl.Types[name] = type(impl)
	utils.merge impl, type

impl.createItem = (type, id) ->
	item =
		type: type
		elem: null
	impl.Types[type].create id, item
	impl.items[id] = item
	Object.seal item

module.exports = impl