'use strict'

utils = require 'utils'
Impl = require './impl'

itemUtils = require('./utils/item') exports, Impl

exports.State = require('./types/state') exports, Impl, itemUtils

exports.Item = require('./types/item') exports, Impl, itemUtils
exports.Image = require('./types/item/types/image') exports, Impl, itemUtils
exports.Text = require('./types/item/types/text') exports, Impl, itemUtils
exports.Rectangle = require('./types/item/types/rectangle') exports, Impl, itemUtils
exports.Grid = require('./types/item/types/grid') exports, Impl, itemUtils
exports.Column = require('./types/item/types/column') exports, Impl, itemUtils
exports.Row = require('./types/item/types/row') exports, Impl, itemUtils
exports.Scrollable = require('./types/item/types/scrollable') exports, Impl, itemUtils

exports.Animation = require('./types/animation') exports, Impl
exports.PropertyAnimation = require('./types/animation/types/property') exports, Impl
exports.NumberAnimation = require('./types/animation/types/property/types/number') exports, Impl

utils.defProp exports, 'window', 'c', null, (val) ->
	utils.defProp exports, 'window', 'e', val
	Impl.setWindow val

Object.preventExtensions exports