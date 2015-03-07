'use strict'

{assert} = console

utils = require 'utils'
signal = require 'signal'

impl = abstractImpl = require './impl/base'

TYPES = ['Item', 'Image', 'Text', 'FontLoader', 'Screen'

         'Rectangle', 'Grid', 'Column', 'Row',
         'Animation', 'PropertyAnimation', 'NumberAnimation',

         'Scrollable']

platformImpl = switch true
	# when utils.isBrowser and window.HTMLCanvasElement?
	# 	require('./impl/pixi') impl
	when utils.isBrowser
		require('./impl/css') impl
	when utils.isQml
		require('./impl/qml') impl

abstractTypes = utils.clone impl.Types
if platformImpl
	utils.mergeDeep impl, platformImpl

# merge types
for name in TYPES
	type = impl.Types[name]
	type = impl.Types[name] = type(impl)
	utils.merge impl, type

# add missed function from the abstract impl
for name in TYPES
	type = abstractTypes[name] impl
	for key, func of type
		unless impl.hasOwnProperty(key)
			impl[key] = func

# merge modules
for name, extra of impl.Extras
	extra = impl.Extras[name] = extra(impl)
	utils.merge impl, extra

impl.createItem = (item, type) ->
	item._impl = impl.Types[type].createData?() or {}
	Object.preventExtensions item._impl
	impl.Types[type].create.call item, item._impl

impl.createAnimation = (animation, type) ->
	animation._impl = impl.Types[type].createData?() or {}
	Object.preventExtensions animation._impl
	impl.Types[type].create.call animation, animation._impl

impl.window = null
signal.create impl, 'windowReady'
impl.setWindow = do (_super = impl.setWindow) -> (item) ->
	utils.defineProperty impl, 'window', utils.ENUMERABLE, item
	_super.call impl, item
	impl.windowReady()

module.exports = impl
