Rendering @engine
=================

	'use strict'

	utils = require 'utils'
	signal = require 'signal'
	assert = require 'assert'

	signal.create exports, 'onReady'
	signal.create exports, 'onWindowChange'

	Impl = require('./impl') exports
	itemUtils = exports.itemUtils = require('./utils/item') exports, Impl

	exports.Screen = require('./types/namespace/screen') exports, Impl, itemUtils
	exports.Device = require('./types/namespace/device') exports, Impl, itemUtils
	exports.Navigator = require('./types/namespace/navigator') exports, Impl, itemUtils
	exports.RotationSensor = require('./types/namespace/sensor/rotation') exports, Impl, itemUtils

	exports.Extension = require('./types/extension') exports, Impl, itemUtils
	exports.Class = require('./types/extensions/class') exports, Impl, itemUtils
	exports.Animation = require('./types/extensions/animation') exports, Impl, itemUtils
	exports.PropertyAnimation = require('./types/extensions/animation/types/property') exports, Impl, itemUtils
	exports.NumberAnimation = require('./types/extensions/animation/types/property/types/number') exports, Impl, itemUtils
	exports.Transition = require('./types/extensions/transition') exports, Impl, itemUtils

	exports.Component = require('./types/basics/component') exports, Impl, itemUtils

	exports.Item = require('./types/basics/item') exports, Impl, itemUtils
	exports.Image = require('./types/basics/item/types/image') exports, Impl, itemUtils
	exports.Text = require('./types/basics/item/types/text') exports, Impl, itemUtils
	exports.TextInput = require('./types/basics/item/types/textInput') exports, Impl, itemUtils

	exports.Rectangle = require('./types/shapes/rectangle') exports, Impl, itemUtils

	exports.Grid = require('./types/layout/grid') exports, Impl, itemUtils
	exports.Column = require('./types/layout/column') exports, Impl, itemUtils
	exports.Row = require('./types/layout/row') exports, Impl, itemUtils
	exports.Flow = require('./types/layout/flow') exports, Impl, itemUtils
	exports.Scrollable = require('./types/layout/scrollable') exports, Impl, itemUtils

	exports.AmbientSound = require('./types/sound/ambient') exports, Impl, itemUtils

	exports.ResourcesLoader = require('./types/loader/resources') exports, Impl, itemUtils
	exports.FontLoader = require('./types/loader/font') exports, Impl, itemUtils

	utils.defineProperty exports, 'window', utils.CONFIGURABLE, null, (val) ->
		assert.instanceOf val, exports.Item
		utils.defineProperty exports, 'window', utils.ENUMERABLE, val
		exports.onWindowChange.emit null
		Impl.setWindow val

	utils.defineProperty exports, 'serverUrl', utils.WRITABLE, ''
	utils.defineProperty exports, 'resources', utils.WRITABLE, null

	exports.onReady.emit()

	Object.preventExtensions exports
