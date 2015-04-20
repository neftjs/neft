'use strict'

{assert} = console

utils = require 'utils'
signal = require 'signal'

impl = abstractImpl = require './impl/base'
impl.window = null
signal.create impl, 'windowReady'

TYPES = ['Item', 'Image', 'Text', 'TextInput', 'FontLoader', 'ResourcesLoader',
         'Device', 'Screen', 'Navigator', 'RotationSensor',

         'Rectangle', 'Grid', 'Column', 'Row', 'Flow',
         'Animation', 'PropertyAnimation', 'NumberAnimation',

         'Scrollable',

         'AmbientSound']

platformImpl = do ->
	r = null
	if utils.isBrowser and window.HTMLCanvasElement?
		try r ?= require('./impl/pixi') impl
	if utils.isBrowser
		r ?= require('./impl/css') impl
	if utils.isQml
		r ?= require('./impl/qml') impl
	r

# merge types
for name in TYPES
	type = impl.Types[name] = impl.Types[name](impl)
	utils.merge impl, type

if platformImpl
	utils.mergeDeep impl, platformImpl

# merge types
for name in TYPES
	if typeof impl.Types[name] is 'function'
		type = impl.Types[name] = impl.Types[name](impl)
		utils.merge impl, type

# init createData
for name in TYPES
	if impl.Types[name].createData
		impl.Types[name].createData = impl.Types[name].createData()

# merge modules
for name, extra of impl.Extras
	extra = impl.Extras[name] = extra(impl)
	utils.merge impl, extra

impl.createObject = (object, type) ->
	object._impl = impl.Types[type].createData?() or {}
	Object.preventExtensions object._impl
	impl.Types[type].create.call object, object._impl

impl.setWindow = do (_super = impl.setWindow) -> (item) ->
	utils.defineProperty impl, 'window', utils.ENUMERABLE, item
	_super.call impl, item
	impl.windowReady()
	item.keys.focus = true

module.exports = impl
