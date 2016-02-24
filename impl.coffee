'use strict'

{assert} = console

utils = require 'utils'
signal = require 'signal'

module.exports = (Renderer) ->
	impl = abstractImpl = require './impl/base'
	impl.Renderer = Renderer
	impl.window = null
	signal.create impl, 'onWindowReady'

	TYPES = ['Item', 'Image', 'Text', 'TextInput', 'Native', 'FontLoader', 'ResourcesLoader',
	         'Device', 'Screen', 'Navigator', 'RotationSensor',

	         'Rectangle', 'Grid', 'Column', 'Row', 'Flow',
	         'Animation', 'PropertyAnimation', 'NumberAnimation',

	         'Scrollable',

	         'AmbientSound']

	ABSTRACT_TYPES =
		'Class': true
		'Transition': true

	platformImpl = do ->
		r = null
		if utils.isBrowser and window.HTMLCanvasElement?
			try r ?= require('./impl/pixi') impl
		if utils.isBrowser
			r ?= require('./impl/css') impl
		if utils.isQt
			r ?= require('./impl/qt') impl
		if utils.isAndroid or utils.isIOS
			r ?= require('./impl/native') impl
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
		unless ABSTRACT_TYPES[type]
			obj = object
			while type and not impl.Types[type]?
				obj = Object.getPrototypeOf(obj)
				type = obj.constructor.__name__

		object._impl = impl.Types[type]?.createData?() or {bindings: null}
		Object.seal object._impl

	impl.initializeObject = (object, type) ->
		unless ABSTRACT_TYPES[type]
			obj = object
			while type and not impl.Types[type]?
				obj = Object.getPrototypeOf(obj)
				type = obj.constructor.__name__

			impl.Types[type]?.create?.call object, object._impl

	impl.setWindow = do (_super = impl.setWindow) -> (item) ->
		utils.defineProperty impl, 'window', utils.ENUMERABLE, item
		_super.call impl, item
		impl.onWindowReady.emit()
		item.keys.focus = true

	impl
