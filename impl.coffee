'use strict'

{assert} = console

utils = require 'utils'
signal = require 'signal'

impl = require './impl/base'

TYPES = ['Item', 'Image', 'Text', 'FontLoader'

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

if platformImpl
	utils.mergeDeep impl, platformImpl

# merge types
for name in TYPES
	type = impl.Types[name]
	type = impl.Types[name] = type(impl)
	utils.merge impl, type

# merge modules
for name, extra of impl.Extras
	extra = impl.Extras[name] = extra(impl)
	utils.merge impl, extra

impl.createItem = (item, type) ->
	impl.Types[type].create item

impl.createAnimation = (animation, type) ->
	impl.Types[type].create animation

impl.window = null
signal.create impl, 'windowReady'
impl.setWindow = do (_super = impl.setWindow) -> (item) ->
	utils.defineProperty impl, 'window', utils.ENUMERABLE, item
	_super.call impl, item
	impl.windowReady()

# impl.getItemChildren = do (_super = impl.getItemChildren) -> (id) ->
# 	if container = impl.items[id]?.container
# 		_super container
# 	else
# 		_super id

# impl.getItemParent = do (_super = impl.getItemParent) -> (id) ->
# 	parent = _super id
# 	parent2 = parent and _super parent

# 	if impl.items[parent2]?.container
# 		parent2
# 	else
# 		parent

# impl.setItemParent = do (_super = impl.setItemParent) -> (id, val) ->
# 	parent = impl.items[val]

# 	if container = parent?.container
# 		_super id, container
# 	else
# 		_super id, val

module.exports = impl