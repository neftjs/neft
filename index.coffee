'use strict'

Impl = require './impl'
Scope = Impl.Scope = require './scope'

exports = module.exports = Object.create Scope.create id: 'main'

if window? and window+'' is '[object Window]'
	windowItem = exports.create 'Item', id: 'window'
	Impl.setWindow Scope.TYPES.Item.GLOBAL_ID_FORMAT(exports.id, windowItem)

exports.createScope = (opts) ->
	Scope.create opts

exports.openScope = (id) ->
	Scope.open id

Object.freeze exports