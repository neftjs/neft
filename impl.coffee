'use strict'

{assert} = console

utils = require 'utils'

impl = require './impl/base'

platformImpl = switch true
	# when utils.isBrowser and window.HTMLCanvasElement?
	# 	require('./impl/pixi') impl
	when utils.isBrowser
		require('./impl/css') impl
	when utils.isQml
		require('./impl/qml') impl

if platformImpl
	utils.mergeDeep impl, platformImpl

# merge types
for name, type of impl.Types
	type = impl.Types[name] = type(impl)
	utils.merge impl, type

# merge modules
for name, extra of impl.Extras
	extra = impl.Extras[name] = extra(impl)
	utils.merge impl, extra

impl.createItem = (type, id) ->
	impl.items[id] = item =
		type: type
		elem: null
	impl.Types[type].create id, item
	Object.seal item

impl.createAnimation = (type, id) ->
	impl.animations[id] = animation =
		type: type
	impl.Types[type].create id, animation
	Object.seal animation

impl.window = ''
impl.setWindow = do (_super = impl.setWindow) -> (id) ->
	assert impl.window is ''
	impl.window = id
	_super.call impl, id

module.exports = impl